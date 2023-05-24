import 'package:car_parts/data/model/car_brand_model.dart';
import 'package:car_parts/data/model/car_model.dart';

abstract class CarRepository {
  Future<CarBrandModel>? getCarBrand();

  Future<CarModel>? getCarById(String id);

  Future<dynamic>? placeOrder(
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
      String year);
}
