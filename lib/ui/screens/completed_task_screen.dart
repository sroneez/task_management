import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../../data/utils/urls.dart';
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
  List<TaskModel> completedTask = [];
  bool isLoading = false;

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
        child: Visibility(
          visible: isLoading == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView()),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
        itemCount: completedTask.length,
        itemBuilder: (context, index) {
          final task = completedTask[index];
          return TaskItemWidget(
            status: 'Completed',
            taskModel: task,
            taskColor: Colors.green,
          );
        });
  }

  Future<void> _fetchCompletedTasks() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller.getRequest(
      url: Urls.taskListByStatusUrl('Completed'),
    );

    if (response.isSuccess && response.responseData != null) {
      try{
        final responseData = response.responseData;
        final taskListModel = TaskListByStatusModel.fromJson(responseData!);
        setState(() {
          completedTask = taskListModel.taskList ?? [];
        });
      }catch(e){
        debugPrint('failed to parse task list: $e');
      }
    } else {
      // Handle error or show a message
      debugPrint('Failed to fetch tasks: ${response.errorMessage}');
    }

    setState(() {
      isLoading = false;
    });
  }
}
