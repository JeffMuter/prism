1. Menus should be as simple as possible to create / alter & read the code. the point is a minimal footprint.

2. Menus have a few obvious needs across all menus. a name the user sees, a description to explain to the user what the menu option does, a command, which is the function that runs when the option is selected, and then a 'previousScreen', which is some kind of common rendering, but at this stage of development, is either the map, or another Menu. Every menu has 3 common commands, 'back' which takes them to the previousScreen as mentioned before, and exit, which will end the program for the user, finally map returns the user to the screen with the map, as it's sort of the base screen for the app.

current commands should never exit the application, as the currently do.

menus need a border of \ marks, and 1 space/line of padding.

if the content of a line would pour over, which we can detect via screen width, then we need to create a line break, before adding the border & spacing around the menu content.

menu content involved the title of the menu, then each menu option which can be selected, and their descriptions. whether ping, back, exit, it should explain what that menu option would do.

if a command does not create a new menu, it should put the user back in the menu they were originally in.

hitting 'back' while in the main menu, will return you to the map, but hitting 'back' in locations would take you to the main menu, as that would be the previous screen. but hitting 'map' anywhere, takes you back to the map screen.

3. Testing: much testing needs done for the menu system, and we need consistent data on integration testing. It's very important that it is simple to write tests that simulate user behavior, of moving through the menu system.

---

## Analysis of Current Menu System vs. Spec

### Current State Assessment

**Positive aspects of current implementation:**
- Good help system foundation with HelpProvider interface (`menus/help.go:17-20`)
- Dependency injection for input via `util.InputReader` allows testability
- Some testing infrastructure exists (`menus/mainMenu_test.go`)

**Major gaps from spec requirements:**

1. **Navigation Structure Violation**: Current menus don't follow the spec's navigation model
   - `MainMenuListen()` (`menus/mainMenu.go:17`) returns errors that exit the application instead of returning to previous screens
   - No consistent "back", "exit", "map" commands across all menus
   - Each menu has its own input handling logic instead of unified system

2. **UI/UX Issues**: Missing visual requirements
   - No border rendering with backslash marks and padding
   - No line wrapping detection for screen width
   - No consistent menu formatting structure

3. **Architectural Problems**:
   - Functions like `LocationMenu()` (`menus/locMenu.go:10`) and `EggMenuOptions()` (`menus/eggMenu.go:10`) have inconsistent patterns
   - Tight coupling between menu logic and business logic
   - No centralized menu state management

### Package Organization Recommendations

**Current structure works but needs refactoring:**
```
menus/
├── core/           # New: Core menu infrastructure
├── definitions/    # New: Menu definitions separated from logic  
├── rendering/      # New: UI rendering components
└── navigation/     # New: Navigation state management
```

**Rendering separation**: Menu rendering components should likely stay in the `menus` package rather than `render` package, since:
- `render/render.go` is focused on game world rendering (map, locations, canvas)
- Menu rendering has different concerns (borders, text formatting, screen space management)
- Keeping menu rendering in `menus` package maintains cohesion

### Testing Infrastructure Needed

**Critical testing improvements required:**

1. **Menu Navigation Testing**:
   - Integration tests that simulate full user journeys through menu hierarchy
   - Mock input streams that can test multi-step interactions
   - Navigation state verification (ensuring "back" leads to correct previous menu)

2. **UI Rendering Testing**:
   - Border and padding rendering verification
   - Line wrapping behavior testing
   - Screen width handling edge cases

3. **Menu Definition Testing**:
   - Command registration and execution testing  
   - Menu composition and hierarchy validation
   - Help system completeness verification

4. **Enhanced Test Utilities Needed**:
   ```go
   // Example of needed test infrastructure
   type MenuTestSuite struct {
       inputSequence []string
       expectedScreens []string
       navigationHistory []MenuState
   }
   ```

5. **Current Testing Gaps**:
   - Only basic command execution testing in `mainMenu_test.go:10-43`
   - No integration testing across menu transitions
   - No UI rendering validation
   - Limited edge case coverage for invalid input handling

### Work Distribution Recommendation

**All core work should remain in `menus` package** with these internal subdivisions:
- Menu behavior and navigation logic
- Menu UI rendering and formatting  
- Menu definitions and configuration
- Input handling and validation

The `render` package should remain focused on game world rendering, while `menus` handles all menu-related rendering concerns.
