import 'package:get/get.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> newTask(String title,String description, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "title": title,
      "description": description,
      "status": status,
    };
    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.createTaskUrl, body: requestBody);

    if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
     _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
