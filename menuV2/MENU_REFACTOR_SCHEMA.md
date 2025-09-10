# Menu System Refactor Architecture Schema

## Current State Analysis

**Existing Problems:**
- Simple linear menu system that prints all options without organization
- No filtering or search capabilities for large datasets (workers, locations, eggs)
- No pagination for long lists
- Basic text-based UI with no visual hierarchy
- No keyboard navigation (arrow keys)
- Poor scalability for hundreds of items

**Current Menu Flow:**
```
MainMenu → LocationMenu → WorkerMenu → Individual Worker Actions
       → EggMenu → Individual Egg Actions
       → Other static menus
```

## Proposed Architecture

### 1. Menu Type Classification

#### **Static Menus**
- **Purpose**: Fixed options that rarely change (< 20 items)
- **Examples**: Main Menu, Help Menu, Settings Menu
- **Features**: 
  - Pretty borders and visual styling
  - Clear option numbering
  - Help text integration
- **Implementation**: Enhanced version of current menu system

#### **Dynamic Menus** 
- **Purpose**: Display potentially large, filterable datasets
- **Examples**: Worker List, Location List, Egg List, Task List
- **Features**:
  - Filtering by multiple criteria
  - Pagination
  - Search functionality
  - Sorting options
  - Keyboard navigation

### 2. Core Menu System Components

```
MenuSystem
├── StaticMenu
│   ├── Border rendering
│   ├── Option display
│   └── Simple input handling
├── DynamicMenu
│   ├── DataProvider interface
│   ├── FilterEngine
│   ├── PaginationController
│   ├── SearchEngine
│   └── NavigationHandler
├── MenuRenderer
│   ├── Border styles
│   ├── Color schemes
│   └── Layout management
└── InputHandler
    ├── Keyboard navigation
    ├── Command parsing
    └── Help system integration
```

### 3. Dynamic Menu Architecture

#### **DataProvider Interface**
```go
type DataProvider interface {
    GetItems(filters map[string]interface{}, offset, limit int) ([]Printable, error)
    GetTotalCount(filters map[string]interface{}) (int, error)
    GetAvailableFilters() []FilterDefinition
    GetSortOptions() []SortOption
}
```

#### **FilterEngine**
- Support multiple filter types:
  - Text search (name contains)
  - Categorical filters (type equals)
  - Range filters (level between X and Y)
  - Boolean filters (is_active = true)
- Filter combination with AND/OR logic
- Filter persistence within session

#### **Navigation System**
- Arrow key navigation through options
- Page Up/Down for pagination
- Tab between filter inputs
- Escape to go back
- Enter to select
- '/' for search mode
- '?' for help

### 4. Menu Types Implementation

#### **Static Menu Structure**
```
┌─────────────────────────────────────┐
│            MAIN MENU               │
├─────────────────────────────────────┤
│  1. View Locations                  │
│  2. View Workers                    │
│  3. View Eggs                       │
│  4. Create New Location             │
│  5. Connect to Location             │
│  6. Settings                        │
│  7. Help                            │
│  8. Quit                            │
└─────────────────────────────────────┘
Enter choice (1-8) or '?' for help: _
```

#### **Dynamic Menu Structure**
```
┌─────────────────────────────────────────────────────────────────┐
│                        WORKER MANAGEMENT                        │
├─────────────────────────────────────────────────────────────────┤
│ Filters: [Name: ___] [Location: All ▼] [Status: Active ▼]      │
│ Sort by: Name ▲                                    Page 1 of 5  │
├─────────────────────────────────────────────────────────────────┤
│ ► 1. Alice        │ Mining    │ Iron Mine    │ Active  │ Lvl 5  │
│   2. Bob          │ Farming   │ Wheat Field  │ Active  │ Lvl 3  │
│   3. Carol        │ Resting   │ Home Base    │ Idle    │ Lvl 7  │
│   4. Dave         │ Logging   │ Forest       │ Active  │ Lvl 2  │
│   5. Eve          │ Mining    │ Iron Mine    │ Active  │ Lvl 4  │
├─────────────────────────────────────────────────────────────────┤
│ Navigation: ↑↓ Select │ Enter: Manage │ /: Search │ F: Filter   │
│ PgUp/PgDn: Pages │ Tab: Next Filter │ Esc: Back │ ?: Help      │
└─────────────────────────────────────────────────────────────────┘
```

### 5. Implementation Strategy

#### **Phase 1: Core Infrastructure**
1. Create base menu interfaces and types
2. Implement MenuRenderer with border styling
3. Create InputHandler with keyboard navigation
4. Build StaticMenu implementation

#### **Phase 2: Dynamic Menu Framework**
1. Implement DataProvider interface
2. Create FilterEngine with basic text filtering
3. Build PaginationController
4. Implement basic DynamicMenu

#### **Phase 3: Feature Enhancement**
1. Add advanced filtering (categorical, range, boolean)
2. Implement sorting functionality
3. Add search capabilities
4. Enhanced keyboard navigation

#### **Phase 4: Integration & Polish**
1. Migrate existing menus to new system
2. Add color schemes and styling
3. Performance optimization
4. User experience refinements

### 6. Data Flow Architecture

```
User Input → InputHandler → MenuController → DataProvider → Database
                    ↓              ↓              ↓
                FilterEngine → PaginationController → MenuRenderer → Display
```

### 7. Configuration System

#### **Menu Configuration**
```go
type MenuConfig struct {
    Title           string
    BorderStyle     BorderStyle
    PageSize        int
    DefaultSort     SortOption
    EnabledFeatures []MenuFeature
    KeyBindings     map[string]Action
}
```

#### **Filter Configuration**
```go
type FilterDefinition struct {
    Name        string
    Type        FilterType  // TEXT, SELECT, RANGE, BOOLEAN
    Field       string
    Options     []string    // for SELECT filters
    DefaultValue interface{}
}
```

### 8. User Experience Enhancements

#### **Visual Improvements**
- Consistent borders and spacing
- Color coding for different states
- Progress indicators for loading
- Clear visual hierarchy

#### **Interaction Improvements**
- Intuitive keyboard shortcuts
- Context-sensitive help
- Undo/redo for filter changes
- Remember user preferences

#### **Performance Optimizations**
- Lazy loading of data
- Caching of filtered results
- Efficient pagination
- Background data prefetching

### 9. Backward Compatibility

- Maintain existing menu function signatures during transition
- Gradual migration path for each menu type
- Fallback to simple display for unsupported features
- Configuration flags to enable/disable new features

### 10. Future Extensions

- Multi-column sorting
- Saved filter presets
- Export functionality
- Bulk operations on selected items
- Customizable layouts
- Plugin system for custom filters

## Implementation Notes

- Use composition over inheritance for menu types
- Implement comprehensive error handling
- Include extensive unit tests for each component
- Document all public interfaces thoroughly
- Consider internationalization from the start
- Plan for accessibility features