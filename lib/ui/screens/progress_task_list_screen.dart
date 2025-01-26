import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/tm_app_bar.dart';

class ProgressTaskListScreen extends StatefulWidget {
  const ProgressTaskListScreen({super.key});

  static const String name = '/progress-task-list';


  @override
  State<ProgressTaskListScreen> createState() => _ProgressTaskListScreenState();
}

class _ProgressTaskListScreenState extends State<ProgressTaskListScreen> {
  List<TaskModel> progressTask =[];
  bool isLoading = false;

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
        child: Visibility(
          visible: isLoading == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView()),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
        itemCount: progressTask.length,
        itemBuilder: (context, index) {
          final task = progressTask[index];
          return  TaskItemWidget(taskColor: Colors.pink, status: 'Progress', taskModel: task,);
        });
  }

  Future<void> _fetchProgressTasks() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller.getRequest(
      url: Urls.taskListByStatusUrl('Progress'),
    );

    if (response.isSuccess && response.responseData != null) {
      try{
        final responseData = response.responseData;
        final taskListModel = TaskListByStatusModel.fromJson(responseData!);
        setState(() {
          progressTask = taskListModel.taskList ?? [];
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
