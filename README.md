# SuperText

**SuperText** is a Flutter package that provides a simple and customizable way to display text with animated effects on each character when changes.

With SuperText, you can easily add eye-catching animations such as scaling, blinking, sliding, etc., to your text to make it stand out and enhance the user experience in your Flutter applications.

## Features

- Display text with customizable animated effects on each character.
- Support for various animation types including scale, blink, slide up, slide down, slide left, and slide right.
- Highly customizable text styling options including font style, text alignment, letter spacing, etc.
- Easy-to-use API with a built-in controller for managing multiple instances of SuperText widgets.
- Compatible with Flutter's reactive programming model using GetX for state management.

## Installation

To use SuperText in your Flutter project, add the following dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  super_text: <latest>
```

Then, run `flutter pub get` to install the package.

## Warning ⚠️

- `SuperText` widget has a built-in controller to manage the text changes and animations. Don't use setState to update text or else no animation will occurs.
- Make sure to create a new instance of `SuperTextController` for each SuperText widget as sharing the same controller means sharing the same text even with different animation.
- SuperText widget is actually a Wrap widget with a Text widget inside, so you can use it as a Text widget with additional features.
- Use `SuperTextNumber` widget additionnally to `prefixText` and `suffixText` properties when dealing with numbers for more flexibility.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:super_text/super_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  SuperTextController controller = SuperTextController(); // Needed to change text dynamically
  int viewersCount = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SuperText Demo'),
        ),
        body: Colum,(
          children: [
            SuperText(
            viewersCount.toString(),
            controller: controller,
            suffixText: ' viewers',
            animDuration: Duration(milliseconds: 500),
            type: SuperTextType.scale,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          
          ElevatedButton(
            onPressed: () {
              viewersCount++;
              controller.setText(viewersCount.toString()); // called without setState
            },
            child: Text('Increment Viewers'),
          ),],
        ),
      ),
    );
  }
}
```

## Example

Check out the [example](example) directory for a complete Flutter application demonstrating the usage of SuperText.

## Support

- For any issues or feature requests, please [open an issue](https://github.com/D3R50N/super_text/issues) on GitHub.

## Contributing

Contributions are welcome! Please follow the [contribution guidelines](README.md) when submitting pull requests.

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT) - see the [LICENSE](LICENSE) file for details.

## Author

- [D3R50N](https://github.com/D3R50N)
