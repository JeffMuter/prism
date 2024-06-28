package util

import (
	"fmt"
	"os"
	"path/filepath"
)

func getAbsoluteFilePath(relativeFilepath string) (string, error) {
	workingDir, err := os.Getwd()
	if err != nil {
		return "", fmt.Errorf("Couldn't print working dir: %v\nRel Path ParaM: %s", err, relativeFilePath)
	}
	return filepath.Join(workingDir, relativeFilepath), nil
}
