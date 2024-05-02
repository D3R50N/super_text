import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'types.dart';
import 'super_text_x.dart'; // Assure que le package SuperText est importé

/// Widget that represents a single character with animated effects.
class SuperChar extends StatelessWidget {
  /// The character to display.
  final RxString char = ''.obs;

  /// The style to apply to the character.
  final TextStyle? style;

  /// Whether to show the character or not.
  final RxBool show = true.obs;

  /// The duration of the animation.
  final Duration animDuration;

  /// The scale factor for the text.
  final double? textScaleFactor;

  /// The type of animation for the character.
  final SuperTextType type;

  /// Constructs a [SuperChar] widget.
  SuperChar(
    String char, {
    super.key,
    required this.animDuration,
    required this.type,
    this.style,
    this.textScaleFactor,
  }) {
    this.char.value = char;
  }

  /// Makes the character animate with the specified new character.
  void anim(String newChar) {
    Future.delayed(animDuration ~/ 2, () {
      char.value = newChar;
    });
    show.value = false;
    Future.delayed(animDuration, () {
      show.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final textWidget = Text(
          char.value,
          style: style,
          textScaler: TextScaler.linear(textScaleFactor ?? 1.0),
        );
        Duration duration = animDuration / 2;

        if (type == SuperTextType.slideUp ||
            type == SuperTextType.slideDown ||
            type == SuperTextType.slideLeft ||
            type == SuperTextType.slideRight) {
          final slideColors = [
            if (type == SuperTextType.slideUp ||
                type == SuperTextType.slideDown)
              Colors.transparent,
            Theme.of(context).textTheme.bodyLarge!.color!,
            Theme.of(context).textTheme.bodyLarge!.color!,
            Theme.of(context).textTheme.bodyLarge!.color!,
            Theme.of(context).textTheme.bodyLarge!.color!,
          ];

          final slideAlignmentBegin = type == SuperTextType.slideUp
              ? Alignment.topCenter
              : type == SuperTextType.slideDown
                  ? Alignment.bottomCenter
                  : type == SuperTextType.slideLeft
                      ? Alignment.centerLeft
                      : type == SuperTextType.slideRight
                          ? Alignment.centerRight
                          : Alignment.center;

          final slideAlignmentEnd = type == SuperTextType.slideUp
              ? Alignment.bottomCenter
              : type == SuperTextType.slideDown
                  ? Alignment.topCenter
                  : type == SuperTextType.slideLeft
                      ? Alignment.centerRight
                      : type == SuperTextType.slideRight
                          ? Alignment.centerLeft
                          : Alignment.center;

          final slideOffset = type == SuperTextType.slideUp
              ? const Offset(0, -1)
              : type == SuperTextType.slideDown
                  ? const Offset(0, 1)
                  : type == SuperTextType.slideLeft
                      ? const Offset(-1, 0)
                      : type == SuperTextType.slideRight
                          ? const Offset(1, 0)
                          : const Offset(0, 0);
          return ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: slideAlignmentBegin,
                end: slideAlignmentEnd,
                colors: slideColors,
              ).createShader(bounds);
            },
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(),
              child: AnimatedSlide(
                duration: duration,
                offset: show.value ? Offset.zero : slideOffset,
                child: textWidget,
              ),
            ),
          );
        }

        switch (type) {
          case SuperTextType.scale:
            return AnimatedScale(
              duration: duration,
              scale: show.value ? 1 : 0,
              child: textWidget,
            );
          case SuperTextType.blink:
            return AnimatedOpacity(
              duration: duration,
              opacity: show.value ? 1 : 0,
              child: textWidget,
            );

          default:
            return textWidget;
        }
      },
    );
  }
}

/// Extension on [Duration] to allow dividing by an integer.
extension on Duration {
  Duration operator /(int value) =>
      Duration(milliseconds: inMilliseconds ~/ value);
}
