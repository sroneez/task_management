import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/controllers/task_item_widget_controller.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class TaskItemWidget extends StatelessWidget {
  TaskItemWidget({
    super.key,
    required this.taskColor,
    required this.taskModel,
    required this.status,
  });

  final Color taskColor;
  final String status;
  final TaskModel taskModel;
  final TaskItemWidgetController _taskItemWidgetController =
      Get.find<TaskItemWidgetController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskItemWidgetController>(builder: (controller) {
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
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
    });
  }

  PopupMenuButton<String> _showStatusChangeDialog(context) {
    return PopupMenuButton<String>(
        icon: const Icon(Icons.edit_note_outlined),
        onSelected: (String selectedStatus) async {
          _updateTaskStatus(
              taskModel.sId ?? '', selectedStatus, context);
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
                 _deleteTask(taskModel.sId ?? '', context);

                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Get.off(context);
                },
                child: const Text('No'),
              ),
            ],
          );
        });
  }

  Future<void> _deleteTask(String taskId, BuildContext context) async {
    bool isSuccess = await _taskItemWidgetController.deleteTask(taskId, context);  // Call API
    if (!isSuccess) {
      showSnackBarMessage(context, 'Failed to Delete Task');
      
    } 
  }

  Future<void> _updateTaskStatus(String id,String newStatus, context) async{
    bool isSuccess = await _taskItemWidgetController.updateTaskStatus(id, newStatus, context);

    if(!isSuccess){
      showSnackBarMessage(context, 'failed to update the task');
    }
  }


// Future<void> _deleteTask(String id, context) async {
//   final NetworkResponse response = await NetworkCaller.getRequest(
//     url: Urls.deleteTaskUrl(id),
//   );
//   if (response.isSuccess) {
//     Get.off(context);
//   } else {
//     showSnackBarMessage(context, response.errorMessage);
//   }
// }

// Future<void> _updateTaskStatus(String newStatus, context) async {
//   final NetworkResponse response = await NetworkCaller.getRequest(
//     url: Urls.taskStatusUpdateUrl(taskModel.sId ?? '', newStatus, context),
//   );
//   if (response.isSuccess) {
//     showSnackBarMessage(context, 'Task status updated to $newStatus');
//     if (newStatus == 'New') {
//       Get.toNamed(NewTaskListScreen.name);
//     } else if (newStatus == 'Completed') {
//       Get.toNamed(CompletedTaskScreen.name);
//     } else if (newStatus == 'Progress') {
//       Get.toNamed(ProgressTaskListScreen.name);
//     } else if (newStatus == 'Canceled') {
//       Get.toNamed(CanceledListScreen.name);
//     }
//   } else {
//     showSnackBarMessage(context, response.errorMessage);
//   }
// }
}
