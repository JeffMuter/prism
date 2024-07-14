package util

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"strings"
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

func ReadUserInput() string {

	reader := bufio.NewReader(os.Stdin)

	input, err := reader.ReadString('\n')
	if err != nil {
		fmt.Println("Invalid input: ", err)
	}
	return strings.TrimSpace(input)
}
