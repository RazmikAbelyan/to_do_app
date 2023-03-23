part of 'add_tasks_bloc.dart';

@immutable
class AddTasksState {
  final String title;
  final String description;
  final DateTime? endTime;
  final bool added;
  final bool isValid;

  const AddTasksState(
    this.title,
    this.description,
    this.endTime,
    this.added,
    this.isValid,
  );

  const AddTasksState.initial({
    this.title = '',
    this.description = '',
    this.endTime,
    this.added = false,
    this.isValid = true,
  });

  AddTasksState copyWith({
    String? title,
    String? description,
    DateTime? endTime,
    bool? added,
    bool? isValid,
  }) {
    return AddTasksState(
      title ?? this.title,
      description ?? this.description,
      endTime ?? this.endTime,
      added ?? this.added,
      isValid ?? this.isValid,
    );
  }
}
