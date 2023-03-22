import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/model/task.dart';
import 'package:to_do_app/ui/feature/edit_task/bloc/edit_task_bloc.dart';

class EditTaskScreen extends StatefulWidget {
  final ValueChanged<Task>? onEdit;

  const EditTaskScreen({
    Key? key,
    required this.onEdit,
  }) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditTaskBloc, EditTaskState>(
        listener: (context, state) => widget.onEdit?.call(
              Task(
                title: state.task.title,
                description: state.task.description,
                endDate: state.task.endDate,
                isDone: false,
                hide: state.task.hide
              ),
            ),
        listenWhen: (oldState, newState) => newState.edited,
        builder: (context, state) {
          dateController.text = DateFormat('yyyy-MM-dd').format(state.task.endDate);
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            padding: const EdgeInsets.only(left: 15, right: 15),
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
                          icon: Icon(Icons.close),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "Edit task",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "verdana_regular",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(width: 25)
                    ],
                  ),
                  const Divider(),
                  TextFormField(
                    onChanged: (title) => context.read<EditTaskBloc>().add(TitleEdited(title)),
                    initialValue: state.task.title,
                    decoration: const InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.grey,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                      labelText: 'Title',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    onChanged: (description) => context.read<EditTaskBloc>().add(DescriptionEdited(description)),
                    initialValue: state.task.description,
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
                            initialDate: state.task.endDate, //get today's date
                            firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          dateController.text = formattedDate;
                          context.read<EditTaskBloc>().add(DateEdited(pickedDate));
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
                              child: Text('Edit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "verdana_regular",
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                          onTap: () {
                            context.read<EditTaskBloc>().add(TaskEdited());
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
