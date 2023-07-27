import 'package:permission_handler/permission_handler.dart';

class PermissionHandler{

  Future<bool> requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
  return status.isGranted;
  }
}