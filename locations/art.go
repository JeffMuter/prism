package locations

import (
	"bufio"
	"fmt"
	"os"
	"prism/util"
)

type Art struct {
	Width  int
	Height int
	Art    []string
}

// SetLocationsArt send the name of the .txt file, returns slice of strings to represent an objects art.
func SetLocationsArt(locations []Location) []Location {
	var locationsWithArt []Location
	for _, location := range locations {
		// we want to take the path, go to our assets folder
		var artSlice []string
		var artName = location.ArtFileName
		txtFilePath, err := util.GetAbsoluteFilepath("/assets/" + artName + ".txt")
		if err != nil {
			fmt.Println("txtFilePath err:", txtFilePath, err)
		}
		// get file
		file, err := os.Open(txtFilePath)
		if err != nil {
			fmt.Println(err)
		}
		defer file.Close()

		// create scanner to read the file
		scanner := bufio.NewScanner(file)

		// read lines of txt file.
		for scanner.Scan() {
			artSlice = append(artSlice, scanner.Text())
		}

		// check for scanning errors
		if err := scanner.Err(); err != nil {
			fmt.Println(err)
		}

		// make an Art struct from the slice of strings, set it to location
		location.Art = CreateArtFromStringSlice(artSlice)

		// add this location to the locations slice.
		locationsWithArt = append(locationsWithArt, location)
	}
	return locationsWithArt
}

// UpdateArtDimensions takes in an art object, and adds the dimension fields of height and width
func (art Art) UpdateArtDimensions() Art {
	art.Height = len(art.Art)
	maximum := 0
	for _, line := range art.Art {
		if len(line) > maximum {
			maximum = len(line)
		}
	}
	art.Width = maximum

	return art
}

func CreateArtFromStringSlice(artSlice []string) Art {
	var thisArt = Art{Art: artSlice}
	thisArt = thisArt.UpdateArtDimensions()

	return thisArt
}
