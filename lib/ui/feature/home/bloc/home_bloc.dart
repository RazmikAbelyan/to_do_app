
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:to_do_app/core/model/task.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super( const HomeState([], -1,)) {
    on<HomeTaskAdded>((event, emit) {
      final tasks = [...state.tasks] ;
      tasks.add(event.task);
      emit(
        state.copyWith(tasks: tasks),
      );
    });
    on<HomeTaskDelete>((event, emit) {
      final tasks = [...state.tasks] ;
      tasks.removeAt(event.index);
      emit(
        state.copyWith(tasks: tasks),
      );
    });
    on<HomeTaskDone>((event, emit) {
      final tasks = [...state.tasks];
      Task singleTask = tasks[event.index];
      singleTask = singleTask.copyWith(isDone: event.isDone);
      tasks[event.index] = singleTask;
      emit(
        state.copyWith(tasks: tasks),
      );
    });
    on<HomeTaskEdited>((event, emit) {
      final tasks = [...state.tasks];
      tasks[event.index] = event.task;
      emit(
        state.copyWith(tasks: tasks),
      );
    });
    on<HomeTaskOpenDescription>((event, emit){
      emit(
        state.copyWith(showDescriptionIndex: event.index),
      );
    });
    on<HomeTaskFiltered>((event, emit){

      switch(event.value){
          case  "completed" :
            int index = 0;
            for(Task task in state.tasks){
              if(task.isDone){
                state.tasks[index] = task.copyWith(hide: false);
              }else{
                state.tasks[index] = task.copyWith(hide: true);
              }
              index ++;

            }
            break;
        case "not completed":
          int index = 0;
          for(Task task in state.tasks){
            if(!task.isDone){
              state.tasks[index] = task.copyWith(hide: false);
            }else{
              state.tasks[index] = task.copyWith(hide: true);
            }
            index ++;
          }
          break;
        case "":
          int index = 0;
          for(Task task in state.tasks){
              state.tasks[index] = task.copyWith(hide: false);
              index ++;
          }
          break;
        default:


      }

      emit(
        state.copyWith(),
      );
    });


  }
}
