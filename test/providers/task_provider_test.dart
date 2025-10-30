import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/providers/task_provider.dart';

void main() {
  group('taskProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test(
      'Given the taskProvider, when it is first read, then it returns an empty list',
      () {
        final tasks = container.read(taskProvider);
        expect(tasks, isEmpty);
      },
    );
  });
}
