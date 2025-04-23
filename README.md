# Expenses Management App

A Flutter application for managing personal expenses with analytics capabilities, built with Firebase, Riverpod, and GoRouter.

## Features

- **Expense Management**:
  - Add, edit, and delete expenses
  - Form validation for expense entries
  - Date selection for expenses
  - Swipe-to-delete functionality

- **Analytics**:
  - Weekly expense summary with bar chart visualization
  - Key statistics display (total, average, min/max amounts)
  - Pull-to-refresh functionality

- **Navigation**:
  - Bottom navigation bar with two tabs (Expenses and Analytics)
  - Floating action button for adding new expenses
  - Named routing with GoRouter

- **State Management**:
  - Riverpod for state management
  - AsyncNotifierProvider for expense list
  - Provider for analytics data

## Technical Stack

- **Frontend**: Flutter (Material 3 design)
- **State Management**: Riverpod
- **Navigation**: GoRouter
- **Backend**: Firebase (Firestore)
- **Charts**: fl_chart package

## Project Structure
```txt
lib/
├── data/
│ ├── models/ # Data models (Expense, AnalyticsSummary)
│ └── repositories/ # Firebase repository implementations
├── routes/ # Routing configuration
├── ui/
│ ├── core/ # Shared widgets (LoadingIndicator)
│ ├── expenses_analytics/ # Analytics feature
│ │ ├── viewmodels/ # Analytics view model
│ │ ├── views/ # Analytics screen
│ │ └── widgets/ # Analytics components
│ ├── manage_expenses/ # Expenses feature
│ │ ├── viewmodels/ # Expenses view model
│ │ ├── views/ # Expenses screens
│ │ └── widgets/ # Expense components
│ └── navigation/ # Main navigation (TabsScreen)
└── main.dart # App entry point
```


## Getting Started

### Prerequisites

- Flutter SDK
- Firebase project configured
- Google Services files (removed from this repository)

### Installation

1. Clone the repository
2. Add your Firebase configuration files
3. Run `flutter pub get`
4. Run `flutter run`

## Screens

1. **Main Screen**: 
   - Tab 1: Expenses list with add/edit/delete functionality
   - Tab 2: Analytics dashboard with weekly summary

2. **Expense Form**:
   - Add new expense or edit existing one
   - Form validation for title and amount
   - Date picker integration

## Dependencies

- flutter_riverpod: ^2.4.9
- go_router: ^12.0.0
- firebase_core: ^2.18.0
- fl_chart: ^0.65.0
- cloud_firestore: ^5.6.5

## Future Improvements

- Add user authentication
- Implement categories for expenses
- Add monthly/yearly analytics views
- Implement offline-first functionality
- Add export/import capabilities
