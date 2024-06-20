import 'dart:io';
import 'dart:math';

import 'package:car_parts/constants/app_constants.dart';
import 'package:car_parts/data/sharedPreference/shared_preference.dart';
import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';

enum chatType { GET, POST }

class ChatApi extends APIRequestRepresentable {
  String? id;
  String? message;
  chatType type;

  ChatApi({this.id, this.message, required this.type});

  @override
  get body {
    switch (type) {
      case chatType.GET:
        return null;
      case chatType.POST:
        return {'oid': id, 'messg': message};
    }
  }

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
    switch (type) {
      case chatType.GET:
        return HTTPMethod.get;
      case chatType.POST:
        return HTTPMethod.post;
    }
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
  String get url {
    switch (type) {
      case chatType.GET:
        return APIEndpoint.baseApi + "chat/$id";
      case chatType.POST:
        return APIEndpoint.baseApi+'chat';
    }
  }

  @override
  String get contentType => 'application/json';
}
