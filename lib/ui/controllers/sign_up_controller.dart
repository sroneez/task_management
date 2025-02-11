import 'package:get/get.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> signUp(
    String email,
    String firstName,
    String lastName,
    String mobile,
    String password,
    context,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
      "photo": ""
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.registrationUrl, body: requestBody);

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Registration successful!');
      isSuccess = true;
      _errorMessage = null;
    } else {
      showSnackBarMessage(context, _errorMessage!);
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
