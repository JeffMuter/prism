package render

import (
	"bufio"
	"fmt"
	"os"
	"prism/nodes"
	"prism/operating_system"
	"prism/user"
	"prism/util"
	"sort"
)

type object struct {
	id          int
	userId      int
	objectId    int
	name        string
	latitude    float64
	longitude   float64
	objectType  string
	description string
	artFileName string
	art         Art
}

type Art struct {
	width  int
	height int
	art    []string
}

func PaintScreen(thisUser user.User) [][]rune {

	//get terminal info
	termWidth, termHeight, err := operating_system.GetTerminalSize()
	if err != nil {
		fmt.Println("issue getting screen dimensions for rendering")
	}

	// get user location
	thisUser.Latitude, thisUser.Longitude, err = user.Ping()
	if err != nil {
		fmt.Println("issue getting user position for rendering...")
	}

	// get obj locations
	var locationsToRender []nodes.Location

	// get locations which act as objects
	nodes.GetNodesRelevantToUserFromDb(thisUser)

	// get each obj coordinates
	locationsToRender, err =
		findLocationsCoordinates(thisUser, locationsToRender, termWidth, termHeight)
	if err != nil {
		fmt.Println(err)
	}

	// create canvas
	canvas := make([][]rune, termHeight)
	for i := range canvas {
		canvas[i] = make([]rune, termWidth)
		for j := range canvas[i] {
			canvas[i][j] = ' '
		}
	}
	// order objects
	objectsToRender = orderObjectSlice(objectsToRender)

	// place objects on the canvas
	addObjectsToCanvas(canvas, objectsToRender)

	for _, line := range canvas {
		fmt.Println(string(line))
	}

	return canvas
}

func findLocationsCoordinates(user user.User, unfilteredLocations []nodes.Location, scrWidth, scrHeight int) ([]nodes.Location, error) {
	var filteredLocations []nodes.Location

	canvasDegreeRange := 4

	for i := range unfilteredLocations {

		// defines max min values in degrees for the canvas
		// should canvas be a type and we set those?
		maxLat := user.Latitude + float64(canvasDegreeRange)/float64(2)
		minLat := user.Latitude - float64(canvasDegreeRange)/float64(2)
		maxLong := user.Longitude + float64(canvasDegreeRange)/float64(2)
		minLong := user.Longitude - float64(canvasDegreeRange)/float64(2)

		// distance represents the unit of distance each char on the canvas represents in degree distance.
		// if the canvas degree range is 10, and the screen width is 10, then every char on the screen is 1 lat.
		var horizontalDistancePerChar = float64(canvasDegreeRange) / float64(scrWidth)
		var verticalDistancePerChar = float64(canvasDegreeRange) / float64(scrHeight)

		// if out of bounds, don't add the object to the filtered slice
		if unfilteredLocations[i].Latitude > maxLat || unfilteredLocations[i].Latitude < minLat || unfilteredLocations[i].Longitude > maxLong || unfilteredLocations[i].Longitude < minLong {
			continue
		}
		// calc is wrong, creating a 90degree rotation incorrectly.
		unfilteredLocations[i].XCoordinate = int((unfilteredLocations[i].Longitude - minLong) / horizontalDistancePerChar)
		unfilteredLocations[i].YCoordinate = scrHeight - 1 - int((unfilteredLocations[i].Latitude-minLat)/verticalDistancePerChar)
		filteredLocations = append(filteredLocations, unfilteredLocations[i])
	}

	return objects, nil
}

func addObjectsToCanvas(canvas [][]rune, objects []object) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	for _, object := range objects {
		object.art = object.art.UpdateArtDimensions(object.art)
		for y := object.art.height - 1; y >= 0; y-- {
			artY := object.yCoordinate - (object.art.height - 1 - y)
			if artY < 0 || artY >= canvasHeight {
				// Skip this line of the art if it's out of canvas bounds
				continue
			}

			for x := 0; x < object.art.width; x++ {
				artX := object.xCoordinate + x
				if artX < 0 || artX >= canvasWidth {
					// Skip this column of the art if it's out of canvas bounds
					continue
				}

				if y < 0 || y >= len(object.art.art) || x < 0 || x >= len(object.art.art[y]) {
					// Ensure we're within the bounds of the art
					continue
				}

				// Draw the art on the canvas
				canvas[artY][artX] = rune(object.art.art[y][x])
			}
		}
	}
}

// GetObjectArt send the name of the .txt file, returns slice of strings to represent an objects art.
func GetObjectArt(artName string) []string {
	// we want to take the path, go to our assets folder
	var artSlice []string
	txtFilePath, err := util.GetAbsoluteFilepath("/assets/" + artName + ".txt")
	if err != nil {
		fmt.Println("txtFilePath err:", txtFilePath, err)
	}
	// get file
	fmt.Println(txtFilePath)

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

	return artSlice
}

// UpdateArtDimensions takes in an art object, and adds the dimension fields of height and width
func (Art) UpdateArtDimensions(art Art) Art {
	art.height = len(art.art)
	art.width = len(art.art[0]) + 2
	return art
}

// orderObjectSlice takes a slice of object, and returns them, where the ycoordinate sorts them.
// intention being to have the object closest to the user printed last, and overtop of all other objects that have
// coordinates closer to the top of the rendered screen.
func orderObjectSlice(objects []object) []object {

	sort.SliceStable(objects, func(i, j int) bool {
		if objects[i].yCoordinate == objects[j].yCoordinate {
			return objects[i].xCoordinate < objects[j].xCoordinate
		}
		return objects[i].yCoordinate < objects[j].yCoordinate
	})
	return objects
}
