import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/controllers/canceled_task_controller.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class CanceledListScreen extends StatefulWidget {
  const CanceledListScreen({super.key});

  static const String name = '/canceled-task-list';

  @override
  State<CanceledListScreen> createState() => _CanceledListScreenState();
}

class _CanceledListScreenState extends State<CanceledListScreen> {
  final CanceledTaskController _canceledTaskController =
      Get.find<CanceledTaskController>();

  @override
  void didChangeDependencies() {
    _fetchCanceledTasks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: GetBuilder<CanceledTaskController>(
          builder: (controller) {
            return Visibility(
                visible: _canceledTaskController.inProgress == false,
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
            taskColor: Colors.red,
            taskModel: task,
            status: 'Canceled',
          );
        });
  }

  Future<void> _fetchCanceledTasks() async {
    bool isSuccess = await _canceledTaskController.getTaskList();
    if (!isSuccess) {
      showSnackBarMessage(context, _canceledTaskController.errorMessage!);
    }
  }
}
