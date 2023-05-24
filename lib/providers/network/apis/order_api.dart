import 'dart:io';
import 'dart:math';

import 'package:car_parts/constants/app_constants.dart';
import 'package:car_parts/data/sharedPreference/shared_preference.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';


class OrderApi extends APIRequestRepresentable {
  @override
  get body {}

  @override
  String get endpoint => APIEndpoint.loginApi;

  @override
  Map<String, String>? get headers {
    return {
      'token': SharedPreference().getString(AppConstants().authToken).toString()
    };
  }

  @override
  HTTPMethod get method {
    return HTTPMethod.get;
  }

  @override
  String get path => '';

  @override
  Map<String, String>? get query => null;

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => 'https://mdayurvediccollege.in/demo/autopart/api/booking';

  @override
  String get contentType => 'application/json';
}
