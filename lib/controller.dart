import 'package:flutter/material.dart';
import 'super_text.dart';

/// Controller class for managing multiple instances of [SuperText].
class SuperTextController {
  /// List of [SuperText] widgets managed by this controller.
  List<SuperText> superTexts = [];

  /// Binds a [SuperText] widget to this controller.
  void bind(SuperText superText) {
    superTexts.add(superText);
  }

  /// Disposes of any [SuperText] widgets that have been unmounted.
  void dispose() {
    superTexts.removeWhere((element) {
      final globalKey = element.key as GlobalKey;
      final state = globalKey.currentState;
      return state == null;
    });
  }

  /// Sets the text for all bound [SuperText] widgets.
  void setText(String text) {
    dispose();
    for (var superText in superTexts) {
      superText.text.value = text;
    }
  }
}
