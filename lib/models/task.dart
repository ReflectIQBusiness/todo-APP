class Task {
  String id;
  String name;
  bool isDone;
  int points;

  Task({
    required this.id,
    required this.name,
    this.isDone = false,
    required this.points,
  });

  void toggleDone() {
    isDone = !isDone;
  }
}
