# Nok Air Assignment

This is a Flutter mobile application assignment project.

## 🛠 Libraries Used

The project utilizes several key libraries to manage state, networking, and UI:

- **State Management & Routing**: `get` (GetX) for reactive state management, dependency injection, and easy route navigation.
- **Networking**: `dio` and `retrofit` for structured and type-safe API requests.
- **Mocking Data**: `duty.json` and `profile.json` in `assets/mock_data/` for use data in local.
- **Data Models**: `freezed` & `json_serializable` to generate robust data models with copy functionality and JSON parsing.
- **UI & Layout**: `sizer` for responsive UI design across different screen sizes.
- **Environment**: `flutter_dotenv` to securely load API base URLs or keys from `.env` files.
- **Others**: `intl` (date formatting), `flutter_svg` (rendering SVG icons), `logger` (console logging), `flutter_easyloading_plus` (loading overlays).

## 🚀 How to Run the App

Ensure you have Flutter (and optionally FVM) installed. Then, follow these steps:

1. **Clean the project**:
   ```bash
   flutter clean
   ```
2. **Fetch all dependencies**:
   ```bash
   flutter pub get
   ```
3. **Generate required code** (for Freezed, Retrofit, and JSON Serializable):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. **Run the application**:
   ```bash
   flutter run
   ```
   _(Note: If you use FVM, prefix the commands with `fvm`, e.g., `fvm flutter run`)_

## 🎬 Splash Screen Animation Concept

The splash screen is designed to provide a smooth and engaging entry into the app.

### Animation Flow

- **Scale (Pop-up Effect):** We use `Tween(begin: 0.5, end: 1.0)` with a `CurvedAnimation` using `Curves.easeOutBack`. This creates a playful "bounce" effect as the logo scales up from half its size to its actual size.
- **Opacity (Fade-In Effect):** Simultaneously, we use an opacity animation with `Curves.easeIn`, transitioning from fully transparent to fully visible state smoothly.

### Implementation Details

- The animation is controlled by an `AnimationController` running for 1.5 seconds.
- After the animation finishes, we wait for an additional 1-second delay (total 2.5 seconds on the splash screen).
- Finally, the app navigates to the main shell (`MainShell`) using `Get.offAll()`, ensuring the user cannot navigate back to the splash screen.
