import 'package:car_parts/data/model/chat_model.dart';
import 'package:car_parts/data/repository/chat_repository_impl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import '../services/media_services.dart';
import '../services/media_services_interface.dart';


class ChatController extends GetxController {
  final isButtonLoading = false.obs;
  final isLoading = false.obs;

  final chatDataList = [ChatDataKit()].obs;
  final _chatRepository = ChatRepositoryImpl();

  String imageFileName = '';
  dynamic imageFile;

  Future<void> getChat(String id) async {
    chatDataList.clear();
    isLoading(true);
    try {
      final chatResponse = await _chatRepository.getChatById(id);
      isLoading(false);
      chatDataList.addAll(chatResponse!.data!.reversed);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    }
  }

  Future<void> getPhoto(String id , menuOptions options, bool isPhoto, context) async {
    final dynamic pickedFile = isPhoto
        ? await MediaService().uploadSingleImage(context, options)
        : await MediaService().uploadVideo(context, options);
    if (pickedFile == null) return;
    if (isPhoto) {
      imageFile = pickedFile;
      imageFileName = pickedFile.path;
    }
    postChat(id, '');
  }

  Future<void> postChat(String id,String message) async {
    isButtonLoading(true);
    try {
      // imageFileImages.map((element) async {
      //   // final http.MultipartFile imageFIle = await http.MultipartFile.fromPath(
      //   //     'media', File(element.path).path);
      //   // request.files.add(imageFIle);
      // });
      final http.MultipartRequest request = http.MultipartRequest('POST',
          Uri.parse('https://mdayurvediccollege.in/demo/autopart/api//chat'));

      if (imageFileName !='') {
        final http.MultipartFile videoFIle = await http.MultipartFile.fromPath(
            'image', File(imageFile.path).path);
        request.files.add(videoFIle);
      }
      final Map<String, String> headers = {
        'token': '${SharedPreference().getString(AppConstants().authToken)}',
        'Content-type': 'multipart/form-data'
      };
      request.headers.addAll(headers);
      request.fields.addAll({
        'oid': id,
        'messg': message,
      });
      final res = await request.send();
      final response = await http.Response.fromStream(res);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != null && response.statusCode != 200) {
        throw Exception(response.body);
      }
      final result = json.decode(response.body);
      Fluttertoast.showToast(msg: result['message']);
      print(result['message']);
      getChat(id);
      isButtonLoading(false);
      imageFileName = '';
      imageFile = '';
      return result;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
