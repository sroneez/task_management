import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/screens/canceled_list_screen.dart';
import 'package:task_management/ui/screens/completed_task_screen.dart';
import 'package:task_management/ui/screens/new_task_list_screen.dart';
import 'package:task_management/ui/screens/progress_task_list_screen.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskColor,
    required this.taskModel,
    required this.status,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: taskColor,
                    ),
                    child: Text(status),
                  ),
                  Row(
                    children: <Widget>[
                      _showStatusChangeDialog(context),
                      IconButton(
                        onPressed: () {
                          _deleteTaskDialog(context);
                        },
                        icon: const Icon(Icons.delete),
                      ),
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

  PopupMenuButton<String> _showStatusChangeDialog(context) {
    return PopupMenuButton<String>(
        icon: const Icon(Icons.edit_note_outlined),
        onSelected: (String selectedStatus) async {
            await _updateTaskStatus(selectedStatus, context);
        },
        itemBuilder: (context) {
          return [
            const PopupMenuItem(
              value: 'New',
              child: Text('New'),
            ),
            const PopupMenuItem(
              value: 'Progress',
              child: Text('Progress'),
            ),
            const PopupMenuItem(
              value: 'Completed',
              child: Text('Completed'),
            ),
            const PopupMenuItem(
              value: 'Canceled',
              child: Text('Canceled'),
            ),
          ];
        });
  }

  Future<dynamic> _deleteTaskDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('DELETE'),
            content: const Text('Are you sure?'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  showSnackBarMessage(context, 'Task deleted successfully');
                  await _deleteTask(taskModel.sId ?? '', context);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  Future<void> _deleteTask(String id, context) async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(id),
    );
    if (response.isSuccess) {
      Get.off(context);
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }

  Future<void> _updateTaskStatus(String newStatus, context) async {
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.taskStatusUpdateUrl(taskModel.sId ?? '', newStatus, context),
    );
    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task status updated to $newStatus');
      if (newStatus == 'New') {
        Get.toNamed(NewTaskListScreen.name);
      } else if (newStatus == 'Completed') {
        Get.toNamed( CompletedTaskScreen.name);
      } else if (newStatus == 'Progress') {
        Get.toNamed( ProgressTaskListScreen.name);
      } else if (newStatus == 'Canceled') {
        Get.toNamed( CanceledListScreen.name);
      }
    } else {
      showSnackBarMessage(context, response.errorMessage);
    }
  }
}
