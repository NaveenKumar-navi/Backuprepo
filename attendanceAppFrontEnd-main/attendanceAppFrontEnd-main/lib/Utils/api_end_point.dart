class ApiEndPoints {
   //static const String baseUrl = 'https://extendotechnologies.com:5055/';
   static const String baseUrl = 'http://localhost:8081/';
 // static const String baseUrl = 'https://33be-223-184-81-251.ngrok-free.app/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String loginEmail = 'auth/login';
  final String punch = 'employee/attendance/punch';
  final String getByDatePunchData = 'employee/attendance/getByDate';
  final String getByAttendanceList = 'employee/attendance/getByEmployee';
  final String getEmployeeData = 'employee/getEmployee';
  final String uploadImage = 'employee/upload/profile';
  final String viewImage = 'employee/getimage/';
}