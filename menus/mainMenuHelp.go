package menus

// MainMenuHelp implements HelpProvider for the main menu
type MainMenuHelp struct{}

// GetCommands returns all available commands for the main menu
func (m MainMenuHelp) GetCommands() []Command {
	return []Command{
		{
			Name:        "ping",
			Description: "Update your current location using geolocation",
			Usage:       "ping",
		},
		{
			Name:        "new location",
			Description: "Create a new location at your current position",
			Usage:       "new location",
		},
		{
			Name:        "connect",
			Description: "Connect to any nearby existing locations",
			Usage:       "connect",
		},
		{
			Name:        "locations",
			Description: "View and manage your locations",
			Usage:       "locations",
		},
		{
			Name:        "eggs",
			Description: "View and hatch your worker eggs",
			Usage:       "eggs",
		},
		{
			Name:        "create home",
			Description: "Convert one of your locations into a home",
			Usage:       "create home",
		},
	}
}

// GetMenuName returns the name of this menu
func (m MainMenuHelp) GetMenuName() string {
	return "Main Menu"
}