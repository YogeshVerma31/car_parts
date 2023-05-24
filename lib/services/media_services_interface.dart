import 'dart:io';

import 'package:car_parts/services/permission_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum menuOptions { delete, preview, camera, gallery, file, cancel, audio,video }


abstract class MediaServiceInterface {
  PermissionService get permissionService;

  Future<List<XFile>?> uploadImage(
      BuildContext context,
      menuOptions appImageSource);

  Future<dynamic> uploadSingleImage(
      BuildContext context,
      menuOptions appImageSource);


  Future<File?> uploadVideo(
      BuildContext context,
      menuOptions appImageSource);


}