
import 'package:car_parts/services/permission_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../ui/warning_dialog.dart';

class PermissionHandlerPermissionService implements PermissionService {
  @override
  Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }
  @override
  Future<PermissionStatus> requestMicrophonePermission() async {
    return await Permission.microphone.request();
  }

  @override
  Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  @override
  Future<PermissionStatus> requestContactPermission() async {
    return await Permission.contacts.request();
  }

  @override
  Future<bool> handleCameraPermission(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> handleMicroPhonePermission(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<bool> handlePhotosPermission(BuildContext context) async {
    final PermissionStatus photosPermissionStatus = await requestPhotosPermission();

    if (photosPermissionStatus != PermissionStatus.granted) {
      print('😰 😰 😰 😰 😰 😰 Permission to photos not granted! 😰 😰 😰 😰 😰 😰');
      await showDialog(
          context: context,
          builder: (_context) => WarningDialogBox(
        title: 'Gallery Permission',
        descriptions: 'Gallery permission should be granted to use this feature, would you like to go to app settings to give photos permission?',
        enableButtonTitle:
        'yes',
        disableButtonTitle:'no',
        buttonColor:'',
        singleButton: false,
        onPressed: (type) => {
          if(type == 'YES'){
            openAppSettings()
          }
        },
      )
    );
    return false;
  }
    return true;
  }
}
