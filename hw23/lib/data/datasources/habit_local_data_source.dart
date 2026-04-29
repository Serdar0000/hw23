import 'package:hive/hive.dart';
import '../models/habit_model.dart';

class HabitLocalDataSource {
  static const String boxName = 'habits';

  Future<Box> _openBox() async {
    return await Hive.openBox(boxName);
  }

  Future<List<HabitModel>> getHabits() async {
    final box = await _openBox();
    return box.values.map((e) => HabitModel.fromMap(Map<String, dynamic>.from(e))).toList();
  }

  Future<void> saveHabit(HabitModel habit) async {
    final box = await _openBox();
    await box.put(habit.id, habit.toMap());
  }

  Future<void> deleteHabit(String id) async {
    final box = await _openBox();
    await box.delete(id);
  }
}
