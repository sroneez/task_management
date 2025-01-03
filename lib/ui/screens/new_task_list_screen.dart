import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/add_new_task_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';
import 'package:task_management/ui/widgets/task_item_widget.dart';
import 'package:task_management/ui/widgets/task_status_summery_counter_widget.dart';

import '../widgets/tm_app_bar.dart';

class NewTaskListScreen extends StatefulWidget {
  const NewTaskListScreen({super.key});

  static const String name = '/new-task-list';

  @override
  State<NewTaskListScreen> createState() => _NewTaskListScreenState();
}

class _NewTaskListScreenState extends State<NewTaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTaskSummeryByStatus(),
              _buildTaskListView(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewTaskScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ListView _buildTaskListView() {
    return ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 10,
        itemBuilder: (context, index) {
          return const TaskItemWidget(taskColor: Colors.blue,);
        });
  }

  Widget _buildTaskSummeryByStatus() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskStatusSummeryCounterWidget(
            counter: '09',
            title: 'New',
          ),
          TaskStatusSummeryCounterWidget(
            counter: '12',
            title: 'Progress',
          ),
          TaskStatusSummeryCounterWidget(
            counter: '25',
            title: 'Completed',
          ),
          TaskStatusSummeryCounterWidget(
            counter: '05',
            title: 'Cancelled',
          ),
        ],
      ),
    );
  }
}
