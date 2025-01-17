class Urls{
  static const String _baseUrls = 'https://task.teamrabbil.com/api/v1';
  static const String registrationUrl = '$_baseUrls/registration';
  static const String loginUrl = '$_baseUrls/login';
  static const String createTaskUrl = '$_baseUrls/createTask';
  static const String taskCountByStatusUrl = '$_baseUrls/taskStatusCount';
  static  String taskListByStatusUrl(String status) => '$_baseUrls/listTaskByStatus/$status';
}