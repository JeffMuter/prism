# Current Menu System Documentation - Fallback Reference

This document serves as a comprehensive reference for the current menu system before refactoring. It documents all menu displays, command options, and their corresponding functions.

## Menu System Flow

```
Application Start (main.go:47-49)
    ↓ (calls menus.MainMenuListen)
Main Menu
    ├── ping → Update location (mainMenu.go:40-42)
    ├── new location → Create new location flow (mainMenu.go:43-77)
    ├── connect → Connect to nearby locations (mainMenu.go:78-87)
    ├── locations → Location Menu (mainMenu.go:88-93)
    ├── eggs → Egg Menu (mainMenu.go:94-99)
    ├── create home → Home location setup (mainMenu.go:100-105)
    └── ? → Help system (help.go:68-80)

Location Menu (locMenu.go:10-40)
    ↓ (displays user locations, user selects one)
    ├── [Location Selection] → Worker Display (workerMenu.go:12-30)
        ↓ (shows workers at location, user selects worker)
        Worker Menu Options (workerMenu.go:34-118)
            ├── move → Move worker to different location (lines 49-76)
            ├── assign → Assign worker to different task (lines 77-108)
            ├── swap → Toggle worker working status (lines 109-113)
            └── ? → Worker help (help.go + workerMenuHelp.go)

Egg Menu (eggMenu.go:10-35)
    ├── [Egg Selection] → Automatic hatch (eggMenu.go:30-33)
    └── (No additional options - single action menu)
```

---

## Detailed Menu Documentation

### 1. Main Menu (mainMenu.go:17-110)

**Location**: `menus/mainMenu.go:17-110`
**Function**: `MainMenuListen(thisUser user.User, reader util.InputReader)`

#### Display
```
Welcome to Prism. Choose a command to begin:
Type '?' for help with available commands.
```

#### Available Commands

| Command | Description | Function Location | Implementation |
|---------|-------------|-------------------|----------------|
| `ping` | Update your current location using geolocation | mainMenu.go:40-42 | Calls `render.PaintScreen(&thisUser)` |
| `new location` | Create a new location at your current position | mainMenu.go:43-77 | Multi-step location creation process |
| `connect` | Connect to any nearby existing locations | mainMenu.go:78-87 | Calls `locations.ConnectToLocation(thisUser)` + `workers.AddEgg(newLocId)` |
| `locations` | View and manage your locations | mainMenu.go:88-93 | Calls `LocationMenu(thisUser.Id)` |
| `eggs` | View and hatch your worker eggs | mainMenu.go:94-99 | Calls `EggMenuOptions(thisUser)` |
| `create home` | Convert one of your locations into a home | mainMenu.go:100-105 | Calls `setHomeLocation(thisUser.Id)` |
| `?` | Show help menu | help.go:74-80 | Displays MainMenuHelp commands |

#### Help System (mainMenuHelp.go:7-40)
**Help Provider**: `MainMenuHelp struct`
**Menu Name**: "Main Menu"

---

### 2. Location Menu (locMenu.go:10-40)

**Location**: `menus/locMenu.go:10-40`
**Function**: `LocationMenu(userId int)`

#### Display Flow
1. **Location Selection Phase**:
   - Gets all user locations: `locations.GetLocationsForUser(userId)`
   - Enriches with resource data: `locations.GetResourceDataByLocationId()`
   - Displays printable locations: `locations.MakeLocsPrintable(userLocations, locations.SomeDetailsPrintFactory{})`
   - User selects via: `util.PrintNumericSelection(printables)`

2. **Worker Selection Phase**:
   - Calls `displayWorkersAtLocation(userLocations[locationChosenIndex])`
   - Shows workers at selected location
   - User selects worker via numeric selection

3. **Worker Action Phase**:
   - Calls `workerMenuOptions(userId, chosenWorker)`

#### Functions Called
- `locations.GetLocationsForUser(userId)` - Get user's locations
- `locations.GetResourceDataByLocationId()` - Get location resources
- `locations.MakeLocsPrintable()` - Format locations for display
- `util.PrintNumericSelection()` - Handle user selection
- `displayWorkersAtLocation()` - Show workers at location
- `workerMenuOptions()` - Handle worker management

