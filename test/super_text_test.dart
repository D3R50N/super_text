import 'package:flutter_test/flutter_test.dart';

import 'package:super_text_x/super_text_x.dart';

void main() {
  test('test 1', () {
    final superText = SuperText('Hello, World!');
    expect(superText.text.value, 'Hello, World!');
  });
}
