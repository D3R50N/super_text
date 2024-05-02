import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'types.dart';
import 'super_char.dart';

export 'controller.dart';
export 'types.dart';
export 'super_char.dart';

/// Widget that displays text with customizable animated effects on each character.
class SuperText extends StatefulWidget {
  /// The text style to apply to the text.
  final TextStyle? style;

  /// The controller for managing this [SuperText] widget.
  final SuperTextController? controller;

  /// The duration of the animation.
  final Duration animDuration;

  /// The type of animation for the text.
  final SuperTextType type;

  /// The alignment of the text within its container.
  final TextAlign? textAlign;

  /// The factor by which to scale the text.
  final double? textScaleFactor;

  /// The space between each letter of the text.
  final double? letterSpacing;

  /// The direction in which to lay out the text.
  final Axis direction;

  /// The text value observed by this widget.
  final RxString text = ''.obs;

  /// List of [SuperChar] widgets representing each character of the text.
  final RxList<SuperChar> superChars = <SuperChar>[].obs;

  /// Optional text to display before the main text.
  final String? prefixText;

  /// Optional text to display after the main text.
  final String? suffixText;

  @override
  // ignore: overridden_fields
  final Key key = GlobalKey<_SuperTextState>();

  /// Constructs a [SuperText] widget.
  SuperText(
    String text, {
    super.key,
    this.prefixText,
    this.suffixText,
    this.style,
    this.controller,
    this.textAlign,
    this.textScaleFactor,
    this.letterSpacing,
    this.direction = Axis.horizontal,
    this.animDuration = const Duration(milliseconds: 200),
    this.type = SuperTextType.scale,
  }) {
    controller?.bind(this);
    ever(this.text,
        (callback) => initChars()); // update superChars on text change
    this.text.value = text;
  }

  /// Initializes the [SuperChar] widgets based on the text value.
  void initChars() {
    // Split the text into individual characters and iterate over them.
    text.split("").asMap().forEach((index, e) {
      // If the index is within the bounds of existing superChars,
      // check if the character has changed and update it accordingly.
      if (index < superChars.length) {
        if (superChars[index].char.value != e) {
          superChars[index].anim(e);
        }
      }
      // If the index is beyond the existing superChars,
      // add a new SuperChar widget for the new character.
      else {
        superChars.add(
          SuperChar(
            e,
            style: style,
            animDuration: animDuration,
            textScaleFactor: textScaleFactor,
            type: type,
          ),
        );
      }
    });

    // If there are more SuperChar widgets than characters in the text,
    // remove the extra SuperChar widgets and hide them.
    if (superChars.length > text.value.length) {
      for (int i = text.value.length; i < superChars.length; i++) {
        superChars[i].show.value = false;
        // Delay the removal to allow animations to complete.
        Future.delayed(superChars[i].animDuration, () {
          try {
            superChars.removeAt(i);
          } catch (e) {
            // Handle any exceptions if removal fails.
          }
        });
      }
    }
  }

  @override
  State<SuperText> createState() => _SuperTextState();
}

class _SuperTextState extends State<SuperText> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        alignment: widget.textAlign == TextAlign.center
            ? WrapAlignment.center
            : widget.textAlign == TextAlign.right
                ? WrapAlignment.end
                : WrapAlignment.start,
        direction: widget.direction,
        spacing: widget.letterSpacing ?? 0.0,
        runAlignment: WrapAlignment.center,
        children: [
          if (widget.prefixText != null)
            ...widget.prefixText!.split("").map(
                  (e) => Text(
                    e,
                    style: widget.style,
                  ),
                ),
          ...widget.superChars.map((e) => e),
          if (widget.suffixText != null)
            ...widget.suffixText!.split("").map(
                  (e) => Text(
                    e,
                    style: widget.style,
                  ),
                ),
        ],
      ),
    );
  }
}
