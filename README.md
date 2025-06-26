# 🌤️ Weather Prediction App (Flutter)

A simple cross-platform Flutter application that collects local weather parameters (temperature, humidity, pressure, etc.) and queries a **machine-learning model** deployed behind a REST endpoint to predict an outcome (e.g., tomorrow’s weather class, rainfall likelihood, or any numeric target your model returns).


---

## ✨ Features
| Category | Details |
|----------|---------|
| **UX**   | Clean 1-page form, live validation, loading spinner, bold result display |
| **Networking** | Uses [`http`](https://pub.dev/packages/http) package for JSON POST |
| **State** | `StatefulWidget` with `setState` for quick prototyping |
| **Customizable** | Easily swap in a new API base URL or extra input fields |

---

## 📂 Project Structure
```

.
├── lib/
│   └── main.dart          # Entire UI & logic (single file MVP)
├── pubspec.yaml           # Declares http: ^1.2.1
└── README.md              # You are here

````

---

## 🚀 Quick Start

1. **Prerequisites**

   - Flutter SDK ≥ 3.22  
   - Android Studio / Xcode / VS Code with Flutter extension  
   - A running REST endpoint that accepts a JSON body like:
     ```json
     {
       "maxtempC": 35,
       "mintempC": 26,
       "cloudcover": 60,
       "humidity": 78,
       "sunHour": 8,
       "HeatIndexC": 40,
       "precipMM": 3.2,
       "pressure": 1012,
       "windspeedKmph": 12
     }
     ```
     and returns  
     ```json
     {"prediction": "Rainy"}
     ```

2. **Clone & get packages**

   ```bash
   git clone https://github.com/Pankaj1662005/weather2.git
   cd weather_prediction_app
   flutter pub get


3. **Configure the API URL**

   In **`lib/main.dart`**, update the line:

   ```dart
   final url = Uri.parse('https://<your-url>/predict');
   ```

4. **Run**

   ```bash
   flutter run            # chooses a connected device/emulator
   ```

---
📩 To request access to the **latest source code**, feel free to reach out:

👤 **Pankaj**  
🎓 Thapar College  
📌 coe Engineering, Data Science , ML
**📧 Email:** pankajsheokand2005@gmail.com


