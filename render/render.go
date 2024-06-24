package render

import (
	"fmt"
	"os"
	"prism/operating_system"
	"sort"
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

var pokemon0 art = art{
	width:  87,
	height: 39,
	art: []string{
		"                                                          @----@         @-::::::::@ ",
		"        #*@                                             @=-------    @-:::::::::::::# ",
		"      -------@                                         %----======@@::::::::::::::::@ ",
		"    @----------                                @--@   %-===========+:::::::::::::::. ",
		"    ------======@                            @--===@ @-=============:::::::::::::::@ ",
		"   @---==========@                    @@@+-------===@===============@:::::::::::::@  ",
		"   ---============#               @-------------====%================::::::::::::    ",
		"  #--==============%           %---------------===========@%@========+::::::::-@     ",
		"  --================@       @-----------------==========@#####=======@::::-==@       ",
		" @--=====+#####======@     +-===---------------========#######@======@=====@         ",
		"  --=====#######*=====   @-====--------------=======*=######**@======#-=+==@         ",
		"  --=====#####***%====@ @-=====-----------==========#@##@+#***#======-*=====         ",
		"  #-=====%###******====-%======--===================##=-----%+======#+==#=+          ",
		"   =======##-----=+#===+===========================+%=======#%=======+++=-           ",
		"   @======@@--=====%%=============================@=-=======@======@++++++=@         ",
		"    #======@-===========@========================#=#==============@++++++++=@        ",
		"     @======+========%===+====================++===========-=====@++++++++++=@       ",
		"      @-=====@===========@**++++=======++++++*@@==+======@=======++++++++++++=@      ",
		"        @======#======*==#**+**************+%**=======#=======*==+++++++++++++=@     ",
		"           @==============+***+***************=============@=@====#++++++++++++=     ",
		"          @==*@==============++++*********+++=================@=====@++++++++++=@    ",
		"         -========================++++++++=====================*=======+++++++++#    ",
		"       @====@==========================================================+++++++++=    ",
		"      @=====-===================================================@=======#+++++++=    ",
		"     @======================--===========================================+++++++=@   ",
		"     -======================-============================================-+++++++    ",
		"    @=====================================================================@+++++#    ",
		"    -======#================================================================+++*@    ",
		"   @========================%@@+===============%.###============#==========%****     ",
		"   @========@====::::-====-###.  %============#  *###===::::::-=*==========@***      ",
		"   @=========%==::::::::-=@#######======---===####*#@=:::::::::@===========@*+       ",
		"    ==========@=::::::::::=#==###%......=.....++++=#=:::::::::@============@%@       ",
		"    *==========+-::::::::::==@#@.................===:::::::::============-.**%@      ",
		"    @..:-========@:::::::::====........*:.%......===:::::::#======-:......@*%*#      ",
		"      .............:+::::::====..................===-::-#...............:@           ",
		"       +=--::::::--===-#*:======:..............====*@====----::::::--===@            ",
		"         -===---========+      +@@%*+--=+#@@@@       @-===============@              ",
		"          @-=========*@                                 @-=========@                 ",
		"            -=+@-=@                                       @%@@=@@@@                  ",
	},
}

var pokemon1 art = art{
	width:  87,
	height: 39,
	art: []string{
		".===..    .....=***...                   ... ..                                          ",
		"*...@:.   ..*#@....@%*.. ...          ...*%@@@+...                                       ",
		"@...@:.....*. ........@...#@%...    ..+*@.   .+@*..............                          ",
		".%%.........%@@....@*.=+*@+=++@+. .-*....@@@@@=.....@-..*#@..-@.                         ",
		" ..*@:.....@..    ..=@++*@.++++*@..=@...@. . .=*@....#@@.....-@                          ",
		"  ...+*%%%%..    ..:+@@@%+.=+++++@#=.+%@.    ....%%::.. :::%%*..                         ",
		"                .:@++++++++***+++++*@@#*.         ...#@@....                           . ",
		"              ..%@++-..+=++++++++++=++%@...                                        .....@",
		"            ..+#-:......:+++++++++++++++#+:                                     ..+++###-",
		"           ..:@=.. ..  ...+++++++++++++++@=..                               ...+@@===::::",
		"           .@%++..    ..:+++++++++++++++++#@                            .....@@*==::::::.",
		"          .+#*+-::....----++++++++++++++++*%+.                      ...+++##*--:::......:",
		"          .@++++..+.:+.+=.+++++++++++++++++=+@+..               ....=@@===:::::...::::::=",
		"         ..@+++.==.=-.=.:++++++++++++++++++==.+@..            ...:@@#==:::::....:::::===@",
		"        .*@+++++--:--=-++++++++++++++++++++++-:.@.        ..+++***--:::......:::--###+==.",
		"         *@+++++++++++++++++++++++++++++++++++:..@%.    .-@@===:::::...::::::==#@@....   ",
		"        .*@+++++++++++++++++++++++++++++++++++++.@%....@@#==:::::....:::::===@@=. . .    ",
		"     ...*++++++++++++++++++++++++++++++++++++++++@@%+++:::::...:.::::==%%%:::. ..        ",
		"     ...@*+++++++++++++++++++++++++++++++++++++=@===:::::...::::::==*@@.....             ",
		"       .@*+++++++++++++++++++++++++=++++++++++++@:::::....:::::==+@@*.                   ",
		"       .@*++++++++++++++++++++++++++*++++@@@++#@....::::::==%@@.....                     ",
		"     ...@#+++++++++++++++++++++++++*@=++@++++@+..::::::==+@@....                         ",
		"      .%=++++++++++++++++++++++++++*@=++*****....:--***@*+..                             ",
		".    ..@=++++++++++++++++++++++++++*@@@@....   ..%@@....@#.                              ",
		".    ..@=++++++++++++++++++++++++++*@.         ..==..==+@#..                             ",
		".    ..@=++++++++++++++++++++++++++*@..        ..@%..=+++*@.                             ",
		"    .**+++++++++++++++++++++++++++++=@-.        @..+.==++*@..                            ",
		"    .%@++++++++++++++++++++++++++++++@-.      ..@+++.=+++==@.                            ",
		"    .%@+++++++++++++++++++++++++++++++##. .. %+:==++++=++++@.                            ",
		"   ..%@+++++++++++++++++++++++++++++=+%@..*@@=+++++++++++++=@#.                          ",
		"   .@+++++++++++++++++++++++++++++++=@@@@@#+++++++++.==+++++@#                           ",
		"   .@++++++++++++++++++++++++++++++++++++++++++++++=.-=++++++*%.                         ",
		"  .@=++++++==================++++=++++++++++++++++=.+:.=+++++*@.                         ",
	},
}
var ball art = art{
	width:  3,
	height: 4,
	art: []string{
		" _ ",
		"/ \\",
		"| |",
		"\\_/",
	},
}

var house art = art{
	width:  4,
	height: 2,
	art: []string{
		" /\\ ",
		"|__|",
	},
}

var box art = art{
	width:  2,
	height: 2,
	art: []string{
		"xx",
		"xx",
	},
}

var tower art = art{
	width:  10,
	height: 10,
	art: []string{
		"  _______ ",
		" /       \\",
		"|        |",
		"|        |",
		"|        |",
		"|        |",
		"|        |",
		"|        |",
		"|        |",
		"|________|",
	},
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

	termWidth, termHeight, err := operating_system.GetTerminalSize()
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}

	// dummy terminal data
	// termWidth := 100
	// termHeight := 20
	fmt.Printf("Width: %d, Height: %d\n", termWidth, termHeight)

	// get user location
	// dummy user data
	var userLat float32 = 12.54
	var userLong float32 = -143.54

	// get obj locations
	// dummy obj data
	objLandmark := object{0, 0, 0, "node0", 12, -144, "node", "first node", pokemon0, 0, 0}
	objWorker := object{0, 0, 0, "node1", 11.60, -144.41, "worker", "first worker", pokemon1, 0, 0}
	obj3 := object{0, 0, 0, "node2", 12.31, -144.32, "node", "first node", tower, 0, 0}
	obj4 := object{0, 0, 0, "node3", 11.990, -144.42, "worker", "first worker", tower, 0, 0}
	obj5 := object{0, 0, 0, "node4", 12.17, -144.2, "node", "first node", house, 0, 0}
	obj6 := object{0, 0, 0, "node5", 12.120, -144.02, "worker", "first worker", tower, 0, 0}
	var objectsToRender []object = []object{objLandmark, objWorker, obj3, obj4, obj5, obj6}

	// get each obj coordinates

	objectsToRender, err =
		findObjectCoordinate(userLong, userLat, objectsToRender, termWidth, termHeight)
	if err != nil {
		fmt.Println(err)
	}

	canvas := make([][]rune, termHeight)
	for i := range canvas {
		canvas[i] = make([]rune, termWidth)
		for j := range canvas[i] {
			canvas[i][j] = ' '
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
			objects[i].xCoordinate = int(latDistance/horizontalDistancePerChar) - 1
			objects[i].yCoordinate = scrHeight - int(longDistance/verticalDistancePerChar) - 1

			validatedObjects = append(validatedObjects, objects[i])
		}

		//	fmt.Printf("\nObject: %s, [%d, %d]", object.name, objCoordinates[i][0], objCoordinates[i][1])
	}
	validatedObjects = orderObjectSlice(validatedObjects)

	return validatedObjects, nil
}

func addObjectsToCanvas(canvas [][]rune, objects []object) {
	canvasHeight := len(canvas)
	canvasWidth := len(canvas[0])

	for _, object := range objects {
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

func orderObjectSlice(objects []object) []object {

	sort.SliceStable(objects, func(i, j int) bool {
		if objects[i].yCoordinate == objects[j].yCoordinate {
			return objects[i].xCoordinate < objects[j].xCoordinate
		}
		return objects[i].yCoordinate < objects[j].yCoordinate
	})
	return objects
}
