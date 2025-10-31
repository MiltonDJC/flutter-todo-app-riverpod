import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/providers/theme_provider.dart';

void main() {
  group('ThemeNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'Given an instance of ThemeNotifier, when this one is built, then the state is true',
      () {
        expect(container.read(themeProvider), isTrue);
      },
    );

    test(
      'Given a true theme value, when toggleTheme function is called twice, then the theme value turns false and then turns true again',
      () {
        final notifier = container.read(themeProvider.notifier);

        var themeValue = container.read(themeProvider);
        expect(themeValue, isTrue);

        notifier.toggleTheme();

        themeValue = container.read(themeProvider);
        expect(themeValue, isFalse);

        notifier.toggleTheme();

        themeValue = container.read(themeProvider);
        expect(themeValue, isTrue);
      },
    );
  });
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
