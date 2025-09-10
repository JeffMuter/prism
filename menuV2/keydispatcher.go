package menuV2

import (
	"fmt"
	"prism/logic"
	"prism/render"
	"prism/user"
	"prism/util"
)

// KeyAction represents different actions that can be triggered by keys
type KeyAction int

const (
	NoAction KeyAction = iota
	OpenMainMenu
	OpenInventory
	OpenSettings
	OpenHelp
	ExitGame
)

// KeyDispatcher handles key inputs on the map screen
type KeyDispatcher struct {
	keyMap map[byte]KeyAction
}

// NewKeyDispatcher creates a new key dispatcher with default mappings
func NewKeyDispatcher() *KeyDispatcher {
	return &KeyDispatcher{
		keyMap: map[byte]KeyAction{
			9:   OpenMainMenu,    // Tab key
			'i': OpenInventory,   // 'i' for inventory (future)
			's': OpenSettings,    // 's' for settings (future) 
			'h': OpenHelp,        // 'h' for help (future)
			'q': ExitGame,        // 'q' to quit
			27:  ExitGame,        // Escape to quit
		},
	}
}

// GetKeyAction reads a single key and returns the corresponding action
func (kd *KeyDispatcher) GetKeyAction() (KeyAction, error) {
	if err := enableRawMode(); err != nil {
		return NoAction, err
	}
	defer disableRawMode()

	char, err := readSingleChar()
	if err != nil {
		return NoAction, err
	}

	if action, exists := kd.keyMap[char]; exists {
		return action, nil
	}

	return NoAction, nil
}

// MapController manages the map display and input handling
type MapController struct {
	user       user.User
	reader     util.InputReader
	dispatcher *KeyDispatcher
}

// NewMapController creates a new map controller
func NewMapController(user user.User, reader util.InputReader) *MapController {
	return &MapController{
		user:       user,
		reader:     reader,
		dispatcher: NewKeyDispatcher(),
	}
}

// ShowMapAndListen displays the map and listens for key inputs
func (mc *MapController) ShowMapAndListen() error {
	for {
		// Update user location
		var err error
		mc.user.Latitude, mc.user.Longitude, err = user.Ping()
		if err != nil {
			fmt.Printf("Warning: Could not get location via Ping(): %v\n", err)
			// Keep existing coordinates if ping fails
		}
		
		// Update all locations resource quantities
		err = logic.UpdateAllLocationsResourcesQuantities(mc.user.Id)
		if err != nil {
			fmt.Printf("Warning: Could not update resource quantities: %v\n", err)
		}

		// Display the actual game map
		_, err = render.PaintScreen(&mc.user)
		if err != nil {
			return fmt.Errorf("error rendering map: %w", err)
		}

		action, err := mc.dispatcher.GetKeyAction()
		if err != nil {
			return fmt.Errorf("error reading key input: %w", err)
		}

		switch action {
		case OpenMainMenu:
			err := mc.openMainMenu()
			if err != nil {
				return fmt.Errorf("error in main menu: %w", err)
			}
			// After menu closes, continue showing map
			continue

		case ExitGame:
			return nil

		case NoAction:
			// Unknown key pressed, just continue
			continue

		default:
			// Other keys (inventory, settings, help) - just continue for now
			continue
		}
	}
}

// openMainMenu opens the main menu and handles its flow
func (mc *MapController) openMainMenu() error {
	// Use the same routing logic as MainMenuListenV2
	return MainMenuListenV2(mc.user, mc.reader)
}