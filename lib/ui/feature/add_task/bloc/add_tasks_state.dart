part of 'add_tasks_bloc.dart';

@immutable
class AddTasksState {
  final String title;
  final String description;
  final DateTime? endTime;
  final bool added;

  const AddTasksState(
    this.title,
    this.description,
    this.endTime,
    this.added,
  );

  const AddTasksState.initial({
    this.title = '',
    this.description = '',
    this.endTime,
    this.added = false,
  });

  AddTasksState copyWith({
    String? title,
    String? description,
    DateTime? endTime,
    bool? added,
  }) {
    return AddTasksState(
      title ?? this.title,
      description ?? this.description,
      endTime ?? this.endTime,
      added ?? this.added,
    );
  }
}
