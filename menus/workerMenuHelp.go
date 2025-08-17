package menus

// WorkerMenuHelp implements HelpProvider for the worker menu
type WorkerMenuHelp struct{}

// GetCommands returns all available commands for the worker menu
func (w WorkerMenuHelp) GetCommands() []Command {
	return []Command{
		{
			Name:        "move",
			Description: "Move this worker to a different location",
			Usage:       "move",
		},
		{
			Name:        "assign",
			Description: "Assign this worker to a different task",
			Usage:       "assign",
		},
		{
			Name:        "swap",
			Description: "Toggle this worker's working status (working/resting)",
			Usage:       "swap",
		},
	}
}

// GetMenuName returns the name of this menu
func (w WorkerMenuHelp) GetMenuName() string {
	return "Worker Menu"
}