package util

import (
	"fmt"
	"math"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
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

// Global default reader for backward compatibility with existing code
// This allows existing functions to continue working while we gradually migrate to the interface
var defaultReader InputReader = NewStdinReader()

// ReadCommandInput provides backward compatibility wrapper around the InputReader interface
// Existing code can continue using this function while new code should use InputReader directly
func ReadCommandInput() (string, error) {
	return defaultReader.ReadCommandInput()
}

// ReadNumericSelection provides backward compatibility wrapper around the InputReader interface
// Existing code can continue using this function while new code should use InputReader directly  
func ReadNumericSelection(options int) (int, error) {
	return defaultReader.ReadNumericSelection(options)
}

// PrintNumericSelection provides backward compatibility wrapper around the InputReader interface
// Existing code can continue using this function while new code should use InputReader directly
func PrintNumericSelection(printables []Printable) (int, error) {
	return defaultReader.PrintNumericSelection(printables)
}


