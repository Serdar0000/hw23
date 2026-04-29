import '../../domain/entities/habit.dart';
import '../../domain/repositories/habit_repository.dart';
import '../models/habit_model.dart';
import '../datasources/habit_local_data_source.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitLocalDataSource _localDataSource = HabitLocalDataSource();

  @override
  Future<List<Habit>> getHabits() async {
    return await _localDataSource.getHabits();
  }

  @override
  Future<void> addHabit(Habit habit) async {
    await _localDataSource.saveHabit(HabitModel(
      id: habit.id,
      title: habit.title,
      description: habit.description,
      completedDates: habit.completedDates,
    ));
  }

  @override
  Future<void> updateHabit(Habit habit) async {
    await _localDataSource.saveHabit(HabitModel(
      id: habit.id,
      title: habit.title,
      description: habit.description,
      completedDates: habit.completedDates,
    ));
  }

  @override
  Future<void> deleteHabit(String id) async {
    await _localDataSource.deleteHabit(id);
  }

  @override
  Future<void> toggleHabitCompletion(String id, DateTime date) async {
    final habits = await _localDataSource.getHabits();
    final index = habits.indexWhere((h) => h.id == id);
    if (index != -1) {
      final habit = habits[index];
      final dates = List<DateTime>.from(habit.completedDates);
      if (dates.any((d) => _isSameDay(d, date))) {
        dates.removeWhere((d) => _isSameDay(d, date));
      } else {
        dates.add(date);
      }
      await _localDataSource.saveHabit(HabitModel(
        id: habit.id,
        title: habit.title,
        description: habit.description,
        completedDates: dates,
      ));
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
