# RTS Platform — Coding Standards

## 1. Purpose

These standards define the coding and architectural conventions used throughout RTS Platform.

The purpose is to keep the codebase readable, predictable, modular, and maintainable as the platform grows.

These rules apply to the platform core, editor, runtime, tools, and project-facing systems unless a documented exception is necessary.

## 2. General Principles

### 2.1 Prefer clarity over cleverness

Code should be easy to understand and maintain.

Avoid unnecessarily complex solutions when a simpler design provides the same result.

### 2.2 Keep systems focused

Each system should have a clear responsibility.

A class or module should not accumulate unrelated responsibilities simply because they are convenient to place together.

### 2.3 Avoid hidden dependencies

Important dependencies between systems should be explicit.

Systems should not depend on unrelated global state when a clear interface or dependency can be used instead.

### 2.4 Avoid premature abstraction

Do not create generic frameworks or abstractions before there is a demonstrated need for them.

However, repeated patterns that represent a real architectural concept should be extracted into reusable systems.

## 3. Architecture Rules

### 3.1 Core independence

Platform core systems must not depend on game-specific content.

Examples of game-specific concepts include:

* historical factions;
* specific unit types;
* specific weapons;
* specific resources;
* specific technologies;
* specific maps;
* specific scenarios.

### 3.2 Dependency direction

Higher-level systems may depend on lower-level platform systems.

Lower-level systems must not depend on higher-level game-specific systems.

The dependency direction should remain deliberate and predictable.

### 3.3 Data over hardcoded content

Game content should be represented as data whenever practical.

Creating a new gameplay object should normally not require modifying platform core code.

### 3.4 Composition over deep inheritance

Prefer composition and reusable components over large inheritance hierarchies.

Inheritance should be used when the relationship represents a genuine and stable type hierarchy.

### 3.5 No prototype code in core systems

Experimental code must remain isolated from stable platform systems.

Prototype implementations should not become permanent dependencies simply because they were implemented first.

## 4. GDScript Conventions

### 4.1 Naming

Use clear and descriptive names.

* Classes: `PascalCase`
* Functions: `snake_case`
* Variables: `snake_case`
* Constants: `UPPER_SNAKE_CASE`
* Private members: `_snake_case`
* Files: `snake_case`

Examples:

```gdscript
class_name EntityManager

const MAX_ENTITIES := 2000

var entity_count := 0

func create_entity() -> int:
    return 0
```

### 4.2 Explicit types

Use static typing where it improves clarity and catches errors.

Prefer:

```gdscript
var entity_count: int = 0
```

over:

```gdscript
var entity_count = 0
```

Function arguments and return values should normally have explicit types.

### 4.3 Constants

Values representing fixed configuration or limits should be constants when appropriate.

Avoid unexplained magic numbers.

Prefer:

```gdscript
const MAX_SELECTION_DISTANCE: float = 500.0
```

over embedding the value repeatedly throughout the code.

### 4.4 Functions

Functions should generally perform one clear task.

Large functions should be split when doing so improves readability or separation of responsibility.

### 4.5 Comments

Comments should explain intent, constraints, or non-obvious decisions.

Do not write comments that merely restate what the code obviously does.

## 5. File and Folder Organization

Files should be grouped by system and responsibility.

Avoid placing unrelated scripts into a single directory simply because they are convenient to access.

The project structure should reflect architectural boundaries.

## 6. Error Handling

Errors should be detected as early as practical.

Important failures should provide useful diagnostic information.

Silent failure should be avoided for conditions that can corrupt project data, simulation state, or editor state.

## 7. Editor and Runtime Separation

Editor-only functionality must remain separate from runtime functionality.

Runtime systems must not require the World Editor to operate.

The editor may inspect and manipulate runtime-compatible data, but the game runtime must remain capable of running without editor-only systems.

## 8. Data and Serialization

Persistent project data should use explicit, versionable formats.

Serialized data should not depend on transient runtime state.

Changes to persistent formats should consider backward compatibility and migration where appropriate.

## 9. Testing

Core systems should be designed so that important behavior can be tested independently.

Critical platform functionality should not require launching a complete game or editor session for every test.

## 10. Performance

Performance-sensitive systems should be designed with large RTS workloads in mind.

Avoid unnecessary allocations, repeated expensive searches, and excessive per-entity processing in frequently executed code.

Optimization should be based on measured bottlenecks rather than assumptions.

## 11. Exceptions

These standards are guidelines for maintaining the architecture, not obstacles to solving real problems.

When an exception is necessary, the reason should be documented when the decision has architectural significance.
