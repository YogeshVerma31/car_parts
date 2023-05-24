import 'package:car_parts/data/model/my_order.dart';

abstract class OrderRepository {
  Future<MyOrderModel>? getOrdersBrand();
}
