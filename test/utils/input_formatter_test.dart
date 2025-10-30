import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_app/utils/input_formatter.dart';

void main() {
  group('inputFormatter', () {
    late String newTaskTitle;

    setUp(() {
      newTaskTitle = 'learn riverpod';
    });

    test(
      'Given a task title, when the input formatter function is called, then the task title capitalized is returned.',
      () {
        final taskTitleCapitalized =
            newTaskTitle.substring(0, 1).toUpperCase() +
            newTaskTitle.substring(1);

        expect(inputFormatter(newTaskTitle), taskTitleCapitalized);
      },
    );
  });
}
