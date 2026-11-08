# Evently 🎉

A Flutter event-management app. Users sign in, browse events by category,
and create and manage their own events. Each user sees only their own events.

## Features
- Onboarding screens
- Sign up / login with Firebase Authentication (including Google Sign-In)
- Create, view, edit, and delete events (Cloud Firestore)
- Browse events by category with category filtering
- Light / dark theme switching
- Arabic / English localization

## Tech Stack
- Flutter & Dart
- Firebase Authentication & Cloud Firestore
- Provider (theme and language management)
- easy_localization
- introduction_screen, google_fonts, fluttertoast, shared_preferences

## Project Structure
```
lib/
├── core/
│   ├── colors/
│   ├── image/
│   ├── model/
│   ├── provider/
│   ├── route/
│   ├── text/
│   ├── firebase_function.dart
│   └── my_theme_app.dart
├── feature/
│   ├── Home/
│   ├── Login/
│   └── onboarding/
├── firebase_options.dart
└── main.dart
```

## Screenshots
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-45-56-81_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/bbe52fca-d810-48a4-8b26-0808fe08171d" />

dark mode

<img width="720" height="1600" alt="Screenshot_2026-11-08-00-47-55-16_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/eb954039-ef37-4569-bbdb-21fb189ccde5" />


## How to run
1. Clone the repo:
   `git clone https://github.com/rawda-hesham235/Evently.git`
2. Install packages: `flutter pub get`
3. Connect your own Firebase project (Authentication + Cloud Firestore)
   using `flutterfire configure`
4. Run the app: `flutter run`

## Author
Rawda Hesham — [LinkedIn](https://linkedin.com/in/rawda-hesham-329474231)
