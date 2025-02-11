import 'package:get/get.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/models/user_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';

class NewTaskController extends GetxController {
  bool _getTaskListInProgress = false;
  TaskListByStatusModel? _taskListByStatusModel;

  List<TaskModel> get taskList => _taskListByStatusModel!.taskList ?? [];

  bool get inProgress => _getTaskListInProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> getTaskList() async {
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskListByStatusUrl('New'));

    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {}
    _getTaskListInProgress = false;
    update();
    return isSuccess;
  }

  Future<bool> getTaskSummaryByStatus() async{
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.taskCountByStatusUrl);

    if (response.isSuccess) {
      _taskListByStatusModel =
          TaskListByStatusModel.fromJson(response.responseData!);
      isSuccess = true;
      _errorMessage = null;
    } else {}
    _getTaskListInProgress = false;
    update();
    return isSuccess;
  }


}
