class APIEndpoint {
  //base Api end point
  static String get baseApi => "https://spareman.in/api/";
  // static String get baseApi => "http://192.168.1.16/auto_parts/api/";
  static String get baseImageApi => "https://spareman.in/";
  // static String get baseImageApi => "http://192.168.1.16/auto_parts/";

  //auth Api end points
  static String get loginApi => "authentication/verify";

  static String get signUpApi => "authentication/registration";
  static String get forgetApi => "authentication/forget";
  static String get changePasswordApi => "authentication/updatepass";
  static String get myProfileApi => "user";

  static String get carBrandApi => "car";
  static String get carByIdApi => "models/bycarid/";

  // static String get changePasswordApi => "/auth/password/change";
  static String get paymentSuccess => "booking/paymentSuccess";

  //Sort Api
  static String get locationListApi => "/location/list/";


}
