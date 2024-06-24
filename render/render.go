package render

import (
	"fmt"
)

type object struct {
	id          int
	user_id     int
	object_id   int
	name        string
	latitude    float32
	longitude   float32
	object_type string
	description string
	art         art
	xCoordinate int
	yCoordinate int
}

type art struct {
	width  int
	height int
	art    []string
}

var mountain art = art{
	width:  72,
	height: 14,
	art: []string{
		"    .                  .-.    .  _   *     _   .                        ",
		"           *          /   \\     ((       _/ \\       *    .            ",
		"         _    .   .--'/\\/_ \\     `      /    \\  *    ___             ",
		"     *  / \\_    _/ ^      \\/\\\\__        /\\/\\  /\\  __/   \\ *     ",
		"       /    \\  /    .'   _/  /  \\  *' /    \\/  \\/ .'\\_/\\   .      ",
		"  .   /\\/\\  /\\/ :' __  ^/  ^/    `--./.'  ^  `-.\\_    _:\\ _        ",
		"     /    \\/  \\  _/  \\-' __/.' ^ _   \\_   .\\'   _/ \\ .  __/ \\    ",
		"   /\\  .-   `. \\/     \\ / -.   _/ \\ -. `_/   \\ /    `._/  ^  \\    ",
		"  /  `-.__ ^   / .-'.--'    . /    `--./ .-'  `-.  `-. `.  -  `.        ",
		"@/        `.  / /      `-.   /  .-'   / .   .'   \\    \\  \\  .-  \\%  ",
		"@&8jgs@@%% @)&@&(88&@.-_=_-=_-=_-=_-=_.8@% &@&&8(8%@%8)(8@%8 8%@)%      ",
		"@88:::&(&8&&8:::::%&`.~-_~~-~~_~-~_~-~~=.'@(&%::::%@8&8)::&#@8::::::    ",
		"::::::8%@@%:::::@%&8:`.=~~-.~~-.~~=..~'8::::::::&@8:::::&8::::::::::::  ",
		"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",
	},
}

func RenderScreen() [][]rune {
	// get terminal size
	// real way to get user screen

	// termWidth, termHeight, err := operating_system.GetTerminalSize()
	// if err != nil {
	// 	fmt.Fprintf(os.Stderr, "Error: %v\n", err)
	// 	os.Exit(1)
	// }

	// dummy terminal data
	termWidth := 100
	termHeight := 20
	fmt.Printf("Width: %d, Height: %d\n", termWidth, termHeight)

	// get user location
	// dummy user data
	var userLat float32 = 12.54
	var userLong float32 = -144.54

	// get obj locations
	// dummy obj data
	objLandmark := object{0, 0, 0, "node", 12.01, -143.32, "node", "first node", art{5, 2, []string{"12345", "12345"}}}
	objWorker := object{0, 0, 0, "node", 13.00, -143.82, "worker", "first worker", art{1, 1, []string{"@"}}}
	var objectsToRender []object = []object{objLandmark, objWorker}

	// get each obj coordinates

	objCoordinates, err :=
		findObjectCoordinate(userLong, userLat, objectsToRender, termWidth, termHeight)
	if err != nil {
		fmt.Println(err)
	}

	canvas := make([][]rune, termHeight)
	for i := range canvas {
		canvas[i] = make([]rune, termWidth)
		for j := range canvas[i] {
			canvas[i][j] = '='
		}
	}

	addObjectsToCanvas(canvas, objectsToRender, objCoordinates)

	return canvas
}

// get user location
// get all obj locations
// validate obj locations as close enough to user
// calc obj coordinates on screen

func findObjectCoordinate(userLong, userLat float32, objects []object, scrWidth, scrHeight int) ([]objects, error) {

	var objCoordinates [][2]int

	for i, object := range objects {
		objLat := object.latitude
		objLong := object.longitude

		latDistance := objLat - userLat
		longDistance := objLong - userLong

		// gets the range between 0-2 for the equation below
		latDistance += 1
		longDistance += 1

		var horizontalDistancePerChar float32 = float32(2) / float32(scrWidth)
		var verticalDistancePerChar float32 = float32(2) / float32(scrHeight)

		// Calculate the position in screen coordinates, place into return slice

		if userLat-object.latitude > -1 && userLat-object.latitude < 1 && userLong-object.longitude > -1 && userLong-object.longitude < 1 {
			objects[i].xCoordinate = int(latDistance / horizontalDistancePerChar)
			objects[i].yCoordinate = scrHeight - int(longDistance/verticalDistancePerChar)
		}

		fmt.Printf("\nObject: %s, [%d, %d]", object.name, objCoordinates[i][0], objCoordinates[i][1])
	}
	// TODO: fiter objects so that the object with the lowest vertical coordinates always on top...

	return objects, nil
}

func addObjectsToCanvas(canvas [][]rune, objects []object, objectsCoordinates [][2]int) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	// fmt.Printf("Canvas Size: Width: %d, Height: %d\n", canvasWidth, canvasHeight)
	// fmt.Printf("Art Position: X: %d, Y: %d\n", posX, posY)
	for _, object := range objects {
		for y := 0; y < object.art.height; y++ {
			artY := objectCoordinates[] posY + y
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
}
