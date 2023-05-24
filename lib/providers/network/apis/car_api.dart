import 'dart:io';

import 'package:get/get.dart';

import '../api_endpoint.dart';
import '../api_provider.dart';
import '../api_request_reprensentable.dart';

class CarApi extends APIRequestRepresentable {
  bool isplaceOrder;
  String? id;
  String? name;
  String? phone;

  String? email;
  String? building;

  String? area;
  String? pincode;

  String? city;
  String? state;

  String? desc;
  dynamic image;

  dynamic video;
  String? company;

  String? model;
  String? year;

  CarApi(
      {required this.isplaceOrder,
      this.id,
      this.name,
      this.phone,
      this.email,
      this.building,
      this.area,
      this.pincode,
      this.city,
      this.state,
      this.desc,
      this.image,
      this.video,
      this.company,
      this.model,
      this.year});

  @override
  get body => isplaceOrder
      ? {
          'name': name,
          'phone': phone,
          'email': email,
          'building': building,
          'area': area,
          'city': city,
          'state': state,
          'pincode': pincode,
          'sdescr': desc,
          'media': MultipartFile(File(image.path).readAsBytes(), filename: 'carImage'),
          'media1': MultipartFile(File(video.path).readAsBytes(), filename: 'carImage'),
          'company': company,
          'model': model,
          'year': year,
        }
      : null;

  @override
  String get endpoint {
    return id == null ? APIEndpoint.carBrandApi : APIEndpoint.carByIdApi + id!;
  }

  @override
  Map<String, String>? get headers {}

  @override
  HTTPMethod get method {
    return isplaceOrder ? HTTPMethod.post : HTTPMethod.get;
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
  String get url => isplaceOrder == true
      ? '${APIEndpoint.baseApi}booking'
      : APIEndpoint.baseApi + endpoint;

  @override
  String get contentType => isplaceOrder ? "multipart/form-data" : '';
}
