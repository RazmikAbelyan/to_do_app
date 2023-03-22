import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/model/task.dart';
import 'package:to_do_app/ui/feature/add_task/bloc/add_tasks_bloc.dart';

class AddTaskScreen extends StatefulWidget {
  final ValueChanged<Task>? onAdd;

  const AddTaskScreen({
    Key? key,
    this.onAdd,
  }) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController  dateController = TextEditingController();
  String? titleErrorText;
  String? dateErrorText;


  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddTasksBloc, AddTasksState>(
      listener: (context, state) => widget.onAdd?.call(Task(
        title: state.title,
        description: state.description,
        endDate: state.endTime!,
        isDone: false,
        hide: false,
      )),
      listenWhen: (oldState, newState) => newState.added,
      builder:(context, state) => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 100,
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    child: IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Add new task",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "verdana_regular",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 25)
                ],
              ),
              const Divider(),
              TextFormField(
                onChanged: (title) => context.read<AddTasksBloc>().add(TitleChanged(title)),
                decoration:  InputDecoration(
                  errorText: titleErrorText,
                  focusColor: Colors.white,
                  fillColor: Colors.grey,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                  labelText: 'Title',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                onChanged: (description) => context.read<AddTasksBloc>().add(DescriptionChanged(description)),

                maxLines: 7,
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  //make hint text
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),

                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: "verdana_regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    errorText: dateErrorText,
                    prefixIcon: const Icon(Icons.calendar_today),
                    labelText: "End date",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'Choose end date',
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(

                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                        dateController.text = formattedDate;
                        context.read<AddTasksBloc>().add(DateChanged(pickedDate));
                    }
                  }),
              const SizedBox(height: 15),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                        child: const Center(
                          child: Text('Cansel',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green,
                        ),
                        child: const Center(
                          child: Text('Add',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "verdana_regular",
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                      ),
                      onTap: () {
                        if(state.title.isNotEmpty && state.endTime != null){
                        context.read<AddTasksBloc>().add(TaskAdded());
                        Navigator.pop(context);
                         }else{
                          setState(() {
                            dateErrorText = state.endTime == null ? "Dan/'t be empty" : null;
                            titleErrorText = state.title.isEmpty ? "Dan/'t be empty" : null;
                          });

                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
