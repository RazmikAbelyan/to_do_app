part of 'edit_task_bloc.dart';

@immutable
abstract class EditTaskEvent {}

class TitleEdited extends EditTaskEvent {
  final String title;

  TitleEdited(this.title);
}

class DescriptionEdited extends EditTaskEvent {
  final String description;

  DescriptionEdited(this.description);
}

class DateEdited extends EditTaskEvent {
  final DateTime endDate;

  DateEdited(this.endDate);
}

class TaskEdited extends EditTaskEvent {}
