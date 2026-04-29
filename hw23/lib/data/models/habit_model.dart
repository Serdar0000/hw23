import '../../domain/entities/habit.dart';

class HabitModel extends Habit {
  HabitModel({
    required super.id,
    required super.title,
    required super.description,
    required super.completedDates,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      completedDates: (map['completedDates'] as List<dynamic>?)?.map((e) => DateTime.parse(e as String)).toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completedDates': completedDates.map((e) => e.toIso8601String()).toList(),
    };
  }
}
