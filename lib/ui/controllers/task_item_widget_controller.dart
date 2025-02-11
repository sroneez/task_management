import 'package:get/get.dart';
import 'package:task_management/data/services/network_caller.dart';
import 'package:task_management/data/utils/urls.dart';
import 'package:task_management/ui/widgets/snack_bar_message.dart';

class TaskItemWidgetController extends GetxController {
  bool isLoading = false;
  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<bool> deleteTask(String id, context) async {
    isLoading = true;
    update();

    final response = await NetworkCaller.getRequest(
      url: Urls.deleteTaskUrl(id),
    );

    isLoading = false;

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task deleted successfully');
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      showSnackBarMessage(context, errorMessage!);
      update();
      return false;
    }
  }

  Future<bool> updateTaskStatus(String id, String newStatus, context) async {
    isLoading = true;
    update();

    final response = await NetworkCaller.getRequest(
      url: Urls.taskStatusUpdateUrl(id, newStatus, context),
    );

    isLoading = false;

    if (response.isSuccess) {
      showSnackBarMessage(context, 'Task status updated to $newStatus');
      update();

      if (newStatus == 'New') {
        Get.toNamed('/new-task-list');
      } else if (newStatus == 'Completed') {
        Get.toNamed('/completed-task-list');
      } else if (newStatus == 'Progress') {
        Get.toNamed('/progress-task-list');
      } else if (newStatus == 'Canceled') {
        Get.toNamed('/canceled-task-list');
      }

      return true;
    } else {
      _errorMessage = response.errorMessage;
      showSnackBarMessage(context, errorMessage!);
      update();
      return false;
    }
  }
}
