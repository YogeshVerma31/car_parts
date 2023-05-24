class APIEndpoint {
  //base Api end point
  static String get baseApi => "https://mdayurvediccollege.in/demo/autopart/api/";
  static String get baseImageApi => "https://mdayurvediccollege.in/demo/autopart/";

  //auth Api end points
  static String get loginApi => "authentication/verify";

  static String get signUpApi => "authentication/registration";
  static String get myProfileApi => "user";

  static String get carBrandApi => "car";
  static String get carByIdApi => "models/bycarid/";

  static String get changePasswordApi => "/auth/password/change";

  //Sort Api
  static String get locationListApi => "/location/list/";


}
