import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/providers/theme_provider.dart';

void main() {
  group('themeProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'Given the themeProvider, when it is read, then it returns a true value',
      () {
        final themeValue = container.read(themeProvider);
        expect(themeValue, isTrue);
      },
    );
  });
}
