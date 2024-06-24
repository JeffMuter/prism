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
	var userLong float32 = -143.54

	// get obj locations
	// dummy obj data
	objLandmark := object{0, 0, 0, "node1", 12.01, -143.32, "node", "first node", art{5, 2, []string{"12345", "12345"}}, 0, 0}
	objWorker := object{0, 0, 0, "node2", 11.80, -143.02, "worker", "first worker", mountain, 0, 0}
	obj3 := object{0, 0, 0, "node3", 12.01, -143.32, "node", "first node", art{5, 2, []string{"12345", "12345"}}, 0, 0}
	obj4 := object{0, 0, 0, "node4", 11.80, -143.02, "worker", "first worker", mountain, 0, 0}
	obj5 := object{0, 0, 0, "node5", 11.67, -143.32, "node", "first node", art{5, 2, []string{"12345", "12345"}}, 0, 0}
	obj6 := object{0, 0, 0, "node6", 13.120, -143.02, "worker", "first worker", mountain, 0, 0}
	var objectsToRender []object = []object{objLandmark, objWorker, obj3, obj4, obj5, obj6}

	// get each obj coordinates

	objectsToRender, err :=
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

	addObjectsToCanvas(canvas, objectsToRender)

	return canvas
}

// get user location
// get all obj locations
// validate obj locations as close enough to user
// calc obj coordinates on screen

func findObjectCoordinate(userLong, userLat float32, objects []object, scrWidth, scrHeight int) ([]object, error) {
	var validatedObjects []object

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
			validatedObjects = append(validatedObjects, objects[i])
		}

		//	fmt.Printf("\nObject: %s, [%d, %d]", object.name, objCoordinates[i][0], objCoordinates[i][1])
	}
	// TODO: fiter objects so that the object with the lowest vertical coordinates always on top...
	validatedObjects = orderObjectSlice(validatedObjects)

	return validatedObjects, nil
}

func addObjectsToCanvas(canvas [][]rune, objects []object) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	// on first glance, I think something smells fishy here. not sure y < object.art.height should be the bounds for y...
	for _, object := range objects {
		for y := 0; y < object.art.height; y++ {
			artY := object.yCoordinate + y
			if artY < 0 || artY >= canvasHeight {
				fmt.Printf("Skipping line %d: artY (%d) out of canvas bounds\n", y, artY)
				continue
			}

			for x := 0; x < object.art.width; x++ {
				artX := object.xCoordinate + x
				if artX < 0 || artX >= canvasWidth {
					fmt.Printf("Skipping column %d: artX (%d) out of canvas bounds\n", x, artX)
					continue
				}

				// Ensure the art slice indices are also within bounds
				if y >= len(object.art.art) || x >= len(object.art.art[y]) {
					fmt.Printf("Invalid art index [%d][%d] accessed, skipping draw.\n", y, x)
					continue
				}

				fmt.Printf("Drawing at canvas[%d][%d]\n", artY, artX)
				canvas[artY][artX] = rune(object.art.art[y][x])
			}
		}
	}
}

func orderObjectSlice(objects []object) []object {
	// bubble sort
	for j := len(objects); j > 0; j-- {
		for i := 0; i < len(objects)-1; i++ {
			if objects[i].yCoordinate+objects[i].art.height < objects[i+1].yCoordinate+objects[i+1].art.height {
				tempObj := objects[i]
				objects[i] = objects[i+1]
				objects[i+1] = tempObj
			}
		}
	}
	return objects
}
