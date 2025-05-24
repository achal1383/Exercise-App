# 📱 Exercise App

A simple Flutter exercise app built using **Flutter**, **Dart**, and **BLoC** architecture. This app fetches workouts from a REST API, lets users view details, start a timer for each exercise, and tracks daily streaks and completed workouts.

---

## 🔧 Features
- 🏃‍♀️ View list of exercises from a mock API
- 📋 Exercise detail screen with timer and completion status
- ✅ Track completed exercises and view them in a dedicated screen
- 🔄 Daily streak tracking using local storage (SharedPreferences)
- ✨ Animated timer with circular progress
- 🎨 Clean and responsive UI with professional design

---

## 📂 Folder Structure
```
lib/
├── data/
│   ├── exercise_model.dart         # Data model
│   └── exercise_repository.dart    # API calls
├── view/
│   ├── home_screen.dart            # Exercise list UI
│   ├── exercise_detail_screen.dart# Detail + Timer UI
│   └── completed_exercises_screen.dart # Completed exercises UI
├── viewmodel/
│   └── exercise_bloc.dart          # BLoC logic
└── main.dart                       # App entry point
```

---

## 📦 Packages Used
- [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- [http](https://pub.dev/packages/http)
- [shared_preferences](https://pub.dev/packages/shared_preferences)

---

## 🚀 Getting Started
1. **Clone the repo**
```bash
git clone https://github.com/your-username/exercise_app.git
cd exercise_app
```
2. **Install dependencies**
```bash
flutter pub get
```
3. **Run the app**
```bash
flutter run
```

---

## 🌐 API Endpoint
```
GET https://68252ec20f0188d7e72c394f.mockapi.io/dev/workouts
```

---

## 📸 Screenshots
_Add your screenshots here if available._

---

## 💡 Future Enhancements
- User authentication and profiles
- Cloud sync for streaks and completions
- Rich animations with Lottie or Rive

---

## 📃 License
MIT License. Free to use and modify.

---
