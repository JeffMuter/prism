package render

import (
	"fmt"
	"prism/operating_system"
	"prism/user"
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

var columbus = art{
	width:  7,
	height: 2,
	art: []string{
		"columbus",
		"columbus",
	},
}
var sunbury = art{
	width:  7,
	height: 2,
	art: []string{
		"sunbury",
		"sunbury",
	},
}
var cinci = art{
	width:  5,
	height: 3,
	art: []string{
		"cinci",
		"cinci",
		"cnccc",
	},
}
var dayton = art{
	width:  6,
	height: 2,
	art: []string{
		"dayton",
		"dayton",
	},
}
var cleveland = art{
	width:  9,
	height: 2,
	art: []string{
		"cleveland",
		"cleveland",
	},
}
var pokemon0 = art{
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

var pokemon1 = art{
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
var ball = art{
	width:  3,
	height: 4,
	art: []string{
		" _ ",
		"/ \\",
		"| |",
		"\\_/",
	},
}

var house = art{
	width:  4,
	height: 2,
	art: []string{
		" /\\ ",
		"|__|",
	},
}

var box = art{
	width:  2,
	height: 2,
	art: []string{
		"xx",
		"xx",
	},
}

var tower = art{
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

var mountain = art{
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

func PaintScreen() [][]rune {
	//get terminal size
	//real way to get user screen

	termWidth, termHeight, err := operating_system.GetTerminalSize()
	if err != nil {
		fmt.Println("issue getting screen dimensions for rendering")
	}
	fmt.Printf("Width: %d, Height: %d\n", termWidth, termHeight)

	// get user location
	userLat, userLong, err := user.Ping()
	if err != nil {
		fmt.Println("issue getting user position for rendering...")
	}

	// get obj locations
	// dummy obj data
	objLandmark := object{0, 0, 0, "node0", 39.95930175232374, -83.00445638483892, "node", "first node", columbus, 0, 0}
	objWorker := object{0, 0, 0, "node1", 39.60, -82.41, "worker", "first worker", cinci, 0, 0}
	obj3 := object{0, 0, 0, "node2", 38.31, -82.32, "node", "first node", sunbury, 0, 0}
	obj4 := object{0, 0, 0, "node3", 41.990, -80.42, "worker", "first worker", dayton, 0, 0}
	obj5 := object{0, 0, 0, "node4", 38.17, -80.2, "node", "first node", cleveland, 0, 0}
	//obj6 := object{0, 0, 0, "node5", 42.120, -85.02, "worker", "first worker", tower, 0, 0}
	var objectsToRender = []object{objLandmark, objWorker, obj3, obj4, obj5}

	// get each obj coordinates

	objectsToRender, err =
		findObjectCoordinate(float32(userLong), float32(userLat), objectsToRender, termWidth, termHeight)
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
	// in my opinion, this could be made shorter, and more clear. the coordinate is currently fighting for determination between judging based on the user's location, versus within a range... While we can make an if-check on being within x lat/long units of the user, we should ideally find the user's location, add x, subtract x from the long and lat, and use that as the 2d range, and refine the equation.
	// also need to get the art out of here.
	// this needs much more documentation. and the lat / long distances need to be made variables.
	//
	var validatedObjects []object

	for i, object := range objects {
		objLat := object.latitude
		objLong := object.longitude

		latDistance := objLat - userLat
		longDistance := objLong - userLong

		// gets the range between 0-2 for the equation below
		latDistance += 1
		longDistance += 1

		var horizontalDistancePerChar = float32(6) / float32(scrWidth)
		var verticalDistancePerChar = float32(6) / float32(scrHeight)

		// Calculate the position in screen coordinates, place into return slice

		if userLat-object.latitude > -3 && userLat-object.latitude < 3 && userLong-object.longitude > -3 && userLong-object.longitude < 3 {
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
