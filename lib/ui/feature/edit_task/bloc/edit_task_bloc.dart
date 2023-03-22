import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/core/model/task.dart';

part 'edit_task_event.dart';
part 'edit_task_state.dart';

class EditTaskBloc extends Bloc<EditTaskEvent, EditTaskState> {
  EditTaskBloc(
      Task task
      ) : super(EditTaskState(task, false)) {

    on<TitleEdited>((event, emit) {

      emit(state.copyWith(task: task.copyWith(title: event.title)));
    });

    on<DescriptionEdited>((event, emit) {
      emit(state.copyWith(task: task.copyWith(description: event.description)));
    });

    on<DateEdited>((event, emit) {
      emit(state.copyWith(task: task.copyWith(endDate: event.endDate)));
    });
    on<TaskEdited>((event, emit) {
      emit(state.copyWith(edited: true));
    });
  }
}
