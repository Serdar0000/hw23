import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'presentation/screens/habit_list_screen.dart';
import 'presentation/screens/habit_edit_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'presentation/screens/habit_detail_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HabitListScreen(),
          routes: [
            GoRoute(
              path: 'habit/new',
              builder: (context, state) => const HabitEditScreen(),
            ),
            GoRoute(
              path: 'habit/:id',
              builder: (context, state) {
                final id = state.pathParameters['id']!;
                return HabitDetailScreen(habitId: id);
              },
            ),
          ],
        ),
      ],
    );
    return MaterialApp.router(
      title: 'Habit Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
