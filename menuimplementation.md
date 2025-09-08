# Menu System Implementation Plan

## Core Menu Types

A Menu is just:
- Title (name user sees)
- Slice of Options 
- Previous screen reference

An Option is just:
- Name 
- Description
- Command function

Then we loop through the menu, render it with `\` borders and padding, get user input, execute the matching command.

The three universal commands (back, exit, map) get automatically added to every menu's option slice.

```go
type Menu struct {
    Title string
    Options []Option
    Previous ??? // map or another Menu
}

type Option struct {
    Name string
    Desc string
    Command func() error // or maybe just func()?
}
```

Then one `Menu.Run()` method that handles the input loop, rendering, and command execution.

## Menu Rendering with Borders

## Navigation and Previous Screen Handling

## Universal Commands Implementation

## Input Handling and Command Execution

### Input Strategy: Numeric Selection
- All menus use numeric input (1, 2, 3, etc.) for consistency
- Invalid numeric input shows help text and re-prompts in current menu
- No text command support needed for foreseeable future

### Command Execution Pattern
```go
type Option struct {
    Name string
    Desc string
    Command func(*sql.DB) error  // Commands access DB directly as needed
}
```

### Navigation History Management
- Navigation history stored as slice that grows during runtime
- History cleared whenever user returns to map (from anywhere)
- No maximum depth limit - users return to map frequently enough
- "back" navigates to immediate previous menu from history
- "map" command available from any menu, clears history

### Error Handling Flow
1. Command fails and returns error
2. Print error message to user
3. Wait for user to press Enter to continue
4. Return user to map screen
5. Clear navigation history

*Note: Future notification overlay system will replace error printing*

### Menu Lifecycle
- Menus created fresh each time they're accessed
- No menu state stored in memory between uses  
- Menu options populated by fetching current data from DB

### Current Implementation Analysis
Looking at `menus/workerMenu.go:34-118`, current pattern:
- Mixed text commands ("move", "assign", "swap") and help system
- Direct DB access via workers/locations packages
- Commands return errors that bubble up and exit application
- Input handled via `util.ReadCommandInput()` and `util.PrintNumericSelection()`

**Key Changes Needed:**
1. Replace text commands with numeric selection
2. Prevent errors from exiting application - return to map instead
3. Standardize input handling across all menus
4. Implement navigation history tracking

### Future Consideration: Filtering System
**NEEDS FURTHER DISCUSSION**
- Large menus (100+ locations/workers) need filtering capability
- Location filtering by: name, type, other criteria
- Worker filtering by: name, stats (e.g., high strength)
- Implementation approach TBD - pre-filtering vs live filtering vs sub-menu

## Migration Strategy for Existing Menus

## Testing Approach