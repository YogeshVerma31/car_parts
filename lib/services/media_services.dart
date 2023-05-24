import 'dart:io';

import 'package:car_parts/services/permission_service.dart';
import 'package:car_parts/services/service_locator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

import 'media_services_interface.dart';

class MediaService implements MediaServiceInterface {
  @override
  Future<bool> canReadContacts(BuildContext context) {
    throw UnimplementedError();
  }

  Future<bool> _handleImageUploadPermissions(
      BuildContext context, menuOptions _imageSource) async {
    if (_imageSource == null) {
      return false;
    }
    if (_imageSource == menuOptions.gallery) {
      return permissionService.handlePhotosPermission(context);
    } else if (_imageSource == menuOptions.audio) {
      return permissionService.handleMicroPhonePermission(context);
    } else {
      return false;
    }
  }

  @override
  PermissionService get permissionService => getIt<PermissionService>();

  @override
  Future<bool> uploadAudio(BuildContext context, menuOptions appImageSource) {
    throw UnimplementedError();
  }

  @override
  Future<PlatformFile> uploadFile(
      BuildContext context, menuOptions appImageSource) {
    throw UnimplementedError();
  }

  @override
  Future<List<XFile>?> uploadImage(
      BuildContext context, menuOptions appImageSource,
      {bool isCropRequired = true}) async {
    const bool canProceed = true;
    // await _handleImageUploadPermissions(context, appImageSource);
    if (canProceed) {
      CroppedFile? processedPickedImageFile;
      // Convert our own AppImageSource into a format readable by the used package
      // In this case it's an ImageSource enum
      final ImageSource _imageSource =
          ImageSource.values.byName(appImageSource.name);

      final imagePicker = ImagePicker();
      List<XFile> rawPickedImageFile = await imagePicker.pickMultiImage(maxHeight: 600, maxWidth: 500);

      // if (rawPickedImageFile != null) {
      //   processedPickedImageFile =
      //       await cropImage(File(rawPickedImageFile.path), isCropRequired);
      // }
      return rawPickedImageFile;
    }
    return null;
  }

  static Future<CroppedFile?> cropImage(
      File pickedFile, bool isCropRequired) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: isCropRequired
          ? const CropAspectRatio(ratioX: 1.2, ratioY: 1.5)
          : null,
      cropStyle: CropStyle.rectangle,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Add Photo',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Add Photo',
        )
      ],
    );
    return croppedFile;
  }

  @override
  Future<File?> uploadVideo(
      BuildContext context, menuOptions appImageSource) async {
    final bool canProceed = true;
    // await _handleImageUploadPermissions(context, appImageSource);

    if (canProceed) {
      File? processedPickedVideoFile;

      // Convert our own AppImageSource into a format readable by the used package
      // In this case it's an ImageSource enum
      final ImageSource _imageSource =
          ImageSource.values.byName(appImageSource.name);

      final imagePicker = ImagePicker();
      final rawPickedVideoFile = await imagePicker.pickVideo(
          source: _imageSource, maxDuration: const Duration(seconds: 30));

      if (rawPickedVideoFile != null) {
        //to convert from XFile type provided by the package to dart:io's File type
        processedPickedVideoFile = File(rawPickedVideoFile.path);
      }
      return processedPickedVideoFile;
    }
    return null;
  }

  @override
  Future<dynamic?> uploadSingleImage(BuildContext context, menuOptions appImageSource) async {
    const bool canProceed = true;
    // await _handleImageUploadPermissions(context, appImageSource);
    if (canProceed) {
      CroppedFile? processedPickedImageFile;
      // Convert our own AppImageSource into a format readable by the used package
      // In this case it's an ImageSource enum
      final ImageSource _imageSource =
      ImageSource.values.byName(appImageSource.name);

      final imagePicker = ImagePicker();

      dynamic rawPickedImageFile = await imagePicker.pickImage(maxHeight: 600, maxWidth: 500,source: _imageSource);

      if (rawPickedImageFile != null) {
        processedPickedImageFile =
            await cropImage(File(rawPickedImageFile.path), true);
      }
      return processedPickedImageFile;
    }
    return null;
  }
}
