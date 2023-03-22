class Task {
  String title;
  String description;
  bool isDone;
  DateTime endDate;
  bool hide;

  Task({
    required this.title,
    required this.description,
    required this.endDate,
    required this.isDone,
    required this.hide,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? endDate,
    bool? isDone,
    bool? hide,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      hide: hide ?? this.hide,
    );
  }
}
