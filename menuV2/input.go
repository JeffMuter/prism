package menuV2

import (
	"os"
	"os/exec"
	"time"
)

// InputType represents the type of input received
type InputType int

const (
	NumericInput InputType = iota
	ArrowUp
	ArrowDown
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
	cmd := exec.Command("stty", "-echo", "cbreak")
	cmd.Stdin = os.Stdin
	return cmd.Run()
}

// disableRawMode restores normal terminal mode
func disableRawMode() error {
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
	
	// Start goroutine to read character
	go func() {
		var buf [1]byte
		n, err := os.Stdin.Read(buf[:])
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
		return 0, os.ErrDeadlineExceeded
	}
}

// drainInputBuffer reads any remaining characters from stdin with a short timeout
// to clean up leftover bytes from incomplete escape sequences
func drainInputBuffer() {
	for {
		_, err := readSingleCharWithTimeout(10 * time.Millisecond)
		if err != nil {
			break // No more characters or timeout
		}
	}
}

// GetInput reads and categorizes user input
func GetInput() (Input, error) {
	if err := enableRawMode(); err != nil {
		return Input{Type: InvalidInput}, err
	}
	defer disableRawMode()

	// Small delay to ensure terminal mode transitions are stable
	time.Sleep(20 * time.Millisecond)

	char, err := readSingleChar()
	if err != nil {
		return Input{Type: InvalidInput}, err
	}

	// Handle escape sequences (arrow keys) and standalone ESC
	if char == 27 { // ESC
		// Try to read next character with a reasonable timeout
		char2, err := readSingleCharWithTimeout(50 * time.Millisecond)
		if err != nil { // Timeout - standalone ESC
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		if char2 != 91 { // Not '[' - not an arrow key sequence
			drainInputBuffer() // Clean up any remaining characters
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		// Read the third character for arrow key direction
		char3, err := readSingleCharWithTimeout(50 * time.Millisecond)
		if err != nil { // Timeout - incomplete sequence, treat as back
			drainInputBuffer() // Clean up the '[' and any other chars
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
		
		switch char3 {
		case 65: // Up arrow (ESC[A)
			return Input{Type: ArrowUp}, nil
		case 66: // Down arrow (ESC[B)
			return Input{Type: ArrowDown}, nil
		default:
			// Unknown escape sequence - treat as back command
			drainInputBuffer() // Clean up any remaining characters
			return Input{Type: BackCommand, Value: string(char)}, nil
		}
	}

	// Handle enter key
	if char == 13 || char == 10 { // CR or LF
		return Input{Type: EnterKey}, nil
	}

	// Handle numbers
	if char >= '1' && char <= '9' {
		return Input{Type: NumericInput, Value: string(char)}, nil
	}

	// Handle other characters
	switch char {
	case 'b', 'B':
		return Input{Type: BackCommand}, nil
	case 'm', 'M':
		return Input{Type: MapCommand}, nil
	default:
		return Input{Type: InvalidInput, Value: string(char)}, nil
	}
}