---

### 3. Worker Display (workerMenu.go:12-30)

**Location**: `menus/workerMenu.go:12-30`
**Function**: `displayWorkersAtLocation(loc locations.Location)`

#### Display
```
loc id: [LOCATION_ID]
Your workers at [LOCATION_NAME]:
[NUMBER] len of locWorkers
```

#### Implementation
- Gets workers: `workers.GetWorkersRelatedToLocation(loc.Id)`
- Formats workers: `workers.MakeWorkersPrintable(locationWorkers, workers.WorkerStateFactory{})`
- User selects: `util.PrintNumericSelection(printables)`
- Returns selected worker

---

### 4. Worker Menu Options (workerMenu.go:34-118)

**Location**: `menus/workerMenu.go:34-118`
**Function**: `workerMenuOptions(userId int, worker workers.Worker)`

#### Display
```
Choose an option for [WORKER_NAME] (type '?' for help)
```

#### Available Commands

| Command | Description | Function Location | Implementation |
|---------|-------------|-------------------|----------------|
| `move` | Move this worker to a different location | workerMenu.go:49-76 | Location selection → `workers.MoveWorkerToLocation()` + `tasks.SetWorkerTaskToNewTask(worker, "resting")` |
| `assign` | Assign this worker to a different task | workerMenu.go:77-108 | Task selection → `tasks.SetWorkerTaskToNewTask()` |
| `swap` | Toggle this worker's working status (working/resting) | workerMenu.go:109-113 | Calls `workers.ToggleWorkingForWorker(worker)` |
| `?` | Show worker menu help | help.go + workerMenuHelp.go | Displays WorkerMenuHelp commands |

#### Help System (workerMenuHelp.go:7-25)
**Help Provider**: `WorkerMenuHelp struct`
**Menu Name**: "Worker Menu"

#### Detailed Command Implementations

**Move Command Flow (lines 49-76)**:
1. Display: "nPick a location to move to:" (note: likely typo with 'n')
2. Get user locations: `locations.GetLocationsForUser(userId)`
3. Display locations: `locations.MakeLocsPrintable(usersLocations, locations.SomeDetailsPrintFactory{})`
4. User selects location: `util.PrintNumericSelection(printables)`
5. Move worker: `workers.MoveWorkerToLocation(worker, usersLocations[locationChosenIndex])`
6. Update worker location: `worker.LocationId = usersLocations[locationChosenIndex].Id`
7. Set to resting: `tasks.SetWorkerTaskToNewTask(worker, "resting")`

**Assign Command Flow (lines 77-108)**:
1. Display: "Tasks to assign the worker [WORKER_NAME] to do:"
2. Get possible tasks: `tasks.GetMapTaskTypeIdTaskNameFromLocationId(worker.LocationId)`
3. Format tasks: `tasks.MakeTasksPrintable(possibleTasks, tasks.NameTaskFactory{})`
4. User selects task: `util.PrintNumericSelection(printables)`
5. Assign task: `tasks.SetWorkerTaskToNewTask(worker, possibleTasks[chosenTaskIndex].Type)`
6. Display confirmation: "[WORKER_NAME] is now [TASK_TYPE]-ing"

**Swap Command (lines 109-113)**:
- Simple toggle: `workers.ToggleWorkingForWorker(worker)`

---

### 5. Egg Menu (eggMenu.go:10-35)

**Location**: `menus/eggMenu.go:10-35`
**Function**: `EggMenuOptions(user user.User)`

#### Display Flow
1. Gets available eggs: `workers.GetEggsAvailableForUser(user.Id)`
2. Error if no eggs: "no existing eggs to be found"
3. Displays eggs: `workers.MakeEggsPrintable(eggs, workers.EggStateFactory{})`
4. User selects egg: `util.PrintNumericSelection(printables)`
5. **Automatic Action**: Hatches selected egg: `workers.HatchEgg(chosenEgg.Id)`

