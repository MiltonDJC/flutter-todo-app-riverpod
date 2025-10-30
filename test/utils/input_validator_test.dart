import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/utils/input_validator.dart';

void main() {
  group('inputValidator', () {
    late String newTaskTitle;

    setUp(() {
      newTaskTitle = 'learn riverpod';
    });

    test(
      'Given a task title, when it is value is empty, then the inputValidator function returns null',
      () {
        final newTaskTitle = '';
        expect(inputValidator(newTaskTitle), isNull);
      },
    );

    test(
      'Given a task title, when it is value is not empty, then the inputValidator function returns the new task title value',
      () {
        expect(inputValidator(newTaskTitle), isNotNull);
        expect(inputValidator(newTaskTitle), newTaskTitle);
      },
    );
  });
}
