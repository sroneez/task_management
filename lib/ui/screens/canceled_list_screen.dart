import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';

import '../../data/services/network_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/tm_app_bar.dart';

class CanceledListScreen extends StatefulWidget {
  const CanceledListScreen({super.key});

  static const String name = '/canceled-task-list';


  @override
  State<CanceledListScreen> createState() => _CanceledListScreenState();
}

class _CanceledListScreenState extends State<CanceledListScreen> {
  List<TaskModel> canceledTask = [];
  bool isLoading = false;

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
        child: Visibility(
          visible: isLoading == false,
            replacement: const CenteredCircularProgressIndicator(),
            child: _buildTaskListView()),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
        itemCount: canceledTask.length,
        itemBuilder: (context, index) {
          final task = canceledTask[index];
          return  TaskItemWidget(taskColor: Colors.red,taskModel: task, status: 'Canceled',);
        });
  }

  Future<void> _fetchCanceledTasks() async {
    setState(() {
      isLoading = true;
    });

    final response = await NetworkCaller.getRequest(
      url: Urls.taskListByStatusUrl('Canceled'),
    );

    if (response.isSuccess && response.responseData != null) {
      try{
        final responseData = response.responseData;
        final taskListModel = TaskListByStatusModel.fromJson(responseData!);
        setState(() {
          canceledTask = taskListModel.taskList ?? [];
        });
      }catch(e){
        debugPrint('Failed to parse task list: $e');
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
