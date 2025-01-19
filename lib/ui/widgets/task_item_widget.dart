import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key, required this.taskColor, required this.taskModel, required this.status,
  });
  final Color taskColor;
  final String status;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          title: Text(taskModel.title ?? ''),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(taskModel.description ?? ''),
               Text('Date: ${taskModel.createdDate ?? ''}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: taskColor,
                    ),
                    child:  Text(status),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit_note_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete_outline_outlined))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}