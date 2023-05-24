import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../data/repository/auth_repository_impl.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_provider.dart';
import '../routes/app_routes_constant.dart';

class AuthController extends GetxController {
  var isPasswordVisible = false.obs;
  var isEditable = false.obs;
  final phoneController = TextEditingController();
  final alternatePhoneController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final buildingController = TextEditingController();
  final pinCodeController = TextEditingController();
  final areaController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();

  final _authRepository = AuthRepositoryImpl();
  var isLoading = false.obs;
  var isButtonLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void checkValidation() {
    if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number should not be empty!");
      return;
    } else if (phoneController.text.length < 10) {
      Fluttertoast.showToast(
          msg: "Phone Number should not be less than 10 digit!");
      return;
    } else if (passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password should not be empty!");
      return;
    } else {
      doSafeLogin();
    }
  }

  // void checkResetValidation() {
  //   if (oldPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "Old Password should not be empty!");
  //     return;
  //   } else if (newPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "New Password should not be empty!");
  //     return;
  //   } else if (confirmPasswordController.text.isEmpty) {
  //     Fluttertoast.showToast(msg: "Confirm Password should not be empty!");
  //     return;
  //   } else if (confirmPasswordController.text != newPasswordController.text) {
  //     Fluttertoast.showToast(msg: "Confirm Password Not Matched!");
  //     return;
  //   } else {}
  // }
  //
  void checkSignUpValidation() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should not be empty!");
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "phone should not be empty or less than 10 digit");
      return;
    }else if (alternatePhoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "alternate number should not be empty or less than 10 digit");
      return;
    }
    else if (passwordController.text.isEmail) {
      Fluttertoast.showToast(msg: "password is Not valid!");
      return;
    } else if (confirmPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Confirm Password should not be empty!");
      return;
    } else if (!(passwordController.text == confirmPasswordController.text)) {
      Fluttertoast.showToast(msg: "password not match");
      return;
    } else if (buildingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "building should not be empty!");
      return;
    } else if (areaController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area should not be empty!");
      return;
    } else if (pinCodeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area should not be empty!");
      return;
    } else if (pinCodeController.text.length < 6) {
      Fluttertoast.showToast(msg: "Pincode should not be less than 6");
      return;
    } else if (cityController.text.isEmpty) {
      Fluttertoast.showToast(msg: "City should not be empty!");
      return;
    } else if (stateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "State̵ should not be empty!");
      return;
    } else {
      doSafeSignUp();
    }
  }

  void checkSignUpdateValidation() {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should not be empty!");
    } else if (phoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "phone should not be empty or less than 10 digit");
      return;
    } else if (alternatePhoneController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "alternate number should not be empty or less than 10 digit");
      return;
    }else if (buildingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "building should not be empty!");
      return;
    } else if (areaController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area should not be empty!");
      return;
    } else if (pinCodeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Area should not be empty!");
      return;
    } else if (pinCodeController.text.length < 6) {
      Fluttertoast.showToast(msg: "Pincode should not be less than 6");
      return;
    } else if (cityController.text.isEmpty) {
      Fluttertoast.showToast(msg: "City should not be empty!");
      return;
    } else if (stateController.text.isEmpty) {
      Fluttertoast.showToast(msg: "State̵ should not be empty!");
      return;
    } else {
      doSafeUpdateProfile();
    }
  }


  Future<void> doSafeLogin() async {
    isLoading(true);
    try {
      final loginResponse = await _authRepository.signIn(
          phoneController.text, passwordController.text);
      isLoading(false);
      putToken(loginResponse!.data!.token!);
      Get.offAllNamed(RouteConstant.HOMEROUTE);
      SharedPreference().putString("email", loginResponse.data!.email!);
      SharedPreference().putString("name", loginResponse.data!.name!);
      Fluttertoast.showToast(msg: loginResponse.message!);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.message.toString());
    }
  }

  void putToken(String authToken) {
    SharedPreference().putString(AppConstants().authToken, authToken);
  }

  Future<void> doSafeSignUp() async {
    isLoading(true);
    try {
      final signUpResponse = await _authRepository.signUp(
        phoneController.text,
        nameController.text,
        emailController.text,
        passwordController.text,
        buildingController.text,
        areaController.text,
        pinCodeController.text,
        cityController.text,
        stateController.text,
        alternatePhoneController.text
      );
      isLoading(false);
      putToken(signUpResponse!.data!.token!);
      SharedPreference().putString("email", signUpResponse.data!.email!);
      SharedPreference().putString("name", signUpResponse.data!.name!);
      Fluttertoast.showToast(msg: signUpResponse.message!);
      Get.offAllNamed(RouteConstant.HOMEROUTE);
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

  Future<void> doSafeFetchProfile() async {
    isLoading(true);
    try {
      final signUpResponse = await _authRepository.getProfile();
      phoneController.text = signUpResponse!.data!.phone!;
      nameController.text = signUpResponse.data!.name!;
      emailController.text = signUpResponse.data!.email!;
      buildingController.text = signUpResponse.data!.building!;
      areaController.text = signUpResponse.data!.area!;
      pinCodeController.text = signUpResponse.data!.pincode!;
      cityController.text = signUpResponse.data!.city!;
      stateController.text = signUpResponse.data!.state!;
      alternatePhoneController.text = signUpResponse.data!.alt_phone!;
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
  Future<void> doSafeUpdateProfile() async {
    isButtonLoading(true);
    try {
      final signUpResponse = await _authRepository.updateProfile(
        phoneController.text,
        nameController.text,
        emailController.text,
        buildingController.text,
        areaController.text,
        pinCodeController.text,
        cityController.text,
        stateController.text,
        alternatePhoneController.text
      );
      isButtonLoading(false);
      Fluttertoast.showToast(msg: "Profile Updated Successfully");
    } on FetchDataException catch (exception) {
      isButtonLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isButtonLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isButtonLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    }
  }




// Future<void> initiateFacebookLogin() async {
//   final loginResult = await FacebookAuth.instance.login();
//
//   if (loginResult.status == LoginStatus.success) {
//     print(loginResult.accessToken);
//     final userInfo = await FacebookAuth.instance.getUserData();
//     print(userInfo.toString());
//   } else {
//     print('ResultStatus: ${loginResult.status}');
//     print('Message: ${loginResult.message}');
//   }
// }
//
// Future<void> doForgetPassword() async {
//   isLoading(true);
//   try {
//     final signUpResponse =
//     await _authRepository.forgetPassword(emailController.text);
//     isLoading(false);
//     Fluttertoast.showToast(msg: signUpResponse.message!);
//   } on FetchDataException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on BadRequestException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on UnauthorisedException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   }
// }
//
// Future<void> doResetPassword() async {
//   isLoading(true);
//   try {
//     final signUpResponse =
//     await _authRepository.forgetPassword(emailController.text);
//     isLoading(false);
//     Fluttertoast.showToast(msg: signUpResponse.message!);
//   } on FetchDataException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on BadRequestException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   } on UnauthorisedException catch (exception) {
//     isLoading(false);
//     Fluttertoast.showToast(msg: exception.details.toString());
//   }
// }
}
