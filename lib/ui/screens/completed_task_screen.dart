import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/controllers/completed_task_controller.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({
    super.key,
  });

  static const String name = '/completed-task-list';

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskController _completedTaskController = Get.find<CompletedTaskController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchCompletedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: GetBuilder<CompletedTaskController>(
          builder: (controller) {
            return Visibility(
              visible: _completedTaskController.inProgress == false,
                replacement: const CenteredCircularProgressIndicator(),
                child: _buildTaskListView(controller.taskList));
          }
        ),
      ),
    );
  }

  ListView _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return TaskItemWidget(
            status: 'Completed',
            taskModel: task,
            taskColor: Colors.green,
          );
        });
  }

  Future<void> _fetchCompletedTasks() async {
   bool isSuccess = await _completedTaskController.getTaskList();
   if(!isSuccess){
     showSnackBarMessage(context, _completedTaskController.errorMessage!);
   }
  }
}
