# Clean Architecture Documentation

## Overview

This Mobile Money Application follows **Clean Architecture** principles, ensuring separation of concerns, testability, and maintainability. The architecture is organized into three main layers: **Domain**, **Data**, and **Presentation**.

## Architecture Layers

### 1. Domain Layer (`lib/features/{feature}/domain/`)
The innermost layer containing business logic. It has no dependencies on other layers.

**Structure:**
- `entities/` - Core business objects (User, Wallet, Transaction, etc.)
- `repositories/` - Abstract repository interfaces
- `usecases/` - Business logic use cases

**Key Principles:**
- Pure Dart classes (no Flutter dependencies)
- Entities are simple data classes
- Use cases contain single business logic operations
- Repository interfaces define contracts for data operations

### 2. Data Layer (`lib/features/{feature}/data/`)
Handles data operations and implements domain repository interfaces.

**Structure:**
- `models/` - Data transfer objects (DTOs) that extend entities
- `datasources/` - Remote and local data sources
  - `*_remote_data_source.dart` - API calls
  - `*_local_data_source.dart` - Local storage (SharedPreferences, etc.)
- `repositories/` - Repository implementations

**Key Principles:**
- Models extend domain entities
- Data sources handle API calls and local storage
- Repository implementations coordinate between data sources
- Handles error mapping and network checks

### 3. Presentation Layer (`lib/features/{feature}/presentation/`)
UI layer using BLoC pattern for state management.

**Structure:**
- `bloc/` - BLoC files (events, states, bloc)
- `pages/` - Screen widgets
- `widgets/` - Reusable UI components (optional)

**Key Principles:**
- BLoC handles business logic through use cases
- UI is reactive to state changes
- Separation of UI and business logic

## Core Layer (`lib/core/`)

Shared utilities and infrastructure:

- `error/` - Failure classes and error handling
- `usecase/` - Base use case interfaces
- `network/` - Network connectivity checking
- `utils/` - Constants, validators, etc.
- `di/` - Dependency injection setup (GetIt)

## Feature Structure

Each feature follows this structure:

```
lib/features/{feature}/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
├── data/
│   ├── models/
│   ├── datasources/
│   └── repositories/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

## Current Features

### 1. Authentication (`features/auth/`)
- **Domain**: User entity, auth repository interface, use cases (SendOTP, VerifyOTP, SubmitProfile, etc.)
- **Data**: UserModel, remote/local data sources, repository implementation
- **Presentation**: AuthBloc, LoginScreen, OtpScreen, ProfileScreen

### 2. Splash (`features/splash/`)
- **Domain**: Uses auth use cases
- **Presentation**: SplashBloc, SplashScreen

### 3. Wallet (`features/wallet/`)
- **Domain**: Wallet entity, repository interface (ready for implementation)

### 4. Transaction (`features/transaction/`)
- **Domain**: Transaction entity, repository interface (ready for implementation)

### 5. Bill Payment (`features/bill_payment/`)
- **Domain**: BillPayment entity, repository interface (ready for implementation)

### 6. Airtime (`features/airtime/`)
- **Domain**: AirtimePurchase entity, repository interface (ready for implementation)

## Dependency Flow

```
Presentation → Domain ← Data
     ↓           ↑        ↓
   BLoC      Use Cases  Models
     ↓           ↑        ↓
  Use Cases  Entities  Data Sources
```

**Rules:**
- Presentation depends on Domain
- Data depends on Domain
- Domain has no dependencies
- Presentation never directly depends on Data

## Dependency Injection

Using **GetIt** for dependency injection. Setup is in `lib/core/di/injection_container.dart`.

**Registration Order:**
1. Core (NetworkInfo, etc.)
2. Data Sources
3. Repositories
4. Use Cases
5. BLoCs

## Error Handling

Using **dartz** package's `Either<Failure, Success>` pattern:

- `Left` = Failure (error)
- `Right` = Success (data)

Failure types:
- `ServerFailure` - API/server errors
- `NetworkFailure` - Connectivity issues
- `CacheFailure` - Local storage errors
- `ValidationFailure` - Input validation errors
- `AuthenticationFailure` - Auth-related errors

## Adding a New Feature

1. **Create Domain Layer:**
   - Define entities in `domain/entities/`
   - Create repository interface in `domain/repositories/`
   - Create use cases in `domain/usecases/`

2. **Create Data Layer:**
   - Create models extending entities in `data/models/`
   - Implement remote data source in `data/datasources/`
   - Implement local data source (if needed)
   - Implement repository in `data/repositories/`

3. **Create Presentation Layer:**
   - Create BLoC (events, states, bloc) in `presentation/bloc/`
   - Create screens in `presentation/pages/`
   - Create reusable widgets (if needed) in `presentation/widgets/`

4. **Register Dependencies:**
   - Add registrations in `lib/core/di/injection_container.dart`

## Testing Strategy

- **Domain**: Unit tests for use cases and entities
- **Data**: Unit tests for repository implementations and data sources
- **Presentation**: Widget tests for UI, BLoC tests for state management

## Best Practices

1. **Entities**: Keep them simple, pure Dart classes
2. **Use Cases**: One use case = one business operation
3. **Repository Pattern**: Abstract in domain, implement in data
4. **Error Handling**: Always use Either<Failure, Success>
5. **State Management**: Use BLoC for complex state, ValueNotifier for simple state
6. **Dependency Injection**: Register all dependencies in injection_container.dart
7. **Naming**: Follow feature-based naming (e.g., `auth_bloc.dart`, not `bloc_auth.dart`)

## Next Steps

1. Implement remaining features (Wallet, Transaction, Bill Payment, Airtime)
2. Add proper API integration in remote data sources
3. Implement local storage using SharedPreferences or secure storage
4. Add comprehensive error handling and user feedback
5. Implement transaction limits and validation
6. Add push notifications support
7. Implement PIN/biometric security features
