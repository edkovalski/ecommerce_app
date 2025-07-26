# E-Commerce Flutter App

A sample e-commerce application built with [Flutter](https://flutter.dev/) showcasing clean architecture, Riverpod state-management and a responsive UI that runs on Android, iOS and the web.

## Features

- Browse product catalogue
- Product details page
- Persistent shopping cart
- Favourites / wish-list stored locally (Sembast)
- Email / password authentication (fake repository for demo purposes)
- Search, filters & sorting
- Order history & account page
- Dark-mode ready (Material 3)

## Tech Stack

| Layer | Package | Purpose |
|-------|---------|---------|
| UI | Flutter 3 / Material 3 | Cross-platform UI |
| State Management | flutter_riverpod | Unidirectional data-flow |
| Routing | go_router | Declarative navigation |
| Local persistence | sembast | NoSQL on-device DB |
| Testing | flutter_test, mocktail | Unit & widget tests |

## Project Structure

```text
lib/
 ├── main.dart               # entry point
 ├── src/
 │    ├── features/          # domain slices (cart, products, auth…)
 │    ├── routing/           # go_router config
 │    └── utils/             # shared helpers
assets/                     # images & fonts
```

## Getting Started

1. Install **Flutter 3.22+** and set up a device or emulator.
2. Fetch dependencies
   ```bash
   flutter pub get
   ```
3. Run the app
   ```bash
   # Mobile/Desktop
   flutter run
   # Web
   flutter run -d chrome
   ```

### Test Credentials

The app ships with a fake backend. Sign-in with:

```
email: test
password: test
```

## Running Tests

```bash
flutter test
```

## Contributing

Pull-requests are welcome. Please open an issue first to discuss changes.

## License

MIT
