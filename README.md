# flutter_todo_app_riverpod

## 🧠 Provider vs Riverpod — Comparision

### 💡 Introduction
Both **Provider** and **Riverpod** are libraries for **state management** int Flutter. Provider was the first solution widely adopted by the community, but Riverpod emerges as its modern evolution: **safer, more modular and decoupled from the widget tree**.

In this project, the same application [flutter-todo-app-provider](https://github.com/MiltonDJC/flutter-todo-app-provider.git) was implemented but using ```Riverpod```, with the goal of comparing its architecture, readability and maintainability.

---

## ⚖️ General Comparison

| Aspect | Provider | Riverpod |
|----------|-----------|----------|
| **Flutter Dependency** | Requires `BuildContext` | Not Flutter-dependet (can be used outside the widget tree) |
| **State Reading** | `context.read()` / `context.watch()` | `ref.read()` / `ref.watch()` |
| **Provider Scope** | Limited to the widget tree | Global or local, depending on the need |
| **Hot Reload** | Can lose state | Preserves state after reloads |
| **Testability** | Requires a widget environment (`WidgetTester`) | Testable with `ProviderContainer`, without UI |
| **Performance** | More prone to rebuilds | More controlled and granular rebuilds |
| **Typing and Safety** | More prone to type errors | Safer and compatible with advanced null safety |

---

## 🧩 Practical Example

Below is the same counter implemented with **Provider** and with **Riverpod**, to visualize the syntactic and conceptual differences.

### 🟦 Provider
```dart
final counterProvider = ChangeNotifierProvider((_) => Counter());

class Counter extends ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<Counter>();

    return Scaffold(
      body: Center(child: Text('${counter.value}')),
      floatingActionButton: FloatingActionButton(
        onPressed: counter.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 🟩 Riverpod
```dart
final counterProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);

    return Scaffold(
      body: Center(child: Text('$count')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 🧭 State Flow
#### Provider
```scss
USER ACTION
   ↓
ChangeNotifier → notifyListeners()
   ↓
ConsumerWidget → complete rebuild
```

#### Riverpod
```perl
USER ACTION
   ↓
Notifier → state++
   ↓
ConsumerWidget (dependents only) → partial rebuild
```

>**Note:** The diagram shows that **Provider** on the **BuildContext**, whereas **Riverpod** uses ```ref``` to access the state, allowing for a cleaner separation between business logic and the interface.

---

## ⚙️ Additional Update
Refactor the Todo App to use code generation for providers via ```build_runner``` and ```riverpod_generator```.
This improves maintainability, reduces boilerplate and aligns with **professional Riverpod practices**.

### 🧠 Implementation
1. 
```yaml
dependencies:
  riverpod_annotation: ^3.0.3

dev_dependencies:
  build_runner:
  riverpod_generator: ^3.0.3
  custom_lint:
  riverpod_lint: ^3.0.3
```
2. Refactores main providers: ```task_provider.dart``` and ```theme_provider.dart``` using the modern ```@riverpod``` annotation:

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'task_provider.g.dart';

@riverpod
class TaskNotifier extends _$TaskNotifier {
  @override
  List<Task> build() => const [];

  void addTask(String taskName) { ... }
  void removeTask(Task task) { ... }
  void toggleStatus(Task task) { ... }
  void updateTask(Task task, {String? taskName, bool? status, String? description}) { ... }
}
```
3. Generated ```.g.dart``` files with:
```bash
dart run build_runner watch -d
```

## ✅ Result

The project now leverages **Riverpod 3 with code generation**, maintaining a **clean, scalable and testeable architecture**.

---

### ✅ Conclusion
* **Provider** is ideal for small projects or for learning the basic concepts of reactivity in Flutter.

* **Riverpod**, on the other hand, is a more robust evolution: it eliminates context dependencies, improves performance and facilitates testing and modularity.

* EFor medium or large-scale applications, **Riverpod** is currently the most recommended option by the community.

### 📄 References
* [Official Provider Documentation](https://pub.dev/packages/provider) <br>
* [Official Riverpod Documentation](https://riverpod.dev/docs/introduction/getting_started) <br> 
* [Flutter Docs - State Management](https://docs.flutter.dev/data-and-backend/state-mgmt)
