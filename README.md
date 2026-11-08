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
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-44-24-31_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/11e688f6-845e-453c-80ba-fd49358227aa" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-44-25-38_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/d01a0085-e49b-4fa7-a320-462ab8583828" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-44-54-12_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/195fe8e4-ef2e-4add-9f40-9c260d1c541a" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-45-38-31_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/eb468fc5-62e1-4b0a-8f5c-5a0e5a7c34c6" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-45-56-81_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/6215811a-1d58-42f5-8e35-c79ce09c8f5c" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-46-07-04_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/b0447014-b4b8-4a91-b479-f27359ee07b8" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-46-13-93_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/244be3d6-1b18-482f-9798-2b529b3e9b15" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-45-56-81_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/bbe52fca-d810-48a4-8b26-0808fe08171d" />

dark mode

<img width="720" height="1600" alt="Screenshot_2026-11-08-00-47-55-16_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/eb954039-ef37-4569-bbdb-21fb189ccde5" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-47-34-39_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/cda22d5c-7e8b-44ca-9078-0bb5cfe322c8" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-47-23-07_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/f27638d0-2270-4ae2-9626-37e316e5feeb" />
<img width="720" height="1600" alt="Screenshot_2026-11-08-00-46-37-59_b100401f5af6ae0b1c9d2d07f5b96043" src="https://github.com/user-attachments/assets/7e24cfe0-62e5-4309-8efe-bc54e5a04026" />


## How to run
1. Clone the repo:
   `git clone https://github.com/rawda-hesham235/Evently.git`
2. Install packages: `flutter pub get`
3. Connect your own Firebase project (Authentication + Cloud Firestore)
   using `flutterfire configure`
4. Run the app: `flutter run`

## Author
Rawda Hesham — [LinkedIn](https://linkedin.com/in/rawda-hesham-329474231)
