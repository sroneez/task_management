import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_management/app.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/screens/sign_in_screen.dart';

class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final Map<String, dynamic>? responseData;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
      {required String url, Map<String, dynamic>? params}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      Response response =
          await get(uri, headers: {'token': AuthController.accessToken ?? ''});
      debugPrint('Response code => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');
      if (response.statusCode == 200) {
        final decodedResponseData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponseData);
      } else if (response.statusCode == 401) {
        _logout();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> postRequest(
      {required String url, Map<String, dynamic>? body}) async {
    try {
      Uri uri = Uri.parse(url);
      debugPrint('URL => $url');
      debugPrint('BODY => $body');
      Response response = await post(uri, body: jsonEncode(body), headers: {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken ?? ''
      });
      debugPrint('Response code => ${response.statusCode}');
      debugPrint('Response Data => ${response.body}');

      if (response.statusCode == 200) {
        final decodedResponseData = jsonDecode(response.body);
        return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponseData);
      } else if (response.statusCode == 401) {
        await _logout();
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      } else {
        debugPrint('Error response: ${response.body}');
        return NetworkResponse(
            isSuccess: false, statusCode: response.statusCode);
      }
    } catch (e) {
      return NetworkResponse(
          isSuccess: false, statusCode: -1, errorMessage: e.toString());
    }
  }

  static Future<void> _logout() async {
    await AuthController.clearUserData();
    Navigator.pushNamedAndRemoveUntil(
        TaskManagerApp.navigatorKey.currentContext!,
        SignInScreen.name,
        (predicate) => false);
  }
}
