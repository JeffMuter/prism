package menuV2

import (
	"fmt"
	"os"
	"os/exec"
	"time"
)

var lastInputTime time.Time
var lastWasESC bool

// InputType represents the type of input received
type InputType int

const (
	NumericInput InputType = iota
	ArrowUp
	ArrowDown
	ArrowLeft
	ArrowRight
	EnterKey
	BackCommand
	MapCommand
	InvalidInput
)

// Input represents user input with its type and value
type Input struct {
	Type  InputType
	Value string
}

// enableRawMode puts terminal in raw mode for arrow key detection
func enableRawMode() error {
	fmt.Printf("DEBUG: Enabling raw mode\n")
	cmd := exec.Command("stty", "-echo", "cbreak")
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

// disableRawMode restores normal terminal mode
func disableRawMode() error {
	fmt.Printf("DEBUG: Disabling raw mode\n")
	cmd := exec.Command("stty", "echo", "-cbreak")
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

// readSingleChar reads a single character from stdin
func readSingleChar() (byte, error) {
	var buf [1]byte
	_, err := os.Stdin.Read(buf[:])
	return buf[0], err
}

// readSingleCharWithTimeout reads a single character with timeout using goroutines
func readSingleCharWithTimeout(timeout time.Duration) (byte, error) {
	ch := make(chan byte, 1)
	errCh := make(chan error, 1)
	done := make(chan bool, 1)
	
	// Start goroutine to read character
	go func() {
		var buf [1]byte
		n, err := os.Stdin.Read(buf[:])
		
		select {
		case <-done:
			// Timeout occurred, don't send anything
			return
		default:
		}
		
		if err != nil {
			errCh <- err
			return
		}
		if n > 0 {
			ch <- buf[0]
		}
	}()
	
	// Wait for either character or timeout
	select {
	case char := <-ch:
		return char, nil
	case err := <-errCh:
		return 0, err
	case <-time.After(timeout):
		done <- true // Signal goroutine to stop
		return 0, os.ErrDeadlineExceeded
	}
}

// drainInputBuffer reads any remaining characters from stdin with a short timeout
// to clean up leftover bytes from incomplete escape sequences
func drainInputBuffer() {
	fmt.Printf("DEBUG: Draining input buffer...\n")
	count := 0
	for {
		char, err := readSingleCharWithTimeout(50 * time.Millisecond)
		if err != nil {
			break // No more characters or timeout
		}
		fmt.Printf("DEBUG: Drained char: %d (0x%02X) '%c'\n", char, char, char)
		count++
		if count > 10 { // Safety limit
			break
		}
	}
	fmt.Printf("DEBUG: Drained %d characters from buffer\n", count)
}

// GetInput reads and categorizes user input
func GetInput() (Input, error) {
	if err := enableRawMode(); err != nil {
		return Input{Type: InvalidInput}, err
	}
	defer func() {
		disableRawMode()
		// Small delay to let terminal stabilize between input reads
		time.Sleep(5 * time.Millisecond)
	}()


	char, err := readSingleChar()
	if err != nil {
		return Input{Type: InvalidInput}, err
	}

	fmt.Printf("DEBUG: First char read: %d (0x%02X) '%c'\n", char, char, char)

	// Handle escape sequences (arrow keys) and standalone ESC
	if char == 27 { // ESC
		currentTime := time.Now()
		
		// Check if this ESC comes very soon after a previous ESC (likely a user ESC + arrow combo)
		if lastWasESC && currentTime.Sub(lastInputTime) < 500*time.Millisecond {
			fmt.Printf("DEBUG: ESC detected soon after previous ESC - likely arrow key, consuming orphaned ESC\n")
			lastWasESC = false
			lastInputTime = currentTime
			return Input{Type: InvalidInput, Value: string(char)}, nil // Ignore this ESC
		}
		
		fmt.Printf("DEBUG: ESC detected, checking for immediate follow-up...\n")
		
		// Use a very short timeout to distinguish standalone ESC from arrow keys
		char2, err := readSingleCharWithTimeout(50 * time.Millisecond)
		if err != nil { // Timeout - standalone ESC
			fmt.Printf("DEBUG: No follow-up char - standalone ESC -> BackCommand\n")
			lastWasESC = true
			lastInputTime = currentTime
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		fmt.Printf("DEBUG: Got follow-up char: %d (0x%02X) '%c'\n", char2, char2, char2)
		
		if char2 != 91 { // Not '[' - not a standard arrow key sequence
			fmt.Printf("DEBUG: Not '[' - unknown ESC sequence -> BackCommand\n")
			lastWasESC = true
			lastInputTime = currentTime
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		// Got ESC[ - now read the direction character
		char3, err := readSingleChar()
		if err != nil {
			fmt.Printf("DEBUG: Failed to read direction char: %v -> BackCommand\n", err)
			lastWasESC = true
			lastInputTime = currentTime
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		fmt.Printf("DEBUG: Direction char: %d (0x%02X) '%c'\n", char3, char3, char3)
		
		lastWasESC = false
		lastInputTime = currentTime
		
		switch char3 {
		case 65: // Up arrow (ESC[A)
			fmt.Printf("DEBUG: Complete up arrow sequence -> ArrowUp\n")
			return Input{Type: ArrowUp}, nil
		case 66: // Down arrow (ESC[B)
			fmt.Printf("DEBUG: Complete down arrow sequence -> ArrowDown\n")
			return Input{Type: ArrowDown}, nil
		case 67: // Right arrow (ESC[C)
			fmt.Printf("DEBUG: Complete right arrow sequence -> ArrowRight\n")
			return Input{Type: ArrowRight}, nil
		case 68: // Left arrow (ESC[D)
			fmt.Printf("DEBUG: Complete left arrow sequence -> ArrowLeft\n")
			return Input{Type: ArrowLeft}, nil
		default:
			fmt.Printf("DEBUG: Unknown direction in ESC sequence (%d) -> BackCommand\n", char3)
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
	}

	// Update state for non-ESC inputs
	lastWasESC = false
	lastInputTime = time.Now()

	// Handle enter key
	if char == 13 || char == 10 { // CR or LF
		fmt.Printf("DEBUG: Enter key detected -> EnterKey\n")
		return Input{Type: EnterKey}, nil
	}

	// Handle numbers
	if char >= '1' && char <= '9' {
		fmt.Printf("DEBUG: Number '%c' detected -> NumericInput\n", char)
		return Input{Type: NumericInput, Value: string(char)}, nil
	}

	// Handle other characters
	switch char {
	case 'b', 'B':
		fmt.Printf("DEBUG: 'b'/'B' detected -> BackCommand\n")
		return Input{Type: BackCommand}, nil
	case 'm', 'M':
		fmt.Printf("DEBUG: 'm'/'M' detected -> MapCommand\n")
		return Input{Type: MapCommand}, nil
	default:
		fmt.Printf("DEBUG: Other char '%c' (%d) detected -> InvalidInput\n", char, char)
		return Input{Type: InvalidInput, Value: string(char)}, nil
	}
}