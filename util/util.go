package util

import (
	"bufio"
	"fmt"
	"math"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
	"strings"
	"time"
)

// Printable is mostly used for the default printing pattern of a struct. Such as the name of a location.
type Printable interface {
	StringToPrint() string
}

func GetAbsoluteFilepath(relativeFilepath string) (string, error) {
	workingDir, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("Couldn't print working dir: %v\nRel Path ParaM: %s", err, relativeFilepath)
	}
	return filepath.Join(workingDir, relativeFilepath), nil
}

func GetMaxLocationRanges(lRange, lat, long float64) (float64, float64, float64, float64) {
	var minLat, maxLat, minLong, maxLong float64

	minLat = lat - lRange
	maxLat = lat + lRange
	minLong = long - lRange
	maxLong = long + lRange

	return minLat, maxLat, minLong, maxLong
}

func ReadCommandInput() (string, error) {

	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	return strings.TrimSpace(input), nil
}

// RandNormalizedNum spits out an integer between min and max, where half of max is the average outcome. between being the most likely num, and 1 & 10 being the rarest.
func RandNormalizedNum(rand *rand.Rand, min, max int) int {
	var mean = float64(min+max) / 2
	standDev := float64(max-min) / 6
	for {
		u1 := rand.Float64()
		u2 := rand.Float64()
		z := math.Sqrt(-2*math.Log(u1)) * math.Cos(2*math.Pi*u2)
		value := mean + z*standDev
		value = math.Round(value)

		if value >= float64(min) && value <= float64(max) {
			return int(value)
		}
	}
}

// RandNumBetween takes two ints, and produces a random number between the two.
func RandNumBetween(rand *rand.Rand, min, max int) int {
	value := rand.Intn(max-min+1) + min
	return value
}

func FindIntFromString(s string) (int, error) {
	if number, err := strconv.Atoi(s); err == nil {
		return number, nil
	}
	return 0, fmt.Errorf("could not find pure int in string value\n")
}

// InitializeTime creates a *rand.Rand based on the time, to use to generate random numbers.
func InitializeTime() *rand.Rand {
	return rand.New(rand.NewSource(time.Now().UnixNano()))
}

// ReadNumericSelection() is a func that takes in a max num, like 3, and tha assumption is you've already printed a list of something, and you're passing in the max # the user could select. Here we read the input of the user, check, and convert that string to an int, so you can option[result] to find the user's selection.
func ReadNumericSelection(options int) (int, error) {
	input, err := ReadCommandInput()
	if err != nil {
		return -1, err
	}
	// convert input to int
	intInput, err := strconv.ParseInt(input, 10, 64)
	if err != nil {
		return -1, err
	}

	// make sure input isn't out of bounds.
	if intInput < 0 || intInput >= int64(options) {
		return -1, fmt.Errorf("input was too low or too high")
	}

	return int(intInput), nil
}

func PrintNumericSelection(printables []Printable) (int, error) {
	// this part prints the printable in the format we like
	if len(printables) == 0 {
		fmt.Println("no values to print :(")
		return 0, fmt.Errorf("prinumsel error, len of printables == 0")
	}

	for i, printable := range printables {
		fmt.Printf("%d: %s\n", i, printable.StringToPrint())
	}

	// second part reads input, converts to int
	stringSelection, err := ReadCommandInput()
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error getting input from user: %w", err)
	}

	numericSelection, err := strconv.Atoi(stringSelection)
	if err != nil {
		return 0, fmt.Errorf("prinnumsel error parsing input of, %s to int: %w,", stringSelection, err)
	} else if numericSelection < 0 || numericSelection > len(printables) {
		return 0, fmt.Errorf("error, num of options, %d, input, %d: %w", len(printables), numericSelection, err)
	}

	return numericSelection, nil
}
