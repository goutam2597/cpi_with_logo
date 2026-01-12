# Logo Circular Progress Indicator

A beautiful and customizable circular progress indicator for Flutter with animated logo/icon in the center. Perfect for showing loading states while maintaining your app's branding.

## Features

✨ **Multiple Animation Styles**
- **Gradient**: Smooth rotating gradient effect
- **Dotted Circle**: Animated dots forming a circle
- **Dual Ring**: Two counter-rotating arcs
- **Wave**: Pulsing waves radiating outward
- **Spinning Arcs**: Multiple arcs spinning together

🎨 **Flexible Logo Options**
- Use package asset (built-in icon.png)
- Use your own custom asset images
- Provide custom widgets
- Fallback to colored dot if no logo provided

🎯 **Customizable Design**
- Adjustable size, color, and stroke width
- Smooth animations with pulse effects
- Common logo across all animation styles

📦 **Multiple Components**
- `CustomLoader` - Inline loader widget
- `FullScreenLoader` - Full-screen overlay with optional message

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  logo_circular_progress_indicator: ^1.0.0
```

Then run:
```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:logo_circular_progress_indicator/logo_circular_progress_indicator.dart';

// Simple loader with default gradient style
CustomLoader()

// With built-in icon from package
CustomLoader(
  size: 60,
  color: Colors.blue,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)
```

### Different Animation Styles

```dart
// Gradient style (default)
CustomLoader(
  size: 70,
  color: Colors.blue,
  style: LoaderStyle.gradient,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)

// Dotted circle style
CustomLoader(
  size: 70,
  color: Colors.purple,
  style: LoaderStyle.dottedCircle,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)

// Dual ring style
CustomLoader(
  size: 70,
  color: Colors.green,
  style: LoaderStyle.dualRing,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)

// Wave style
CustomLoader(
  size: 70,
  color: Colors.orange,
  style: LoaderStyle.wave,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)

// Spinning arcs style
CustomLoader(
  size: 70,
  color: Colors.red,
  style: LoaderStyle.spinningArcs,
  logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
)
```

### With Your Own Asset Logo

```dart
CustomLoader(
  size: 50,
  color: Colors.purple,
  style: LoaderStyle.gradient,
  logoAsset: 'assets/images/your_logo.png',
)
```

Don't forget to add your asset in your app's `pubspec.yaml`:
```yaml
flutter:
  assets:
    - assets/images/your_logo.png
```

### With Custom Widget Logo

```dart
CustomLoader(
  size: 60,
  color: Colors.green,
  logo: Icon(Icons.check, color: Colors.green, size: 30),
)
```

### Full Screen Loader

```dart
// Show loading overlay with gradient style
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => FullScreenLoader(
    message: 'Loading...',
    size: 80,
    style: LoaderStyle.gradient,
    logoAsset: 'packages/logo_circular_progress_indicator/assets/icon.png',
  ),
);
```

## Parameters

### CustomLoader

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `size` | `double` | `40` | Diameter of the loader |
| `color` | `Color?` | `Theme.primaryColor` | Color of the progress indicator |
| `strokeWidth` | `double` | `3.5` | Width of the circular stroke |
| `logoAsset` | `String?` | `null` | Path to asset image for center logo |
| `logo` | `Widget?` | `null` | Custom widget for center logo |
| `style` | `LoaderStyle` | `LoaderStyle.gradient` | Animation style |

### LoaderStyle Enum

- `LoaderStyle.gradient` - Rotating gradient effect
- `LoaderStyle.dottedCircle` - Animated dots in a circle
- `LoaderStyle.dualRing` - Two counter-rotating arcs
- `LoaderStyle.wave` - Pulsing wave animation
- `LoaderStyle.spinningArcs` - Multiple spinning arcs

### FullScreenLoader

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `message` | `String?` | `null` | Optional loading message |
| `size` | `double` | `60` | Size of the loader |
| `style` | `LoaderStyle` | `LoaderStyle.gradient` | Animation style |
| `logoAsset` | `String?` | `null` | Path to asset image for logo |
| `logo` | `Widget?` | `null` | Custom widget for logo |

## Example

Check out the [example](example) folder for a complete sample app.

## License

MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
