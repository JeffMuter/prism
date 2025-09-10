package menuV2

import (
	"fmt"
	"os"
	"testing"
	"time"
)

func TestInputHandling(t *testing.T) {
	// Test that input handling functions are properly defined
	// This is a basic smoke test since we can't easily test interactive input
	err := enableRawMode()
	if err != nil {
		t.Logf("enableRawMode failed (expected in test environment): %v", err)
	}
	
	err = disableRawMode()
	if err != nil {
		t.Logf("disableRawMode failed (expected in test environment): %v", err)
	}
}

func TestInputTypes(t *testing.T) {
	// Test that our input types are properly defined
	tests := []struct {
		name  string
		input InputType
	}{
		{"NumericInput", NumericInput},
		{"ArrowUp", ArrowUp},
		{"ArrowDown", ArrowDown},
		{"EnterKey", EnterKey},
		{"BackCommand", BackCommand},
		{"MapCommand", MapCommand},
		{"InvalidInput", InvalidInput},
	}
	
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			// Just verify the constants exist and have expected values
			if int(tt.input) < 0 {
				t.Errorf("Input type %s has negative value: %d", tt.name, tt.input)
			}
		})
	}
}

// TestKeySequences simulates different key press scenarios
func TestKeySequences(t *testing.T) {
	fmt.Println("=== Testing Key Sequence Parsing ===")
	
	tests := []struct {
		name     string
		sequence []byte
		expected InputType
	}{
		{
			name:     "Standalone ESC",
			sequence: []byte{27}, // Just ESC
			expected: BackCommand,
		},
		{
			name:     "Up Arrow",
			sequence: []byte{27, 91, 65}, // ESC[A
			expected: ArrowUp,
		},
		{
			name:     "Down Arrow", 
			sequence: []byte{27, 91, 66}, // ESC[B
			expected: ArrowDown,
		},
		{
			name:     "Right Arrow",
			sequence: []byte{27, 91, 67}, // ESC[C  
			expected: ArrowRight,
		},
		{
			name:     "Left Arrow",
			sequence: []byte{27, 91, 68}, // ESC[D
			expected: ArrowLeft,
		},
	}
	
	for _, test := range tests {
		fmt.Printf("\n--- Testing: %s ---\n", test.name)
		result := simulateKeySequence(test.sequence)
		
		fmt.Printf("Expected: %v, Got: %v\n", test.expected, result.Type)
		
		if result.Type != test.expected {
			t.Errorf("%s failed: expected %v, got %v", test.name, test.expected, result.Type)
		} else {
			fmt.Printf("✓ %s passed\n", test.name)
		}
	}
}

// simulateKeySequence sends a sequence of bytes to stdin and reads the result
func simulateKeySequence(sequence []byte) Input {
	// Create a pipe to simulate stdin
	r, w, err := os.Pipe()
	if err != nil {
		panic(err)
	}
	
	// Save original stdin
	originalStdin := os.Stdin
	defer func() { os.Stdin = originalStdin }()
	
	// Replace stdin with our pipe
	os.Stdin = r
	
	// Write the sequence to the pipe with proper timing
	go func() {
		defer w.Close()
		
		if len(sequence) == 1 {
			// Single character - write immediately
			w.Write(sequence)
		} else {
			// Multi-character sequence - write with realistic timing
			for i, b := range sequence {
				w.Write([]byte{b})
				if i < len(sequence)-1 {
					// Small delay between characters to simulate real terminal timing
					time.Sleep(5 * time.Millisecond)
				}
			}
		}
	}()
	
	// Read the input using our function
	input, err := GetInput()
	if err != nil {
		panic(err)
	}
	
	return input
}

// TestRealScenario simulates the exact user scenario described
func TestRealScenario(t *testing.T) {
	fmt.Println("\n=== Testing Real User Scenario ===")
	fmt.Println("Simulating: ESC pressed, then Up Arrow pressed as separate actions")
	
	// First: standalone ESC
	fmt.Println("\n1. Pressing ESC alone:")
	escResult := simulateKeySequence([]byte{27})
	fmt.Printf("   Result: %v (expected: BackCommand)\n", escResult.Type)
	
	// Then: Up arrow as a separate press  
	fmt.Println("\n2. Then pressing Up Arrow:")
	arrowResult := simulateKeySequence([]byte{27, 91, 65})
	fmt.Printf("   Result: %v (expected: ArrowUp)\n", arrowResult.Type)
	
	fmt.Println("\nThis simulates what happens when user presses ESC, releases it,")
	fmt.Println("then presses Up Arrow - two separate GetInput() calls")
}