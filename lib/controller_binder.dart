import 'package:get/get.dart';
import 'package:task_management/ui/controllers/add_new_task_controller.dart';
import 'package:task_management/ui/controllers/auth_controller.dart';
import 'package:task_management/ui/controllers/canceled_task_controller.dart';
import 'package:task_management/ui/controllers/completed_task_controller.dart';
import 'package:task_management/ui/controllers/forgot_password_verify_email_controller.dart';
import 'package:task_management/ui/controllers/forgot_password_verify_otp_controller.dart';
import 'package:task_management/ui/controllers/new_task_controller.dart';
import 'package:task_management/ui/controllers/profile_controller.dart';
import 'package:task_management/ui/controllers/progress_task_controller.dart';
import 'package:task_management/ui/controllers/reset_password_controller.dart';
import 'package:task_management/ui/controllers/sign_in_controller.dart';
import 'package:task_management/ui/controllers/sign_up_controller.dart';
import 'package:task_management/ui/controllers/task_item_widget_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.put( NewTaskController());
    Get.put( ProgressTaskController());
    Get.put( CompletedTaskController());
    Get.put( CanceledTaskController());
    Get.put( TaskItemWidgetController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => ForgotPasswordVerifyEmailController());
    Get.lazyPut(() =>ForgotPasswordVerifyOtpController());
    Get.lazyPut(() =>ResetPasswordController());
    Get.put(AddNewTaskController());
    Get.put(ProfileController());
    Get.put(AuthController());

  }

}