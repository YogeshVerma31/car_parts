import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:car_parts/constants/app_constants.dart';
import 'package:car_parts/data/model/ad_model.dart';
import 'package:car_parts/data/model/car_brand_model.dart';
import 'package:car_parts/data/model/car_model.dart';
import 'package:car_parts/data/repository/auth_repository_impl.dart';
import 'package:car_parts/data/repository/car_repository_impl.dart';
import 'package:car_parts/ui/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_endpoint.dart';
import '../providers/network/api_provider.dart';
import '../services/media_services.dart';
import '../services/media_services_interface.dart';
import 'authentication_controller.dart';

class CarController extends GetxController {
  PageController? pageController,carBrandController;

  var selectedPage = 0.obs;
  var selectedCarBrandPage = 0.obs;

  final _adItems = <AdModelList>[];

  get getAdList => _adItems.obs;
  Timer? _timer,_carBrandTimer;

  @override
  void onInit() {
    pageController = PageController(initialPage: selectedPage.value);
    _timer = Timer.periodic(const Duration(seconds: 3), (time) async {
      var selectedPage = (pageController?.page?.toInt() ?? 0) + 1;
      if (selectedPage == _adItems.length) {
        selectedPage = 0;
      }
      await pageController?.animateToPage(
        selectedPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });


    super.onInit();
  }

  void startCarBrandAd(){
    carBrandController = PageController(initialPage: selectedCarBrandPage.value);
    _carBrandTimer = Timer.periodic(const Duration(seconds: 3), (time) async {
      var selectedPage = (carBrandController?.page?.toInt() ?? 0) + 1;
      if (selectedPage == _adItems.length) {
        selectedPage = 0;
      }
      await carBrandController?.animateToPage(
        selectedPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _carBrandTimer?.cancel();
    super.onClose();
  }

  void pageChanged(int currentPage) {
    print("current page $currentPage");

    print("selected page $selectedPage");
    update();
  }

  var isLoading = false.obs;
  final _carRepository = CarRepositoryImpl();
  final _authRepository = AuthRepositoryImpl();
  var carBrandList = [Data()].obs;
  var carByIdList = [CarData()].obs;

  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final buildingController = TextEditingController();
  final pinCodeController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final shortDescController = TextEditingController();
  final imageDescController = TextEditingController();
  final videoDescController = TextEditingController();
  final companyDescController = TextEditingController();
  final modelDescController = TextEditingController();
  final fuelTypeController = TextEditingController();
  final yearDescController = TextEditingController();

  var imageFileName = <String>[].obs;
  var imageFileImages = <XFile>[].obs;
  var videoFileName = ''.obs;

  dynamic imageFile;
  dynamic imageVideo;

  Future<void> doSafeFetchProfile() async {
    try {
      final signUpResponse = await _authRepository.getProfile();
      phoneController.text = signUpResponse!.data!.phone!;
      alternatePhoneController.text = signUpResponse.data!.alt_phone!;
      nameController.text = signUpResponse.data!.name!;
      emailController.text = signUpResponse.data!.email!;
      buildingController.text = signUpResponse.data!.building!;
      areaController.text = signUpResponse.data!.area!;
      pinCodeController.text = signUpResponse.data!.pincode!;
      cityController.text = signUpResponse.data!.city!;
      stateController.text = signUpResponse.data!.state!;
      isLoading(false);
      Fluttertoast.showToast(msg: signUpResponse.message!);
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

  Future<void> getCarBrands() async {
    carBrandList.clear();
    isLoading(true);
    try {
      final carBrandResponse = await _carRepository.getCarBrand();
      carBrandList.addAll(carBrandResponse!.data!);
      doFetchAdList();
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

  Future<void> doFetchAdList() async {
    _adItems.clear();
    // isLoading(true);
    try {
      final adResponse = await _carRepository.getAdList();
      isLoading(false);
      _adItems.addAll(adResponse!.data!);
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

  Future<void> getCarById(String id) async {
    carByIdList.clear();
    isLoading(true);
    try {
      final carBrandResponse = await _carRepository.getCarById(id);
      carByIdList.addAll(carBrandResponse!.data!);
      doFetchAdList();
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

  Future<void> getPhoto(menuOptions options, bool isPhoto, context) async {
    final dynamic pickedFile = isPhoto
        ? await MediaService().uploadImage(context, options)
        : await MediaService().uploadVideo(context, options);
    if (pickedFile == null) return;
    if (isPhoto) {
      imageFileImages.addAll(pickedFile);
    } else {
      getVideoThumnail(pickedFile);
    }
  }

  Future<void> getProfileData() async {
    // carByIdList.clear();
    isLoading(true);
    try {
      isLoading(false);
      // carByIdList.addAll(carBrandResponse!.data!);
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

  Future<void> getVideoThumnail(dynamic videoPath) async {
    imageVideo = (await VideoThumbnail.thumbnailFile(
        video: videoPath.path,
        imageFormat: ImageFormat.JPEG,
        timeMs: 1,
        quality: 100))!;

    videoFileName.value = imageVideo;
  }

  void checkSignUpValidation() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should not be empty!");
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "phone should not be empty or less than 10 digit");
      return;
    } else if (buildingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "building should not be empty!");
      return;
    } else if (areaController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area should not be empty!");
      return;
    } else if (imageFileImages.isEmpty) {
      Fluttertoast.showToast(msg: "Image should not be empty!");
      return;
    } else {
      createAndUploadFile();
    }
  }

  Future<dynamic> createAndUploadFile() async {
    isLoading(true);
    try {
      final http.MultipartRequest request = http.MultipartRequest(
          'POST', Uri.parse(APIEndpoint.baseApi + '/booking'));
      for (int i = 0; i < imageFileImages.length; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'media[]', File(imageFileImages[i].path).path));
      }
      // imageFileImages.map((element) async {
      //   // final http.MultipartFile imageFIle = await http.MultipartFile.fromPath(
      //   //     'media', File(element.path).path);
      //   // request.files.add(imageFIle);
      // });

      if (videoFileName.value != '') {
        final http.MultipartFile videoFIle = await http.MultipartFile.fromPath(
            'media1', File(imageVideo.path).path);
        request.files.add(videoFIle);
      }
      final Map<String, String> headers = {
        'token': '${SharedPreference().getString(AppConstants().authToken)}',
        'Content-type': 'multipart/form-data'
      };
      request.headers.addAll(headers);
      request.fields.addAll({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'building': buildingController.text,
        'area': areaController.text,
        'city': cityController.text,
        'state': stateController.text,
        'alt_phone': alternatePhoneController.text,
        'pincode': pinCodeController.text,
        'sdescr': shortDescController.text,
        'company': companyDescController.text,
        'model': modelDescController.text,
        'year': yearDescController.text,
        'type': fuelTypeController.text
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
      Get.off(() => ChatScreen(
            orderNumber: result["data"]['orderId'],
            orderStatus: result['data']['status'],
          ));
      isLoading(false);
      return result;
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}
