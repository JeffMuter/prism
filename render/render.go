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

var userArt = art{
	width:  1,
	height: 1,
	art: []string{
		"@",
	},
}

var worker = art{
	width:  1,
	height: 1,
	art: []string{
		"#",
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
	//dummy data for user location
	//userLat, userLong := 43.00, -83.00
	userObject := object{
		latitude:  float32(userLat),
		longitude: float32(userLong),
		name:      "user",
		art:       userArt,
	}

	// get obj locations
	// dummy obj data
	columbusObject := object{
		0,
		0,
		0,
		"node0",
		39.95930175232374,
		-83.00445638483892,
		"node",
		"columbus",
		house,
		0,
		0,
	}
	cinciObject := object{0,
		0,
		0,
		"node1",
		39.101398,
		-84.512395,
		"worker",
		"cinci",
		house,
		0,
		0,
	}
	//obj3 := object{
	//	0,
	//	0,
	//	0,
	//	"node2",
	//	40.01,
	//	-85.99,
	//	"node",
	//	"sunbury",
	//	sunbury,
	//	0,
	//	0,
	//}
	daytonObject := object{
		0,
		0,
		0,
		"node3",
		39.760504,
		-84.193430,
		"worker",
		"dayton",
		house,
		0,
		0,
	}
	clevelandObject := object{0,
		0,
		0,
		"node4",
		41.499748,
		-81.693500,
		"node",
		"cleveland",
		house,
		0,
		0,
	}
	//obj6 := object{0, 0, 0, "node5", 42.120, -85.02, "worker", "first worker", tower, 0, 0}
	var objectsToRender = []object{
		userObject,
		clevelandObject,
		daytonObject,
		cinciObject,
		columbusObject,
	}

	// get each obj coordinates
	objectsToRender, err =
		findObjectCoordinate(float32(userLong), float32(userLat), objectsToRender, termWidth, termHeight)
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

	return canvas
}

func findObjectCoordinate(userLong, userLat float32, objects []object, scrWidth, scrHeight int) ([]object, error) {
	var filteredObjects []object
	// number represents the screen's range from top to bottom. Higher this number, the further the user can see.
	// the user would be in the center. If the degree radius from the user is 1, then the long/lat goes above and
	// below the user 1 degree, so 2 degrees. If the radius is 5, then the canvas range is 10, etc..
	canvasDegreeRange := 4
	for i := range objects {

		// defines max min values in degrees for the canvas
		// should canvas be a type and we set those?
		maxLat := userLat + float32(canvasDegreeRange)/float32(2)
		minLat := userLat - float32(canvasDegreeRange)/float32(2)
		maxLong := userLong + float32(canvasDegreeRange)/float32(2)
		minLong := userLong - float32(canvasDegreeRange)/float32(2)

		// distance represents the unit of distance each char on the canvas represents in degree distance.
		// if the canvas degree range is 10, and the screen width is 10, then every char on the screen is 1 lat.
		var horizontalDistancePerChar = float32(canvasDegreeRange) / float32(scrWidth)
		var verticalDistancePerChar = float32(canvasDegreeRange) / float32(scrHeight)

		// if out of bounds, don't add the object to the filtered slice
		if objects[i].latitude > maxLat || objects[i].latitude < minLat || objects[i].longitude > maxLong || objects[i].longitude < minLong {
			continue
		}
		// calc is wrong, creating a 90degree rotation incorrectly.
		objects[i].xCoordinate = int((objects[i].longitude - minLong) / horizontalDistancePerChar)
		objects[i].yCoordinate = scrHeight - 1 - int((objects[i].latitude-minLat)/verticalDistancePerChar)
		filteredObjects = append(filteredObjects, objects[i])
	}

	return objects, nil
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

func getObjectArt(path string) []string {
	// we want to take the path, go to our assets folder
	var artSlice []string
	txtFilePath := "assets/" + path + ".txt"

	return artSlice
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
