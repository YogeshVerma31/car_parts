import '../../../constants/app_constants.dart';
import '../../../data/sharedPreference/shared_preference.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';

enum AuthType {
  login,
  signUp,
  myProfile,
  updateProfile,
  forgetPassword,
  changePassword
}

class AuthApi extends APIRequestRepresentable {
  final AuthType authType;
  String? name;
  String? email;
  String? phoneNumber;
  String? otp;
  String? password;
  String? building;
  String? area;
  String? pincode;
  String? city;
  String? state;
  String? alternateNumber;

  AuthApi(
      {required this.authType,
      this.name,
      this.phoneNumber,
      this.email,
      this.password,
      this.otp,
      this.building,
      this.area,
      this.alternateNumber,
      this.pincode,
      this.city,
      this.state});

  @override
  get body {
    switch (authType) {
      case AuthType.login:
        return {"phone": phoneNumber, "password": password};
      case AuthType.signUp:
        return {
          "name": name,
          "email": email,
          "phone": phoneNumber,
          "password": password,
          "cpassword": password,
          "alt_phone": alternateNumber
        };
      case AuthType.myProfile:
        return '';
      case AuthType.updateProfile:
        return {
          "name": name,
          "email": email,
          "phone": phoneNumber,
          "alt_phone": alternateNumber
        };
      case AuthType.forgetPassword:
        return {
          "phone": phoneNumber,
        };
      case AuthType.changePassword:
        print({
          "phone": phoneNumber,
          "otp": otp,
          "password": password,
        });
        return {
          "phone": phoneNumber,
          "otp": otp,
          "password": password,
        };
    }
  }

  @override
  String get endpoint => APIEndpoint.loginApi;

  @override
  Map<String, String>? get headers {
    switch (authType) {
      case AuthType.login:
        return {'Content-Type': 'application/json'};
      case AuthType.signUp:
        return {'Content-Type': 'application/json'};
      case AuthType.myProfile:
        return {
          'token':
              SharedPreference().getString(AppConstants().authToken).toString()
        };
      case AuthType.updateProfile:
        return {
          'token':
              SharedPreference().getString(AppConstants().authToken).toString()
        };
      case AuthType.forgetPassword:
        return {'Content-Type': 'application/json'};
        break;
      case AuthType.changePassword:
        return {'Content-Type': 'application/json'};
    }
  }

  @override
  HTTPMethod get method {
    switch (authType) {
      case AuthType.login:
        return HTTPMethod.post;
      case AuthType.signUp:
        return HTTPMethod.post;
      case AuthType.myProfile:
        return HTTPMethod.get;
      case AuthType.updateProfile:
        return HTTPMethod.post;
      case AuthType.forgetPassword:
        return HTTPMethod.post;
      case AuthType.changePassword:
        return HTTPMethod.post;
    }
  }

  @override
  String get path {
    switch (authType) {
      case AuthType.login:
        return APIEndpoint.loginApi;
      case AuthType.signUp:
        return APIEndpoint.signUpApi;
      case AuthType.myProfile:
        return APIEndpoint.myProfileApi;
      case AuthType.updateProfile:
        return APIEndpoint.myProfileApi;
      case AuthType.forgetPassword:
        return APIEndpoint.forgetApi;
      case AuthType.changePassword:
        return APIEndpoint.changePasswordApi;
    }
  }

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => APIEndpoint.baseApi + path;

  @override
  String get contentType => throw UnimplementedError();
}
