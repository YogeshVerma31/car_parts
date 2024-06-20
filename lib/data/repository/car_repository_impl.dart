import 'dart:math';

import 'package:car_parts/data/model/ad_model.dart';
import 'package:car_parts/data/model/car_brand_model.dart';
import 'package:car_parts/data/model/car_model.dart';
import 'package:car_parts/data/repository/car_repository.dart';
import 'package:car_parts/providers/network/apis/car_api.dart';

class CarRepositoryImpl extends CarRepository {
  @override
  Future<CarBrandModel>? getCarBrand() async {
    final response =
        await CarApi(isAdList: false, isplaceOrder: false).request();
    return CarBrandModel.fromJson(response);
  }

  @override
  Future<CarModel>? getCarById(String id) async {
    final response =
        await CarApi(isAdList: false, id: id, isplaceOrder: false).request();
    return CarModel.fromJson(response);
  }

  @override
  Future<AdModel>? getAdList() async {
    final response =
        await CarApi(isAdList: true, isplaceOrder: false).request();
    return AdModel.fromJson(response);
  }

  @override
  Future? placeOrder(
      String name,
      String phone,
      String email,
      String building,
      String area,
      String pincode,
      String city,
      String state,
      String desc,
      dynamic image,
      dynamic video,
      String company,
      String model,
      String year) async {
    final response = await CarApi(
            isplaceOrder: true,
            name: name,
            phone: phone,
            email: email,
            building: building,
            area: area,
            pincode: pincode,
            city: city,
            state: state,
            desc: desc,
            image: image,
            video: video,
            company: company,
            model: model,
            year: year,
            isAdList: false)
        .request();
    return response;
  }
}
