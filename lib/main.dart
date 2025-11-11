import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_app/providers/theme_provider.dart';
import 'package:flutter_todo_app/router/router.dart';
import 'package:flutter_todo_app/theme/theme.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Todo App Riverpod',
      themeMode: themeMode ? ThemeMode.light : ThemeMode.dark,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeAnimationDuration: const Duration(milliseconds: 200),
      routerConfig: router,
    );
  }
}
