import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/notifiers/theme_notifier.dart';

final themeProvider = NotifierProvider.autoDispose<ThemeNotifier, bool>(
  ThemeNotifier.new,
);
