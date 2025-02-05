import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/controllers/progress_task_controller.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  static const String name = '/progress-task-list';

  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  bool isLoading = false;
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void didChangeDependencies() {
    _fetchProgressTasks();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: GetBuilder<ProgressTaskController>(builder: (controller) {
          return Visibility(
              visible: _progressTaskController.inProgress == false,
              replacement: const CenteredCircularProgressIndicator(),
              child: _buildTaskListView(controller.taskList));
        }),
      ),
    );
  }

  ListView _buildTaskListView(List<TaskModel> taskList) {
    return ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final task = taskList[index];
          return TaskItemWidget(
            taskColor: Colors.pink,
            status: 'Progress',
            taskModel: task,
          );
        });
  }

  Future<void> _fetchProgressTasks() async {
    bool isSuccess = await _progressTaskController.getTaskList();
    if (!isSuccess) {
      showSnackBarMessage(context, _progressTaskController.errorMessage!);
    }
  }
}
