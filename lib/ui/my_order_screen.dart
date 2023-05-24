import 'package:car_parts/controller/order_controller.dart';
import 'package:car_parts/ui/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../common_ui/custom_button.dart';
import '../providers/network/api_endpoint.dart';
import '../utils/styles.dart';

class MyOrderscreen extends StatelessWidget {
  MyOrderscreen({Key? key}) : super(key: key);
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    orderController.getMyOrder();
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
                child: ListView.builder(
                    itemCount: orderController.myOrders.length,
                    itemBuilder: (context, position) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              imagesList(orderController.myOrders[position].media!),
                              Row(
                                children: [
                                  Text(
                                    'Order Id: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(orderController.myOrders[position].id!),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Company: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    orderController.myOrders[position].company!,
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Model: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    orderController.myOrders[position].model!,
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Year: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    orderController.myOrders[position].year!,
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Order Date: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat('yyyy-MM-dd').format(
                                        DateTime.parse(orderController
                                            .myOrders[position].added_on!)),
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Order Status: -',
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    orderController.getOrderStatus(
                                        orderController
                                            .myOrders[position].status!)!,
                                    style: titleStyle,
                                  ),
                                ],
                              ),
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: CustomButton(
                                      label: 'Chat with Admin',
                                      onTap: () {
                                        Get.to(() => ChatScreen(
                                            orderNumber: orderController
                                                .myOrders[position].id!));
                                      },
                                      color: Colors.blue))
                            ],
                          ),
                        ),
                      );
                    }),
              ))
        ],
      ),
    );
  }

  Widget imagesList(List<String> images) {
    return Wrap(
        children: images.map(
              (e) => ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    APIEndpoint.baseImageApi + e,
                    height: 200,
                  ),
                ),
              ),
            ).toList());
  }
}
