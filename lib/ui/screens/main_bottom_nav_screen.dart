import 'package:flutter/material.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/ui/screens/canceled_list_screen.dart';
import 'package:task_management/ui/screens/new_task_list_screen.dart';
import 'package:task_management/ui/screens/progress_task_list_screen.dart';

import 'completed_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static const String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {

  final List<TaskModel> task = [];

  List<TaskModel> get completedTask{
    return task.where((task) => task.status == 'Completed').toList();
}

  int _selectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskListScreen(),
    const ProgressTaskListScreen(),
    const CompletedTaskScreen(),
    const CanceledListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: ()async{

        },
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: ((int index) {
            _selectedIndex = index;
            setState(() {});
          }),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.new_label_outlined), label: 'New Task'),
            NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
            NavigationDestination(icon: Icon(Icons.done), label: 'Completed'),
            NavigationDestination(
                icon: Icon(Icons.cancel_outlined), label: 'Cancelled'),
          ]),
    );
  }
}
