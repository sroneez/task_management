import 'dart:convert';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';

class ProfileController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;


  Future<bool> updateProfile(String email, String firstName, String lastName,
      String mobile, String? password,XFile? pickedImage) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> requestBody = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };
    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage.readAsBytes();
      requestBody['photo'] = base64Encode(imageBytes);
    }
    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }
    final NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.updateProfileUrl, body: requestBody);

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
