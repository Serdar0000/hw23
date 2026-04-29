import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/habit.dart';
import '../providers/habit_providers.dart';

class HabitDetailScreen extends HookConsumerWidget {
  final String habitId;
  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsync = ref.watch(habitsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали привычки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await ref.read(deleteHabitProvider(habitId).future);
              if (context.mounted) Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: habitsAsync.when(
        data: (habits) {
          Habit? habit;
          for (final h in habits) {
            if (h.id == habitId) {
              habit = h;
              break;
            }
          }
          if (habit == null) {
            return const Center(child: Text('Привычка не найдена'));
          }
          final completedDates = habit.completedDates;
          completedDates.sort((a, b) => b.compareTo(a));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(habit.title, style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(habit.description),
                const SizedBox(height: 24),
                Text('История выполнения:', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (completedDates.isEmpty)
                  const Text('Нет отмеченных дней'),
                if (completedDates.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: completedDates.length,
                      itemBuilder: (context, index) {
                        final date = completedDates[index];
                        return ListTile(
                          leading: const Icon(Icons.check_circle, color: Colors.green),
                          title: Text('${date.day}.${date.month}.${date.year}'),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Ошибка: $e')),
      ),
    );
  }
}
