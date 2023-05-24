import 'package:car_parts/data/model/my_order.dart';
import 'package:car_parts/data/repository/order_repository.dart';
import 'package:car_parts/providers/network/apis/order_api.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<MyOrderModel>? getOrdersBrand() async {
    final response = await OrderApi().request();
    return MyOrderModel.fromJson(response);
  }
}
