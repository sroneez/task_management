import 'package:get/get.dart';
import 'package:task_management/data/models/task_list_by_status_model.dart';
import 'package:task_management/data/models/task_model.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class ForgotPasswordVerifyOtpController extends GetxController {
  bool _getTaskListInProgress = false;
  TaskListByStatusModel? _taskListByStatusModel;

  List<TaskModel> get taskList => _taskListByStatusModel!.taskList ?? [];

  bool get inProgress => _getTaskListInProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otp) async {
    bool isSuccess = false;
    _getTaskListInProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.otpVerificationUrl(email, otp),
    );

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getTaskListInProgress = false;
    update();
    return isSuccess;
  }
}
