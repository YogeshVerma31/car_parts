import 'package:car_parts/controller/authentication_controller.dart';
import 'package:car_parts/controller/car_controller.dart';
import 'package:car_parts/controller/order_controller.dart';
import 'package:get/get.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CarController>(CarController());
    Get.put<OrderController>(OrderController());
  }
}
