import 'package:car_parts/data/repository/order_repository_impl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../data/model/my_order.dart';
import '../providers/network/api_provider.dart';


class OrderController extends GetxController {

  var myOrders = [Data()].obs;
  var isLoading = true.obs;

  final _orderRepository = OrderRepositoryImpl();

  Future<void> getMyOrder() async {
    myOrders.clear();
    isLoading(true);
    try {
      final carBrandResponse = await _orderRepository.getOrdersBrand();
      isLoading(false);
      myOrders.addAll(carBrandResponse!.data!);
    } on FetchDataException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on BadRequestException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    } on UnauthorisedException catch (exception) {
      isLoading(false);
      Fluttertoast.showToast(msg: exception.details.toString());
    }
  }


  String? getOrderStatus(String orderStatus){
    switch(orderStatus){
      case '1':
        return 'Processing';
      case '2':
        return 'Approved';
      case '3':
        return 'Shipped';
      case '4':
        return 'Completed';
      case '5':
        return 'Cancelled';
    }
    return '';
  }
}
