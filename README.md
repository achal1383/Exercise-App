# 🏋️ Exercise App

A simple Flutter workout/exercise app that follows **clean architecture** and uses **BLoC** for state management. The app displays a list of exercises, tracks completed ones, and includes a timer for each workout.

---

## 📁 Architecture

The app uses **Clean Architecture** principles with 3 primary layers:

```
lib/
🔽 core/                     # Common utilities, extensions, and theme
🔽 data/                     # Models and repositories (implements domain)
︎   🔽 models/               # Data layer models (DTOs)
︎   🔽 repositories/         # API and local data handling
🔽 domain/                   # Business logic and entities
︎   🔽 entities/             # Plain Dart objects (POJOs)
︎   🔽 repositories/         # Abstract repo contracts
🔽 presentation/             # UI and state management
︎   🔽 blocs/                # BLoC files
︎   🔽 screens/              # UI screens (Home, Detail)
︎   🔽 widgets/              # Shared UI widgets
🔽 main.dart                 # App entry point
```

---

## 🛆 Dependencies

- [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) – State management
- [`equatable`](https://pub.dev/packages/equatable) – For comparing bloc states
- [`http`](https://pub.dev/packages/http) – API calls
- `provider` (used indirectly via `flutter_bloc`)
- `material` theming with `ThemeData`

---

## 🎨 Theming

The app uses a centralized theme setup under `lib/core/theme/app_theme.dart`:

- Color palette based on `ColorScheme`
- Text styles via `TextTheme`
- All screens use `Theme.of(context)` instead of hardcoded styles

---

## 🚀 Features

✅ Fetch list of exercises  
✅ Track completed exercises  
✅ Timer and progress for each workout  
✅ Responsive and theme-driven UI  
✅ BLoC architecture for clean separation of concerns

---

## ▶️ Getting Started

```bash
# Clone the repository
git clone https://github.com/achal1383/Exercise-App.git
cd exercise_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---




---

## 🧪 Folder Highlights

| Layer         | Description                                |
|---------------|--------------------------------------------|
| `data/`       | Handles API integration and maps models     |
| `domain/`     | Contains core business logic and contracts  |
| `presentation/` | UI logic using BLoC and Material widgets  |
| `core/`       | Theme definitions, constants, utilities     |

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

---

## 📝 License

[MIT](LICENSE)

---
