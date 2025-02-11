import 'package:get/get.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class ForgotPasswordVerifyEmailController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> recoveryEmail(String email,) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.recoveryVerifyEmailUrl(email));

    if(response == null){
      _errorMessage = 'Failed to connect to server';
    }
    else if (response.isSuccess) {
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage =response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