#### Implementation
- **Note**: This is a single-action menu - selection immediately hatches the egg
- No additional sub-commands or options
- Returns error if hatching fails

---

### 6. Home Location Setup (homeMenu.go:9-34)

**Location**: `menus/homeMenu.go:9-34`
**Function**: `setHomeLocation(userId int)` (private function)

#### Display Flow
1. Gets user locations: `locations.GetLocationsForUser(userId)`
2. Displays locations: `locations.MakeLocsPrintable(userLocations, locations.SomeDetailsPrintFactory{})`
3. User selects location: `util.PrintNumericSelection(printables)`
4. Prompts for name: "Name the center of your future empire..."
5. Gets home name: `util.ReadCommandInput()`
6. Sets home: `locations.SetHomeLocation(&userLocations[locationChosenIndex], homeName)`

---

## Help System Architecture (help.go)

### Core Components

**HelpProvider Interface** (help.go:17-21):
```go
type HelpProvider interface {
    GetCommands() []Command
    GetMenuName() string
}
```

**Command Structure** (help.go:10-14):
```go
type Command struct {
    Name        string
    Description string
    Usage       string // Optional usage example
}
```

**MenuHelp System** (help.go:23-80):
- **Function**: `NewMenuHelp(provider HelpProvider)`
- **Help Display**: `ShowHelp()` - Formats and displays commands
- **Help Detection**: `IsHelpCommand(input string)` - Recognizes `?`, `help`, `h`
- **Help Handling**: `HandleHelpCommand(input string)` - Processes help requests

### Help Display Format
```
=== [MENU_NAME] Help ===
Available commands:
  [COMMAND]  - [DESCRIPTION]
             Usage: [USAGE_EXAMPLE]
  ?          - Show this help menu
```

---

## Supporting Systems

### 1. Input Handling
- **Primary**: `util.ReadCommandInput()` - Standard command input
- **Selection**: `util.PrintNumericSelection(printables)` - Numeric option selection
- **Reader Interface**: `util.InputReader` - Allows dependency injection for testing

### 2. Display Systems
- **Locations**: `locations.MakeLocsPrintable()` with `locations.SomeDetailsPrintFactory{}`
- **Workers**: `workers.MakeWorkersPrintable()` with `workers.WorkerStateFactory{}`
- **Eggs**: `workers.MakeEggsPrintable()` with `workers.EggStateFactory{}`
- **Tasks**: `tasks.MakeTasksPrintable()` with `tasks.NameTaskFactory{}`

### 3. Data Operations
- **Location Operations**: Create, connect, get user locations, set home
- **Worker Operations**: Move, assign tasks, toggle status, get by location
- **Egg Operations**: Get available, hatch
- **Task Operations**: Get possible tasks, set worker tasks

---

## Error Handling Patterns

Throughout the menu system, errors are consistently:
1. Wrapped with context using `fmt.Errorf()`
2. Bubbled up through the call stack
3. Include relevant IDs and parameters for debugging
4. Use descriptive error messages

Example pattern:
```go
if err != nil {
    return fmt.Errorf("error description with context: %w, additionalInfo: %v", err, contextInfo)
}
```

---

## Testing Support

The menu system supports testing through:
- **Dependency Injection**: `reader util.InputReader` parameter allows mock input
- **Test Files**: `menus/mainMenu_test.go`, `menus/help_test.go`
- **Interfaces**: Help system uses interfaces for testability

---

## Integration Points

### Application Entry Point (main.go:47-49)
```go
reader := util.NewStdinReader()
err = menus.MainMenuListen(thisUser, reader)
```

### Screen Rendering Integration
- Initial screen paint: `render.PaintScreen(&thisUser)` in main.go:41
- Location updates: `render.PaintScreen(&thisUser)` in ping command

### Database Operations
All menu operations ultimately interact with the database through:
- `locations` package functions
- `workers` package functions  
- `tasks` package functions
- `user` package functions

This fallback documentation captures the complete current menu system state and can serve as a reference during the refactoring process.