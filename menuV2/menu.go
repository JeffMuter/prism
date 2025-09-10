package menuV2

// Menu interface for both static and dynamic menus
type Menu interface {
	Show(routeStack []string, params ...interface{}) ([]string, error)
}

// Border represents the visual style for menu borders
type Border struct {
	TopLeft     string
	TopRight    string
	BottomLeft  string
	BottomRight string
	Horizontal  string
	Vertical    string
}

// GetUnicodeBorder returns Unicode box drawing border
func GetUnicodeBorder() Border {
	return Border{
		TopLeft:     "┌",
		TopRight:    "┐",
		BottomLeft:  "└",
		BottomRight: "┘",
		Horizontal:  "─",
		Vertical:    "│",
	}
}

// GetASCIIBorder returns ASCII border for compatibility
func GetASCIIBorder() Border {
	return Border{
		TopLeft:     "+",
		TopRight:    "+",
		BottomLeft:  "+",
		BottomRight: "+",
		Horizontal:  "-",
		Vertical:    "|",
	}
}