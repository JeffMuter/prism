package main

import (
	"fmt"

	"prism/render"
)

type art struct {
	width  int
	height int
	art    []string
}

var house art = art{
	width:  70,
	height: 14,
	art: []string{
		"    .                  .-.    .  _   *     _   .",
		"           *          /   \\     ((       _/ \\       *    .",
		"         _    .   .--'/\\/_ \\     `      /    \\  *    ___",
		"     *  / \\_    _/ ^      \\/\\\\__        /\\/\\  /\\  __/   \\ *",
		"       /    \\  /    .'   _/  /  \\  *' /    \\/  \\/ .'\\_/\\   .",
		"  .   /\\/\\  /\\/ :' __  ^/  ^/    `--./.'  ^  `-.\\_    _:\\ _",
		"     /    \\/  \\  _/  \\-' __/.' ^ _   \\_   .\\'   _/ \\ .  __/ \\",
		"   /\\  .-   `. \\/     \\ / -.   _/ \\ -. `_/   \\ /    `._/  ^  \\",
		"  /  `-.__ ^   / .-'.--'    . /    `--./ .-'  `-.  `-. `.  -  `.",
		"@/        `.  / /      `-.   /  .-'   / .   .'   \\    \\  \\  .-  \\%",
		"@&8jgs@@%% @)&@&(88&@.-_=_-=_-=_-=_-=_.8@% &@&&8(8%@%8)(8@%8 8%@)%",
		"@88:::&(&8&&8:::::%&`.~-_~~-~~_~-~_~-~~=.'@(&%::::%@8&8)::&#@8::::",
		"::::::8%@@%:::::@%&8:`.=~~-.~~-.~~=..~'8::::::::&@8:::::&8:::::",
		"::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::.",
	},
}

func main() {

	termWidth := 100
	termHeight := 20

	var userLat float32 = 32.234
	var userLong float32 = -48.254

	var objLat float32 = 32.232
	var objLong float32 = -48.235

	// termWidth, termHeight, err := operating_system.GetTerminalSize()
	// if err != nil {
	// 	fmt.Fprintf(os.Stderr, "Error: %v\n", err)
	// 	os.Exit(1)
	// }

	fmt.Printf("Width: %d, Height: %d\n", termWidth, termHeight)

	objCoordinates, err := findObjectCoordinate(userLong, userLat, objLong, objLat, termWidth, termHeight)
	if err != nil {
		fmt.Println(err)
	}

	fmt.Printf("Width: %d, Height: %d\n", termWidth, termHeight)

	canvas := make([][]rune, termHeight)
	for i := range canvas {
		canvas[i] = make([]rune, termWidth)
		for j := range canvas[i] {
			canvas[i][j] = '='
		}
	}

	if userLat-objLat > -1 && userLat-objLat < 1 && userLong-objLong > -1 && userLong-objLong < 1 {
		addObjectToCanvas(canvas, house, objCoordinates[0], objCoordinates[1])
	}

	for _, line := range canvas {
		fmt.Println(string(line))
	}

	render.Render()
}
