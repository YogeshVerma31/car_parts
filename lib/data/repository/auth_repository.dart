import '../model/login_model.dart';

abstract class AuthRepository {
  Future<LoginModel>? signIn(String email, String password);

  Future<LoginModel>? signUp(
      String phoneNumber,
      String name,
      String email,
      String password, String alternateNumber);

  Future<LoginModel>? updateProfile(
      String phoneNumber,
      String name,
      String email,
      String building,
      String area,
      String pincode,
      String city,
      String state,String alternateNumber);

  Future<LoginModel>? getProfile();

  Future<String>? forgetPassword(String email);
  Future<String>? changePassword(String phone,String otp,String password);


}
