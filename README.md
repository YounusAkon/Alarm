# task1

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Flutter Alarm App

A simple Flutter application that includes onboarding screens, location services, and alarm functionalities. Built with Dart and Flutter, this app is structured for scalability and ease of maintenance.

## 📂 Project Structure


lib/
├── screens/
│ ├── screens1.dart # Onboarding or welcome screen 1
│ ├── screens2.dart # Onboarding or welcome screen 2
│ ├── screens3.dart # Onboarding or welcome screen 3
├── ABC.dart # Main alarm/notification logic (?)
├── location_service.dart # Handles location permissions/services
├── main.dart # App entry point
├── new.dart # Possibly another feature or demo screen
assets/
└── images/ # Contains 1.jpg to 4.jpg for onboarding or background use



## 🚀 Features

- 📱 Onboarding flow with multiple screens
- 📍 Location permission and access integration
- ⏰ Alarm/Notification setup logic
- 🖼️ Custom image assets for visuals
- 🔧 Modular code structure

## 📦 Getting Started

### Prerequisites
- Flutter SDK installed
- Android/iOS emulator or real device

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/YounusAkon/Alarm.git
   cd Alarm

The app uses images located in:

assets/images/
├── 1.jpg
├── 2.jpg
├── 3.jpg
└── 4.jpg



Make sure these are listed in pubspec.yaml like:

assets:
  - assets/images/1.jpg
  - assets/images/2.jpg
  - assets/images/3.jpg
  - assets/images/4.jpg


🔧 Dependencies (If used)
geolocator – for location services

flutter_local_notifications – for alarms/notifications

shared_preferences – for onboarding state persistence

📄 License
This project is licensed under the MIT License.

👤 Author
Ali Younus – GitHub
