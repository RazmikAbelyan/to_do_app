part of 'edit_task_bloc.dart';

@immutable
class EditTaskState {
  final Task task;
  final bool edited;
  final bool isValid;

  const EditTaskState(
    this.task,
    this.edited,
    this.isValid,
  );

  EditTaskState copyWith({
    Task? task,
    bool? edited,
    bool? isValid,
  }) {
    return EditTaskState(
      task ?? this.task,
      edited ?? this.edited,
      isValid ?? this.isValid,
    );
  }
}
