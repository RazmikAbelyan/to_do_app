import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/core/model/task.dart';

part 'add_tasks_event.dart';

part 'add_tasks_state.dart';

class AddTasksBloc extends Bloc<AddTasksEvent, AddTasksState> {
  AddTasksBloc() : super(const AddTasksState.initial()) {
    on<TitleChanged>((event, emit) {
      emit(state.copyWith(title: event.title));
    });

    on<DescriptionChanged>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<DateChanged>((event, emit) {
      emit(state.copyWith(endTime: event.endDate));
    });
    on<TaskAdded>((event, emit) {
      emit(state.copyWith(added: true));
    });
  }
}
