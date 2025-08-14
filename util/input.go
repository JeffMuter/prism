package util

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"strconv"
	"strings"
)

// InputReader provides an interface for reading user input, allowing for dependency injection
// in functions that need user interaction. This enables testing with mock input instead of
// requiring actual user input from stdin.
type InputReader interface {
	// ReadCommandInput reads a single line of input from the user and returns it trimmed of whitespace
	ReadCommandInput() (string, error)
	
	// ReadNumericSelection reads user input and validates it as a numeric selection within bounds
	// options parameter represents the maximum number of valid choices (0 to options-1)
	ReadNumericSelection(options int) (int, error)
	
	// PrintNumericSelection displays a numbered list of printable items and reads the user's selection
	// Returns the selected index as an integer
	PrintNumericSelection(printables []Printable) (int, error)
}

// StdinReader implements InputReader by reading from standard input (os.Stdin).
// This is the production implementation used for actual user interaction.
type StdinReader struct {
	reader *bufio.Reader
}

// NewStdinReader creates a new StdinReader that reads from os.Stdin
func NewStdinReader() *StdinReader {
	return &StdinReader{
		reader: bufio.NewReader(os.Stdin),
	}
}

// ReadCommandInput reads a line from stdin and returns it trimmed of whitespace
func (r *StdinReader) ReadCommandInput() (string, error) {
	input, err := r.reader.ReadString('\n')
	if err != nil {
		return "", fmt.Errorf("invalid input: %w", err)
	}
	return strings.TrimSpace(input), nil
}

// ReadNumericSelection reads input and validates it as a numeric choice within the given range
func (r *StdinReader) ReadNumericSelection(options int) (int, error) {
	input, err := r.ReadCommandInput()
	if err != nil {
		return -1, err
	}
	
	// Convert input to int
	intInput, err := strconv.ParseInt(input, 10, 64)
	if err != nil {
		return -1, err
	}
	
	// Make sure input isn't out of bounds
	if intInput < 0 || intInput >= int64(options) {
		return -1, fmt.Errorf("input was too low or too high")
	}
	
	return int(intInput), nil
}

// PrintNumericSelection displays numbered options and reads the user's selection
func (r *StdinReader) PrintNumericSelection(printables []Printable) (int, error) {
	// Print the printable items in numbered format
	if len(printables) == 0 {
		fmt.Println("no values to print :(")
		return 0, fmt.Errorf("prinumsel error, len of printables == 0")
	}
	
	for i, printable := range printables {
		fmt.Printf("%d: %s\n", i, printable.StringToPrint())
	}
	
	// Read and parse user selection
	stringSelection, err := r.ReadCommandInput()
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error getting input from user: %w", err)
	}
	
	numericSelection, err := strconv.Atoi(stringSelection)
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error parsing input of, %s to int: %w", stringSelection, err)
	} else if numericSelection < 0 || numericSelection > len(printables) {
		return 0, fmt.Errorf("error, num of options, %d, input, %d: %w", len(printables), numericSelection, err)
	}
	
	return numericSelection, nil
}

// MockReader implements InputReader for testing by providing pre-defined responses.
// This allows tests to simulate user input without requiring actual user interaction.
type MockReader struct {
	inputs []string // Pre-defined inputs to return in sequence
	index  int      // Current position in the inputs slice
}

// NewMockReader creates a new MockReader with the provided input sequence
func NewMockReader(inputs []string) *MockReader {
	return &MockReader{
		inputs: inputs,
		index:  0,
	}
}

// ReadCommandInput returns the next pre-defined input from the sequence
func (m *MockReader) ReadCommandInput() (string, error) {
	if m.index >= len(m.inputs) {
		return "", io.EOF
	}
	
	result := m.inputs[m.index]
	m.index++
	return result, nil
}

// ReadNumericSelection simulates reading and validating numeric input from the mock sequence
func (m *MockReader) ReadNumericSelection(options int) (int, error) {
	input, err := m.ReadCommandInput()
	if err != nil {
		return -1, err
	}
	
	// Convert input to int
	intInput, err := strconv.ParseInt(input, 10, 64)
	if err != nil {
		return -1, err
	}
	
	// Make sure input isn't out of bounds
	if intInput < 0 || intInput >= int64(options) {
		return -1, fmt.Errorf("input was too low or too high")
	}
	
	return int(intInput), nil
}

// PrintNumericSelection simulates printing options and reading selection from mock inputs
// Note: In mock mode, the printing still happens but the input comes from the mock sequence
func (m *MockReader) PrintNumericSelection(printables []Printable) (int, error) {
	// Print the printable items in numbered format (still display for test visibility)
	if len(printables) == 0 {
		fmt.Println("no values to print :(")
		return 0, fmt.Errorf("prinumsel error, len of printables == 0")
	}
	
	for i, printable := range printables {
		fmt.Printf("%d: %s\n", i, printable.StringToPrint())
	}
	
	// Read from mock inputs instead of user
	stringSelection, err := m.ReadCommandInput()
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error getting input from user: %w", err)
	}
	
	numericSelection, err := strconv.Atoi(stringSelection)
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error parsing input of, %s to int: %w", stringSelection, err)
	} else if numericSelection < 0 || numericSelection > len(printables) {
		return 0, fmt.Errorf("error, num of options, %d, input, %d: %w", len(printables), numericSelection, err)
	}
	
	return numericSelection, nil
}