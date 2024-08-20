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
