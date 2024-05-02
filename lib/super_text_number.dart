import 'super_text.dart';

/// Widget that displays a number with customizable animated effects.
class SuperTextNumber extends SuperText {
  /// The number to display.
  final int number;

  /// Constructs a [SuperTextNumber] widget.
  SuperTextNumber(
    this.number, {
    super.key,
    super.prefixText,
    super.suffixText,
    super.style,
    super.controller,
    super.animDuration,
    super.type,
    super.textAlign,
    super.textScaleFactor,
    super.letterSpacing,
    super.direction,
  }) : super(
          number.toString(),
        );
}
