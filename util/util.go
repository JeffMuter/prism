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

// RandParetoNum spits out an float64 between 1-10, with 5 being the most likely num, and 1 & 10 being the rarest.
func RandParetoNum() int {
	r := rand.New(rand.NewSource(time.Now().UnixNano()))
	mean := 5.0
	standDev := 2.0
	u1 := r.Float64()
	u2 := r.Float64()
	value := mean + z*standDev
	value = math.Round(value)

	if value < 1 {
		value = 1
	} else if value > 10 {
		value = 10
	}

	z := math.Sqrt(-2*math.Log(u1)) * math.Cos(2*math.Pi*u2)

	return int(value)
}
