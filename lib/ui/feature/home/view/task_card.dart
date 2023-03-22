import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/core/model/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final ValueChanged<bool> taskDone;
  final bool showDescription;

  const TaskCard({
    Key? key,
    required this.task,
    required this.onDelete,
    required this.onEdit,
    required this.taskDone,
    required this.showDescription,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(widget.task.endDate);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          child: SizedBox(
            height: 70,
            width: double.infinity,
            child: Row(
              children: [
                Checkbox(
                  value: widget.task.isDone,
                  onChanged: (value) => widget.taskDone.call(value!),
                ),
                Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: Theme.of(context).dividerColor),
                      right: BorderSide(color: Theme.of(context).dividerColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    showAlertDialog(context, value);
                  },
                  itemBuilder: (BuildContext ctx) {
                    return [
                      PopupMenuItem(
                        value: "Edit",
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                (Icons.edit),
                              ),
                            ),
                            Text(
                              "Edit",
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "Delete",
                        child: Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(
                                (Icons.delete),
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
        if (widget.showDescription)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  widget.task.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void showAlertDialog(BuildContext context, String value) {
    String content = '';
    VoidCallback callback = () {};
    switch (value) {
      case "Edit":
        callback = widget.onEdit;
        content = "Are you sure you want to edit this task";
        break;
      case "Delete":
        callback = widget.onDelete;
        content = "Are you sure you want to delete this task";
        break;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(value),
          content: Text(content),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: const Size(100, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: value == "Delete" ? Colors.red : Colors.green,
                minimumSize: const Size(100, 36),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              child: Text(value),
              onPressed: () {
                Navigator.pop(context);
                callback.call();
              },
            ),
          ],
        );
      },
    );
  }
}
