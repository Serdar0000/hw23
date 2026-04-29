import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/habit_providers.dart';

class HabitListScreen extends HookConsumerWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Habits')),
      body: habitsAsync.when(
        data: (habits) => ListView.builder(
          itemCount: habits.length,
          itemBuilder: (context, index) {
            final habit = habits[index];
            final isCompleted = habit.completedDates.any((d) => _isToday(d));
            return ListTile(
              title: Text(habit.title),
              subtitle: Text(habit.description),
              trailing: Checkbox(
                value: isCompleted,
                onChanged: (_) {
                  ref.read(toggleHabitCompletionProvider(habit.id).future);
                },
              ),
              onTap: () {
                context.go('/habit/${habit.id}');
              },
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/habit/new');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}
