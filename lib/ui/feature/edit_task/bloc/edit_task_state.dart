part of 'edit_task_bloc.dart';

@immutable
class EditTaskState {
  final Task task;
  final bool edited;

  const EditTaskState(this.task, this.edited);

  EditTaskState copyWith({
    Task? task,
    bool? edited,
  }) {
    return EditTaskState(
      task ?? this.task,
      edited ?? this.edited,
    );
  }
}
