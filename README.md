# Flutter Exercise App (Clean Architecture + BLoC)

A simple exercise tracker app built with Flutter using **Clean Architecture** and **BLoC pattern**.

---

## 🌟 Features

- Fetch exercises from a REST API
- Display exercise list with name and duration
- Tap on an exercise to view full details
- Start an animated timer for the selected exercise
- Show “Exercise Completed” message on finish
- Mark exercise as completed
- Optional: Track consecutive workout days

---

## 🧱 Clean Architecture Structure

lib/
│
├── data/
│   ├── models/             --> JSON models from API
│   └── repositories/       --> Implementation of domain repositories
│
├── domain/
│   ├── entities/           --> Core business models (pure Dart)
│   ├── repositories/       --> Abstract definitions
│   └── usecases/           --> Business logic
│
├── presentation/
│   ├── blocs/              --> BLoC state management
│   └── screens/            --> UI screens (Home, Detail)
│
└── main.dart               --> App entry point

---

## 🔌 API Endpoint

GET https://68252ec20f0188d7e72c394f.mockapi.io/dev/workouts

Returns a list of exercises with fields like:

- id
- name
- description
- duration
- difficulty

---

## 🛠️ Getting Started

1. **Clone this repository:**

   git clone <https://github.com/achal1383/Exercise-App.git>
   cd exercise_app

2. **Install packages:**

   flutter pub get

3. **Run the app:**

   flutter run

---

## 📦 Dependencies

- flutter_bloc
- http
- equatable (optional)
- lottie (optional for animations)

---

## ✨ UI Details

- Beautiful, responsive layout using Flutter’s Material widgets
- Animated circular progress indicator during countdown
- Custom background colors and styled cards
- Optional feature to track workout streaks

---

## 🚀 Future Improvements


- Add Firebase authentication
- Dark mode support
- Notification/reminder feature

---

## 👩‍💻 Author

**Rhea (Achal)**  
Crafted with Flutter 💙

---

## 📄 License

This project is licensed under the MIT License.
