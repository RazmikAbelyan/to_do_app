part of 'add_tasks_bloc.dart';

@immutable
abstract class AddTasksEvent {}

class TitleChanged extends AddTasksEvent {
  final String title;

  TitleChanged(this.title);
}

class DescriptionChanged extends AddTasksEvent {
  final String description;

  DescriptionChanged(this.description);
}

class DateChanged extends AddTasksEvent {
  final DateTime endDate;

  DateChanged(this.endDate);
}

class TaskAdded extends AddTasksEvent {}
