import 'package:flutter/cupertino.dart';

abstract class PermissionService {
  Future requestPhotosPermission();

  Future<bool> handlePhotosPermission(BuildContext context);


  Future<bool> handleCameraPermission(BuildContext context);


  Future<bool> handleMicroPhonePermission(BuildContext context);
}
