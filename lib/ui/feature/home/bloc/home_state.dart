part of 'home_bloc.dart';

@immutable
class HomeState {
  final List<Task> tasks;
  final int showDescriptionIndex;

  const HomeState(
    this.tasks,
    this.showDescriptionIndex,
  );

  HomeState copyWith({
    List<Task>? tasks,
    int? showDescriptionIndex,
  }) {
    return HomeState(
      tasks ?? this.tasks,
      showDescriptionIndex ?? this.showDescriptionIndex,
    );
  }
}
