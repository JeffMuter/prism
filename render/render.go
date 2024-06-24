package render

import (
	"errors"
	"fmt"
)

func Render() {

}

func findObjectCoordinate(userLong, userLat, objLong, objLat float32, scrWidth, scrHeight int) ([2]int, error) {

	var objPosition = [2]int{0, 0}
	latDistance := objLat - userLat
	longDistance := objLong - userLong

	if latDistance > 1 || latDistance < -1 || longDistance > 1 || longDistance < -1 {
		// if true, will NOT be visible on screen
		return objPosition, errors.New(" object too far to project to map")
	}

	// gets the range between 0-2 for the equation below
	latDistance += 1
	longDistance += 1

	var horizontalDistancePerChar float32 = float32(2) / float32(scrWidth)
	var verticalDistancePerChar float32 = float32(2) / float32(scrHeight)

	// Calculate the position in screen coordinates
	objPosition[0] = int(latDistance / horizontalDistancePerChar)
	objPosition[1] = scrHeight - int(longDistance/verticalDistancePerChar)

	fmt.Println(objPosition)
	return objPosition, nil
}

func addObjectToCanvas(canvas [][]rune, art art, posX int, posY int) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	fmt.Printf("Canvas Size: Width: %d, Height: %d\n", canvasWidth, canvasHeight)
	fmt.Printf("Art Position: X: %d, Y: %d\n", posX, posY)

	for y := 0; y < art.height; y++ {
		artY := posY + y
		if artY < 0 || artY >= canvasHeight {
			fmt.Printf("Skipping line %d: artY (%d) out of canvas bounds\n", y, artY)
			continue
		}

		for x := 0; x < art.width; x++ {
			artX := posX + x
			if artX < 0 || artX >= canvasWidth {
				fmt.Printf("Skipping column %d: artX (%d) out of canvas bounds\n", x, artX)
				continue
			}

			// Ensure the art slice indices are also within bounds
			if y >= len(art.art) || x >= len(art.art[y]) {
				fmt.Printf("Invalid art index [%d][%d] accessed, skipping draw.\n", y, x)
				continue
			}

			fmt.Printf("Drawing at canvas[%d][%d]\n", artY, artX)
			canvas[artY][artX] = rune(art.art[y][x])
		}
	}

}
