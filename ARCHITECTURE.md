# Project Architecture

Welcome to the **Weather app** codebase! This document provides an overview of the project's architecture, describing the purpose and structure of each major folder. The architecture is designed for clarity, scalability, and maintainability, following best practices for modern Flutter/Dart applications.



## Table of Contents

- [Overview](#overview)
- [Directory Structure](#directory-structure)
  - [core](#core)
  - [main](#main)
- [Module Responsibilities](#module-responsibilities)
- [Best Practices](#best-practices)

## Overview

The project is organized into two main layers:

- **core**: Contains all domain logic, data access, and shared infrastructure.
- **main**: Contains the application's feature modules, presentation/UI, and app-specific logic.

This separation ensures a clean architecture, making the codebase easy to test, extend, and maintain.



## Directory Structure

### `core/`

The `core` directory contains all the foundational building blocks and domain logic of the application. It is platform-agnostic and does not depend on Flutter UI.

- **data/**  
  Data access layer, including:
  - `data_sources/`: APIs, services, and other data providers.
  - `models/`: Data transfer objects and serialization logic.
  - `repositories/`: Concrete implementations of domain repositories.

- **domain/**  
  Domain layer, including:
  - `entities/`: Pure data classes representing business objects.
  - `enums/`: Enumerations used throughout the domain.
  - `exceptions/`: Custom exception types for domain errors.
  - `repositories/`: Abstract repository interfaces for dependency inversion.

- **infra/**  
  Infrastructure and cross-cutting concerns, such as:
  - `either/`: Utility for handling success/failure with Either types
  - `env/`: Environment variabled access classs
  - `exception/`: Base exception classes and error handling.
  - `firebase/`: Firebase integration and setup.
  - `logger/`: Logging utilities.
  - `service_locator/`: Dependency injection and service location.

- **navigation/**  
  Navigation logic, including:
  - `navigator/`: Navigator implementation.
  - `routes/`: Route definitions and navigation targets.



### `main/`

The `main` directory contains all app-specific code, including features, UI, and presentation logic.

- **modules/**  
  Feature modules, each with its own substructure:
  - `auth/`: Authentication flows (bloc, navigation, presentation).
  - `home/`: Home screen and weather features (bloc, navigation, presentation).
  - `splash/`: Splash screen logic and presentation.

- **shared/**  
  Shared UI components, themes, and utilities used across modules.

## Module Responsibilities

- **Bloc**: Handles state management and business logic. Each Bloc listens to UI events, calls the appropriate use cases, and emits states based on the outcomes.
- **Navigation**: Centralizes route definitions.
- **Presentation**: Contains the UI (widgets, pages) and dispatches events to the Bloc in response to user interaction.

Each module is self-contained and follows clean architecture principles, promoting modularity, testability, and scalability.
