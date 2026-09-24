# RTS Platform — Architecture

## 1. Purpose

RTS Platform is a universal real-time strategy game development platform built on top of Godot.

The platform is not a single game and is not tied to a specific historical period, setting, faction, or gameplay concept.

Its purpose is to provide a reusable foundation for creating different RTS games and projects through a combination of:

* a powerful runtime;
* a World Editor;
* universal entities and components;
* data-driven game objects;
* terrain and world editing;
* triggers and scripting;
* pathfinding and large-scale unit management;
* multiplayer;
* AI;
* modding;
* project and asset management.

A World Editor should allow a developer to create and modify a complete RTS project without having to implement the underlying engine systems from scratch.

The platform should remain general-purpose. A WWII strategy game may be created with it, but the platform itself must not contain WWII-specific assumptions in its core architecture.

## 2. Core Principle

The platform is built as a **general-purpose RTS framework**, not as a game with an editor attached to it.

Game-specific content and rules must remain separate from the platform's core systems whenever possible.

## 3. Architecture Goals

The architecture should follow these goals:

### 3.1 General-purpose

The core must not depend on a specific game, genre setting, historical period, faction, unit type, or resource system.

### 3.2 Data-driven

Game objects and gameplay definitions should be primarily defined through data rather than hardcoded classes.

A project should be able to create new units, buildings, abilities, weapons, resources, factions, technologies, and other gameplay objects without modifying the platform core.

### 3.3 Modular

Major systems should be isolated and replaceable.

A project should not be forced to use every subsystem provided by the platform.

### 3.4 Editor-first

The World Editor is a fundamental part of the platform, not an external utility added later.

Systems should be designed so that they can be inspected, configured, and edited through the editor where appropriate.

### 3.5 Scalable

The runtime should be designed with large numbers of entities in mind.

The architecture should avoid unnecessary per-entity overhead and should remain suitable for large RTS battles.

### 3.6 Multiplayer-ready

Multiplayer must be considered from the beginning of the architecture rather than added as a separate feature at the end of development.

Core gameplay systems should have a clear separation between simulation state, player commands, and presentation.

### 3.7 Mod-friendly

Projects should be able to extend the platform with custom data, maps, assets, scripts, and gameplay systems without modifying the platform itself.

### 3.8 Cross-platform

The platform should target desktop operating systems supported by Godot, with particular attention to Linux and Windows.

### 3.9 Maintainable

The architecture should favor clear boundaries between systems over short-term implementation convenience.

Temporary prototypes must not become permanent dependencies of the core architecture.
