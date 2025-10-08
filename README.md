# Nigeria Places Selector

A **Flutter widget** that provides an intuitive cascading dropdown selector for **Nigerian States**, **Local Government Areas (LGAs)**, and **Wards** — all powered by a simple query interface.

This widget is ideal for any Flutter app that requires users to select hierarchical administrative locations within Nigeria, such as registration forms, address pickers, or survey apps.

---

## ✨ Features

- Simple 3-step cascading selector: **State → LGA → Ward**
- Asynchronous data fetching
- Customizable spacing and input decoration
- Reusable and easy to integrate
- Comes with built-in support for all Nigerian states, LGAs, and wards

---

## 📦 Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  nigeria_lgas: ^1.0.0+2
```

Then, run:

```bash
flutter pub get
```

---

## 🚀 Usage

### 1️⃣ Import the widget
```dart
import 'package:nigeria_lgas/places_selector.dart';
```

### 2️⃣ Use it in your widget tree
```dart
PlacesSelector(
  spacing: 10,
  inputDecoration: const InputDecoration(
    border: OutlineInputBorder(),
  ),
  onSelected: (state, lga, ward) {
    print('Selected: $state > $lga > $ward');
  },
)
```

### 3️⃣ Example App
Below is a minimal example demonstrating usage inside a `MaterialApp`:

```dart
import 'package:flutter/material.dart';
import 'package:nigeria_lgas/places_selector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nigeria Places Selector Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Scaffold(
        body: SafeArea(
          child: Center(
            child: PlacesSelector(
              spacing: 10,
              inputDecoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## 🧠 API Reference

| Parameter | Type | Description |
|------------|------|-------------|
| `state` | `String?` | Preselected state value |
| `lga` | `String?` | Preselected LGA value |
| `ward` | `String?` | Preselected ward value |
| `onSelected` | `Function(String?, String?, String?)?` | Callback when all values are selected |
| `inputDecoration` | `InputDecoration?` | Custom decoration for the dropdown fields |
| `spacing` | `double` | Vertical spacing between dropdowns (default: `10`) |

---

## 🗂 Directory Structure

```
lib/
│
├── nga_places_query.dart      # Data access for states, LGAs, and wards
└── places_selector.dart       # UI widget with cascading dropdowns
```

---

## ⚙️ How It Works

The `PlacesSelector` widget uses the `NigeriaPlacesQuery` class to:
1. Fetch all **States** in Nigeria.
2. Load **LGAs** when a State is selected.
3. Load **Wards** when an LGA is selected.

It updates the dropdowns dynamically and returns the selected values through the `onSelected` callback.

---

## 🧩 Example Output

When used, the widget renders three dropdowns:

```
[ Select State  ▼ ]
[ Select LGA    ▼ ]
[ Select Ward   ▼ ]
```

When the user selects all three, the callback returns:
```dart
('Kaduna', 'Zaria', 'Wusasa')
```

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 💡 Author

**Abdulraheem Ahmad**  
📍 Nigeria  
👨‍💻 Mobile App Developer | Urban Planner | AI Enthusiast  
