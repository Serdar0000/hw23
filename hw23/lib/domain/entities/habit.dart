class Habit {
  final String id;
  final String title;
  final String description;
  final List<DateTime> completedDates;

  Habit({
    required this.id,
    required this.title,
    required this.description,
    required this.completedDates,
  });
}
