part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeTaskAdded extends HomeEvent {
  final Task task;

  HomeTaskAdded({
    required this.task,
  });
}

class HomeTaskEdited extends HomeEvent {
  final Task task;
  final int index;

  HomeTaskEdited({
    required this.task,
    required this.index,
  });
}
class HomeTaskOpenDescription extends HomeEvent {
  final int index;

  HomeTaskOpenDescription({
    required this.index,
  });
}

class HomeTaskDelete extends HomeEvent {
  final int index;

  HomeTaskDelete({
    required this.index,
  });
}

class HomeTaskDone extends HomeEvent {
  final int index;
  final bool isDone;

  HomeTaskDone({
    required this.index,
    required this.isDone,
  });
}
class HomeTaskFiltered extends HomeEvent {
  final String value;

  HomeTaskFiltered({
    required this.value,
  });
}
