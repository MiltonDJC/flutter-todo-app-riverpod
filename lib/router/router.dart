import 'package:flutter_todo_app/screens/not_found_screen.dart';
import 'package:flutter_todo_app/screens/task_detail_screen.dart';
import 'package:flutter_todo_app/screens/todo_home_screen.dart';
import 'package:go_router/go_router.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const TodoHomeScreen(),
    ),
    GoRoute(
      path: '/detail/:id',
      name: 'detail',
      builder: (context, state) {
        final taskId = state.pathParameters['id'];
        return TaskDetailScreen(taskId: int.parse(taskId!));
      },
    ),
    GoRoute(
      path: '/404',
      name: '404',
      builder: (context, state) => const NotFoundScreen(),
    ),
  ],
);

GoRouter get router => _router;
