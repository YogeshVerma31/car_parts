import 'package:car_parts/data/model/login_model.dart';
import 'package:car_parts/data/repository/auth_repository.dart';

import '../../providers/network/apis/login_api.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<LoginModel>? signIn(String email, String password) async {
    final response = await AuthApi(
            phoneNumber: email, password: password, authType: AuthType.login)
        .request();
    return LoginModel.fromJson(response);
  }

  @override
  Future<LoginModel>? signUp(String phoneNumber, String name, String email,
      String password, String alternateNumber) async {
    final response = await AuthApi(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            password: password,
            alternateNumber: alternateNumber,
            authType: AuthType.signUp)
        .request();
    return LoginModel.fromJson(response);
  }

  @override
  Future<LoginModel>? getProfile() async {
    final response = await AuthApi(authType: AuthType.myProfile).request();
    return LoginModel.fromJson(response);
  }

  @override
  Future<LoginModel>? updateProfile(
      String phoneNumber,
      String name,
      String email,
      String building,
      String area,
      String pincode,
      String city,
      String state,
      String alternateNumber) async {
    final response = await AuthApi(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            area: area,
            building: building,
            pincode: pincode,
            city: city,
            state: state,
            alternateNumber: alternateNumber,
            authType: AuthType.updateProfile)
        .request();
    return LoginModel.fromJson(response);
  }

  @override
  Future<String> forgetPassword(String email) async {
    final response =
        await AuthApi(phoneNumber: email, authType: AuthType.forgetPassword)
            .request();
    return response['message'];
  }

  @override
  Future<String>? changePassword(
      String phone, String otp, String password) async {
    final response = await AuthApi(
            phoneNumber: phone,
            otp: otp,
            password: password,
            authType: AuthType.changePassword)
        .request();
    return response['message'];
  }
}
