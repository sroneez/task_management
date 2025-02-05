import 'package:get/get.dart';
import 'package:task_management/ui/controllers/canceled_task_controller.dart';
import 'package:task_management/ui/controllers/completed_task_controller.dart';
import 'package:task_management/ui/controllers/new_task_controller.dart';
import 'package:task_management/ui/controllers/progress_task_controller.dart';
import 'package:task_management/ui/controllers/sign_in_controller.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.put( NewTaskController());
    Get.put( ProgressTaskController());
    Get.put( CompletedTaskController());
    Get.put( CanceledTaskController());
  }

}