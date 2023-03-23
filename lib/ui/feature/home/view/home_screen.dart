import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/model/task.dart';
import 'package:to_do_app/ui/feature/add_task/bloc/add_tasks_bloc.dart';
import 'package:to_do_app/ui/feature/add_task/view/add_task_screen.dart';
import 'package:to_do_app/ui/feature/edit_task/bloc/edit_task_bloc.dart';
import 'package:to_do_app/ui/feature/edit_task/view/edit_task_screen.dart';
import 'package:to_do_app/ui/feature/home/bloc/home_bloc.dart';
import 'package:to_do_app/ui/feature/home/view/task_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.tasks.length + 1,
            itemBuilder: (context, index) => index < state.tasks.length
                ? !state.tasks[index].isHidden
                    ? GestureDetector(
                        onTap: () => context.read<HomeBloc>().add(
                              HomeTaskOpenDescription(index: state.showDescriptionIndex == index ? -1 : index),
                            ),
                        child: TaskCard(
                          showDescription: state.showDescriptionIndex == index,
                          taskDone: (value) => context.read<HomeBloc>().add(
                                HomeTaskDone(
                                  index: index,
                                  isDone: value,
                                ),
                              ),
                          onDelete: () => context.read<HomeBloc>().add(HomeTaskDelete(index: index)),
                          onEdit: () => _editTask(context, state.tasks[index], index),
                          task: state.tasks[index],
                        ),
                      )
                    : const SizedBox()
                : IconButton(
                    onPressed: () => _addTask(context),
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask(BuildContext context) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) => BlocProvider<AddTasksBloc>(
          create: (context) => AddTasksBloc(),
          child: AddTaskScreen(
            //Used callback because doesn't have Db to save
            onAdd: (task) => context.read<HomeBloc>().add(HomeTaskAdded(task: task)),
          ),
        ),
      );

  void _editTask(BuildContext context, Task task, int index) => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) => BlocProvider<EditTaskBloc>(
          create: (context) => EditTaskBloc(task),
          child: EditTaskScreen(
            //Used callback because doesn't have Db to save
            onEdit: (task) => context.read<HomeBloc>().add(
                  HomeTaskEdited(
                    task: task,
                    index: index,
                  ),
                ),
          ),
        ),
      );
}
