# Nigeria Places Selector

A **Flutter utility + widget package** for working with Nigerian
administrative locations: **States → LGAs → Wards**.

This package can be used in two ways: 1. Using the ready-made UI widget
(`PlacesSelector`) 2. Using the query class (`NigeriaPlacesQuery`)
directly (no UI)

------------------------------------------------------------------------

## ✨ Features

-   Access all Nigerian States, LGAs, and Wards
-   Lightweight SQLite-backed queries
-   Can be used **with or without UI**
-   Async support
-   Clean API

------------------------------------------------------------------------

## 📦 Installation

Add to your `pubspec.yaml`:

``` yaml
dependencies:
  nigeria_lgas: ^1.0.0+2
```

Run:

``` bash
flutter pub get
```

------------------------------------------------------------------------

# 🚀 Usage WITHOUT the Widget (Query Only)

If you don't want the dropdown UI (maybe you're building your own custom
UI or API layer), use the `NigeriaPlacesQuery` class directly.

------------------------------------------------------------------------

## 1️⃣ Import

``` dart
import 'package:nigeria_lgas/nga_places_query.dart';
```

------------------------------------------------------------------------

## 2️⃣ Initialize

``` dart
final query = NigeriaPlacesQuery();
```

------------------------------------------------------------------------

## 3️⃣ Fetch States

``` dart
final states = await query.getStates();

print(states);
// Example: ['Abuja', 'Kaduna', 'Lagos', ...]
```

------------------------------------------------------------------------

## 4️⃣ Fetch LGAs (by State)

``` dart
final lgas = await query.getLGAs('Kaduna');

print(lgas);
// Example: ['Zaria', 'Sabon Gari', ...]
```

------------------------------------------------------------------------

## 5️⃣ Fetch Wards (by LGA)

``` dart
final wards = await query.getWards('Zaria');

print(wards);
// Example: ['Wusasa', 'Tudun Wada', ...]
```

------------------------------------------------------------------------

## 6️⃣ Fetch Wards with State Filter (Recommended)

Some LGAs exist in multiple states, so it's safer to include the state:

``` dart
final wards = await query.getWards(
  'Zaria',
  state: 'Kaduna',
);
```

------------------------------------------------------------------------

## 🧠 Full Example (No UI)

``` dart
void loadLocations() async {
  final query = NigeriaPlacesQuery();

  final states = await query.getStates();

  final lgas = await query.getLGAs(states.first);

  final wards = await query.getWards(
    lgas.first,
    state: states.first,
  );

  print(states);
  print(lgas);
  print(wards);
}
```

------------------------------------------------------------------------

## ⚠️ Notes

-   Always prefer passing `state` when fetching wards to avoid
    ambiguity.
-   Queries are asynchronous, so use `await`.
-   Data comes preloaded from the package database.

------------------------------------------------------------------------

# 🎨 Usage WITH Widget (Optional)

``` dart
import 'package:nigeria_lgas/places_selector.dart';

PlacesSelector(
  onSelected: (state, lga, ward) {
    print('$state > $lga > $ward');
  },
)
```

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 💡 Author

**Abdulraheem Ahmad**  
📍 Nigeria  
👨‍💻 Mobile App Developer | Urban Planner | AI Enthusiast  
