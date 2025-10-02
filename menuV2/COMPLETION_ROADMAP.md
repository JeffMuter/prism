# MenuV2 Completion Roadmap

This document outlines the remaining tasks to complete the menuV2 system replacement.

## Current Status

**✅ Completed:**
- Core menu infrastructure (Menu interface, SimpleMenu, GridMenu framework)
- Main menu with all original functionality
- Location type selection for new locations
- Basic locations grid menu
- Eggs menu functionality
- Route-based navigation system
- Unicode borders and keyboard navigation
- Input handling with arrow keys, enter, numeric selection

**⚠️ Partially Complete:**
- GridMenu framework exists but lacks filtering/pagination
- LocationsDataSource exists but basic implementation

## Priority-Ordered Tasks

### 1. **CRITICAL: Worker Management System**
**Priority: Highest - Core functionality missing**

#### 1.1 Worker Grid Menu
- Create WorkersDataSource implementing DataSource interface
- Implement worker data retrieval with location/task information
- Display workers in grid format with columns:
  - Name | Task | Location | Status | Level
- Basic navigation and selection

#### 1.2 Individual Worker Actions Menu
Port the following from `menus/workerMenu.go`:
- **Move Worker**: Select destination location → `workers.MoveWorkerToLocation()` + set to resting
- **Assign Task**: Select from available tasks → `tasks.SetWorkerTaskToNewTask()`
- **Toggle Status**: Working/resting toggle → `workers.ToggleWorkingForWorker()`

#### 1.3 Worker Menu Integration
- Add worker grid menu to main menu navigation
- Implement worker selection → individual worker actions flow
- Handle errors and user feedback properly

### 2. **HIGH: Home Location Setup**
**Priority: High - Missing core feature**

#### 2.1 Home Location Menu
- Create home location selection grid (reuse locations grid pattern)
- Add name input for home location
- Implement `locations.SetHomeLocation()` call
- Add to main menu navigation

### 3. **HIGH: Universal Filtering System**
**Priority: High - Major UX improvement**

#### 3.1 Filter Infrastructure
- Add filter state management to GridMenu
- Implement filter input fields in grid header
- Add 'F' hotkey to focus filter fields
- Support text search, dropdown selects, status filters

#### 3.2 Filter Implementation per Menu
- **Locations**: Filter by name, type
- **Workers**: Filter by name, location, status, task type
- **Eggs**: Filter by location

### 4. **MEDIUM: Pagination System**
**Priority: Medium - Scalability feature**

#### 4.1 Pagination Infrastructure
- Add page state management to GridMenu
- Implement page navigation (PgUp/PgDown, numeric input)
- Display "Page X of Y" indicator
- Configurable page size

#### 4.2 DataSource Pagination Support
- Modify DataSource interface to support offset/limit
- Update LocationsDataSource and WorkersDataSource
- Efficient data loading for large datasets

### 5. **MEDIUM: Enhanced Grid Visual Design**
**Priority: Medium - UI polish**

#### 5.1 Grid Layout Improvements
- Better column alignment and spacing
- Status indicators and visual hierarchy
- Progress indicators for loading states
- Enhanced border styling

#### 5.2 Status Color Coding
- Active/Idle worker status colors
- Location type indicators
- Task status visualization

### 6. **LOW: Advanced Features**
**Priority: Low - Nice to have**

#### 6.1 Search Enhancements
- '/' hotkey for instant search mode
- Search highlighting in results
- Multiple search criteria combinations

#### 6.2 Sorting Enhancements
- Click/hotkey column sorting
- Multi-column sort support
- Sort direction indicators

### 7. **CLEANUP: Remove Old System**
**Priority: Final - Cleanup task**

#### 7.1 Code Removal
- Delete entire `menus/` directory
- Remove old menu imports from main.go
- Update any remaining references

#### 7.2 Documentation Cleanup
- Remove CURRENT_MENU_SYSTEM_FALLBACK.md
- Update any documentation references

### 8. **QUALITY: Test Coverage**
**Priority: Throughout development**

#### 8.1 Unit Tests
- Test all new menu components
- Test worker actions and data sources
- Test filter and pagination logic

#### 8.2 Integration Tests
- Test complete menu navigation flows
- Test error handling and edge cases
- Test with various data scenarios

## Implementation Notes

### Worker Management Technical Details
- Worker actions should reuse existing functions from `workers/`, `tasks/`, `locations/` packages
- Maintain existing error handling patterns
- Follow existing data access patterns from old worker menu system

### Grid Menu Enhancement Pattern
- All grid menus should follow same filtering/pagination pattern
- Consistent keyboard shortcuts across all menus
- Reusable filter components for common filter types

### Navigation Consistency
- Maintain route-based navigation system
- Consistent back/exit behavior across all menus
- Uniform keyboard shortcut handling

## Success Criteria

**MenuV2 is "Complete" when:**
1. ✅ All original menu functionality is replicated
2. ✅ Worker management system fully functional
3. ✅ Home location setup working
4. ✅ Filtering system implemented on all grid menus
5. ✅ Pagination working for large datasets
6. ✅ Old menu system completely removed
7. ✅ Test coverage for all new components
8. ✅ UI polish and visual consistency achieved

**Acceptance Test:** User can perform all original menu operations using only menuV2 system with improved UX through filtering and pagination.