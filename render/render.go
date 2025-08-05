package render

import (
	"fmt"
	"prism/locations"
	"prism/operating_system"
	"prism/user"
	"prism/util"
	"sort"
)

func PaintScreen(thisUser *user.User) ([][]rune, error) {
	var canvas [][]rune
	var err error

	//get terminal info
	thisUser.ScreenWidth, thisUser.ScreenHeight, err = operating_system.GetTerminalSize()
	if err != nil {
		return canvas, fmt.Errorf("error getting screen dimensions for rendering: %w,", err)
	}

	// get all locations
	locationsToRender, err := locations.GetAllLocations(thisUser)
	if err != nil {
		return canvas, fmt.Errorf("error getting loc's near to user: %w,", err)
	}
	fmt.Printf("locations count: %d\n", len(locationsToRender))

	// set each locations coordinates
	locationsToRender, err =
		findLocationsCoordinates(thisUser, &locationsToRender)
	if err != nil {
		return canvas, fmt.Errorf("error getting coordinates for loc's: %w,", err)
	}
	// set each location's art file from their ArtName
	locationsToRender = locations.SetLocationsArt(locationsToRender)

	// create canvas
	canvas = make([][]rune, thisUser.ScreenHeight)
	for i := range canvas {
		canvas[i] = make([]rune, thisUser.ScreenWidth)
		for j := range canvas[i] {
			canvas[i][j] = ' '
		}
	}

	// order locations
	orderLocationsSlice(locationsToRender)

	// place objects on the canvas
	addLocationsToCanvas(canvas, locationsToRender)
	//addWorkersToCanvas(canvas, workersToRender)
	addUserToCanvas(canvas)

	for i := range canvas {
		fmt.Println(string(canvas[len(canvas)-1-i]))
	}

	return canvas, nil
}

// findLocationsCoordinates takes any given locations, returning just the locations close
// enough to the user to show on screen, then adjust the approved locations, adding detail
// on where they ought to appear on the screen, based on the screen width & height.
func findLocationsCoordinates(user *user.User, unfilteredLocations *[]locations.Location) ([]locations.Location, error) {
	var filteredLocations []locations.Location
	var degreeRange float64 = 2 // in lat/long units how far should locations be to render? thats what this represents
	minLat, maxLat, minLong, maxLong := util.GetMaxLocationRanges(degreeRange, user.Latitude, user.Longitude)

	for _, location := range *unfilteredLocations {
		// if out of bounds, don't add the object to the filtered slice by skipping this loop iteration
		if location.Latitude > maxLat || location.Latitude < minLat || location.Longitude > maxLong || location.Longitude < minLong {
			continue
		}

		// distance represents the unit of distance each char on the canvas represents in degree distance.
		// if the canvas degree range is 10, and the screen width is 10, then every char on the screen is 1 lat.
		var horizontalIndex int = int((location.Longitude - minLong) / (degreeRange * 2) * float64(user.ScreenWidth))
		var verticalIndex int = int((location.Latitude - minLat) / (degreeRange * 2) * float64(user.ScreenHeight))

		location.XCoordinate = horizontalIndex
		location.YCoordinate = verticalIndex
		filteredLocations = append(filteredLocations, location)
	}

	return filteredLocations, nil
}

func addLocationsToCanvas(canvas [][]rune, locations []locations.Location) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	// triple nested loop.
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
func orderLocationsSlice(locations []locations.Location) {

	sort.SliceStable(locations, func(i, j int) bool {
		if locations[i].YCoordinate == locations[j].YCoordinate {
			return locations[i].XCoordinate < locations[j].XCoordinate
		}
		return locations[i].YCoordinate < locations[j].YCoordinate
	})
}

func addUserToCanvas(canvas [][]rune) {
	halfHorizantalLength := len(canvas[0]) / 2
	halfVerticalHeight := len(canvas) / 2
	canvas[halfVerticalHeight][halfHorizantalLength] = '@'
}
