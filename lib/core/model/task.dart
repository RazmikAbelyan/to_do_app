class Task {
  String title;
  String description;
  bool isDone;
  DateTime endDate;
  bool isHidden;

  Task({
    required this.title,
    required this.description,
    required this.endDate,
    required this.isDone,
    required this.isHidden,
  });

  Task copyWith({
    String? title,
    String? description,
    DateTime? endDate,
    bool? isDone,
    bool? isHidden,
  }) {
    return Task(
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      isHidden: isHidden ?? this.isHidden,
    );
  }
}
