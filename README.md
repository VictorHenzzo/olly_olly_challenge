# Weather App

A Flutter application for web and mobile with:

- 🔐 User authentication (Firebase Auth)
- 🌍 Current location weather display (via OpenWeatherMap API)
- 📱 Responsive design for web and mobile

## 🧱 Project Architecture
For an overview of the app’s structure, design decisions, and layer responsibilities, check out the ARCHITECTURE.md file. It covers how features are organized, how dependencies are managed, and other implementation details that help keep the codebase scalable and maintainable.

## 🔧 Features

- **Firebase Authentication**: Email/password sign-up and login
- **Current Weather**: Automatically fetches weather for user's geolocation
- **Responsive UI**: Optimized layouts for mobile and web
- **Separation of Concerns**: Clean architecture with modular layers
- **Error Handling**: Graceful fallbacks for common issues (e.g. denied location)

---

## 🚀 Getting Started

### Prerequisites

- Flutter 3.29.3
- An OpenWeatherMap API Key
- A Firebase project\

### Clone

```bash
git clone https://github.com/VictorHenzzo/olly_olly_challenge.git
cd weather_app_challenge
```

### Environment Setup

This project uses a custom environment file to store secrets.

1. Create a file at env/environment.json:

```json
{
    "weather_api_key": "",
    "weather_api_base_url": "",
    "weather_api_icon_url": "",
    "web_firebase_apiKey": "",
    "web_firebase_appId": "",
    "web_firebase_messagingSenderId": "",
    "web_firebase_projectId": "",
    "web_firebase_authDomain": "",
    "web_firebase_storageBucket": "",
    "android_firebase_apiKey": "",
    "android_firebase_appId": "",
    "android_firebase_messagingSenderId": "",
    "android_firebase_projectId": "",
    "android_firebase_storageBucket": "",
    "ios_firebase_apiKey": "",
    "ios_firebase_appId": "",
    "ios_firebase_messagingSenderId": "",
    "ios_firebase_projectId": "",
    "ios_firebase_storageBucket": "",
    "ios_firebase_iosBundleId": ""
}
```

Make sure to never commit this file—it’s listed in .gitignore.

2. Run the App
There are two ways to pass the environment configuration:

#### Via Flutter CLI:

```bash
flutter run -d chrome \
  --dart-define-from-file=env/environment.json \
  --web-port=50000 \
  --web-browser-flag=--disable-web-security
```

**Note**: The --disable-web-security flag disables CORS during local web debugging. Required for API calls that don't send proper CORS headers.

#### Or via VS Code:

If you're using VS Code, just run the "debug" launch profile, already configured in .vscode/launch.json
