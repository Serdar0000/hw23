import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/repositories/habit_repository_impl.dart';
import '../../domain/entities/habit.dart';

final habitRepositoryProvider = Provider<HabitRepositoryImpl>((ref) {
  return HabitRepositoryImpl();
});

final habitsProvider = FutureProvider<List<Habit>>((ref) async {
  final repo = ref.watch(habitRepositoryProvider);
  return repo.getHabits();
});

final toggleHabitCompletionProvider = FutureProvider.family<void, String>((ref, habitId) async {
  final repo = ref.read(habitRepositoryProvider);
  await repo.toggleHabitCompletion(habitId, DateTime.now());
  ref.invalidate(habitsProvider);
});

final deleteHabitProvider = FutureProvider.family<void, String>((ref, habitId) async {
  final repo = ref.read(habitRepositoryProvider);
  await repo.deleteHabit(habitId);
  ref.invalidate(habitsProvider);
});
