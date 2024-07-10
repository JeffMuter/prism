package render

import (
	"fmt"
	"prism/nodes"
	"prism/operating_system"
	"prism/user"
	"prism/util"
	"sort"
)

func PaintScreen(thisUser user.User) [][]rune {

	//get terminal info
	termWidth, termHeight, err := operating_system.GetTerminalSize()
	if err != nil {
		fmt.Println("issue getting screen dimensions for rendering")
	}

	// get locations near user
	var locationsToRender []nodes.Location = nodes.GetNodesRelevantToUserFromDb(thisUser)

	// set each locations coordinates
	locationsToRender, err =
		findLocationsCoordinates(thisUser, locationsToRender, termWidth, termHeight)
	if err != nil {
		fmt.Println(err)
	}
	// set each location's art file from their ArtName
	locationsToRender = nodes.SetLocationsArt(locationsToRender)

	// create canvas
	canvas := make([][]rune, termHeight)
	for i := range canvas {
		canvas[i] = make([]rune, termWidth)
		for j := range canvas[i] {
			canvas[i][j] = ' '
		}
	}
	// order locations
	locationsToRender = orderLocationsSlice(locationsToRender)

	// place objects on the canvas
	addLocationsToCanvas(canvas, locationsToRender)

	for _, line := range canvas {
		fmt.Println(string(line))
	}

	return canvas
}

func findLocationsCoordinates(user user.User, unfilteredLocations []nodes.Location, scrWidth, scrHeight int) ([]nodes.Location, error) {
	var filteredLocations []nodes.Location

	var degreeRange float64 = 2

	for _, location := range unfilteredLocations {
		// defines max min values in degrees for the canvas
		minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(degreeRange, user.Latitude, user.Longitude)
		// if out of bounds, don't add the object to the filtered slice
		if location.Latitude > maxLat || location.Latitude < minLat || location.Longitude > maxLong || location.Longitude < minLong {
			continue
		}

		// distance represents the unit of distance each char on the canvas represents in degree distance.
		// if the canvas degree range is 10, and the screen width is 10, then every char on the screen is 1 lat.
		var horizontalIndex int = int((location.Longitude - minLong) / (degreeRange * 2) * float64(scrWidth))
		var verticalIndex int = int((location.Latitude - minLat) / (degreeRange * 2) * float64(scrHeight))

		location.XCoordinate = horizontalIndex
		location.YCoordinate = verticalIndex
		filteredLocations = append(filteredLocations, location)
	}

	return filteredLocations, nil
}

func addLocationsToCanvas(canvas [][]rune, locations []nodes.Location) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	for _, location := range locations {
		for y := location.Art.Height - 1; y >= 0; y-- {
			artY := location.YCoordinate - (location.Art.Height - 1 - y)
			if artY < 0 || artY >= canvasHeight {
				// Skip this line of the art if it's out of canvas bounds
				continue
			}

			for x := 0; x < location.Art.Width; x++ {
				artX := location.XCoordinate + x
				if artX < 0 || artX >= canvasWidth {
					// Skip this column of the art if it's out of canvas bounds
					continue
				}

				if y < 0 || y >= len(location.Art.Art) || x < 0 || x >= len(location.Art.Art[y]) {
					// Ensure we're within the bounds of the art
					continue
				}

				// Draw the art on the canvas
				canvas[artY][artX] = rune(location.Art.Art[y][x])
			}
		}
	}
}

// orderObjectSlice takes a slice of object, and returns them, where the Ycoordinate sorts them.
// intention being to have the object closest to the user printed last, and overtop of all other objects that have
// coordinates closer to the top of the rendered screen.
func orderLocationsSlice(locations []nodes.Location) []nodes.Location {

	sort.SliceStable(locations, func(i, j int) bool {
		if locations[i].YCoordinate == locations[j].YCoordinate {
			return locations[i].XCoordinate < locations[j].XCoordinate
		}
		return locations[i].YCoordinate < locations[j].YCoordinate
	})
	return locations
}
