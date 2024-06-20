import 'package:car_parts/controller/chat_controller.dart';
import 'package:car_parts/controller/order_controller.dart';
import 'package:car_parts/data/model/my_order.dart';
import 'package:car_parts/ui/chat_screen.dart';
import 'package:car_parts/ui/post_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../data/sharedPreference/shared_preference.dart';
import '../providers/network/api_endpoint.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class MyOrderscreen extends StatefulWidget {
  MyOrderscreen({Key? key}) : super(key: key);

  @override
  State<MyOrderscreen> createState() => _MyOrderscreenState();
}

class _MyOrderscreenState extends State<MyOrderscreen> {
  OrderController orderController = Get.find();
  ChatController chatController = Get.put(ChatController());
  String currentUserId = '';
  String userName = '';
  String userEmail = '';
  String userNumber = '';

  @override
  void initState() {
    currentUserId = SharedPreference().getString('authToken');
    userName = SharedPreference().getString('name');
    userEmail = SharedPreference().getString('email');
    userNumber = SharedPreference().getString('number');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    orderController.getMyOrder();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Orders'),
      ),
      body: Column(
        children: [
          Obx(() => Expanded(
                child: orderController.isLoading.value == false
                    ? orderController.myOrders.isEmpty
                        ? const Center(child: Text("No Orders"))
                        : ListView.builder(
                            itemCount: orderController.myOrders.length,
                            itemBuilder: (context, position) {
                              // return Card(
                              //   child: Padding(
                              //     padding: const EdgeInsets.all(8.0),
                              //     child: Column(
                              //       mainAxisAlignment: MainAxisAlignment.center,
                              //       crossAxisAlignment: CrossAxisAlignment.center,
                              //       children: [
                              //         imagesList(orderController
                              //             .myOrders[position].media!),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Order Id: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(orderController
                              //                 .myOrders[position].id!),
                              //           ],
                              //         ),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Company: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(
                              //               orderController
                              //                   .myOrders[position].company!,
                              //               style: titleStyle,
                              //             ),
                              //           ],
                              //         ),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Model: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(
                              //               orderController
                              //                   .myOrders[position].model!,
                              //               style: titleStyle,
                              //             ),
                              //           ],
                              //         ),
                              //         SizedBox(
                              //           height: 5,
                              //         ),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Year: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(
                              //               orderController
                              //                   .myOrders[position].year!,
                              //               style: titleStyle,
                              //             ),
                              //           ],
                              //         ),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Order Date: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(
                              //               DateFormat('yyyy-MM-dd').format(
                              //                   DateTime.parse(orderController
                              //                       .myOrders[position].added_on!)),
                              //               style: titleStyle,
                              //             ),
                              //           ],
                              //         ),
                              //         const SizedBox(
                              //           height: 5,
                              //         ),
                              //         Row(
                              //           children: [
                              //             Text(
                              //               'Order Status: -',
                              //               style: titleStyle.copyWith(
                              //                   fontWeight: FontWeight.w600),
                              //             ),
                              //             Text(
                              //               orderController.getOrderStatus(
                              //                   orderController
                              //                       .myOrders[position].status!)!,
                              //               style: titleStyle,
                              //             ),
                              //           ],
                              //         ),
                              //         Container(
                              //             margin: const EdgeInsets.symmetric(
                              //                 horizontal: 10, vertical: 10),
                              //             child: CustomButton(
                              //                 label: 'Chat with Admin',
                              //                 onTap: () {
                              //                   Get.to(() => ChatScreen(
                              //                         orderNumber: orderController
                              //                             .myOrders[position]
                              //                             .orderId!,
                              //                         orderStatus: orderController
                              //                             .myOrders[position]
                              //                             .status,
                              //                       ));
                              //                 },
                              //                 color: Colors.blue)),
                              //         orderController.myOrders[position].status ==
                              //                 '2'
                              //             ? Container(
                              //                 margin: const EdgeInsets.symmetric(
                              //                     horizontal: 10, vertical: 5),
                              //                 child: CustomButton(
                              //                     label: 'Pay Now',
                              //                     onTap: () {
                              //                       orderController.generateOrders(
                              //                           orderController
                              //                               .myOrders[position]
                              //                               .orderId!,
                              //                           currentUserId,
                              //                           userName,
                              //                           userEmail,
                              //                           userNumber,
                              //                           double.parse(orderController
                              //                               .myOrders[position]
                              //                               .product_price!));
                              //                     },
                              //                     color: Colors.blue))
                              //             : SizedBox.shrink()
                              //       ],
                              //     ),
                              //   ),
                              // );
                              return _showOrdersItem(
                                  context, orderController.myOrders[position]);
                            })
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ))
        ],
      ),
    );
  }

  _showOrdersItem(BuildContext context, Data? orderData) {
    if (orderData != null) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(boxShadow: [
          const BoxShadow(
            color: greyColor100, offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 4.0,
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "images/order_icon.png",
                width: 70,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderData.name!,
                      style: subtitleStyle.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Id: ",
                          style: subtitleStyle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${orderData.id}",
                          style: subtitleStyle.copyWith(
                              color: primaryColor, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Text(
                          "Order Status: ",
                          style: subtitleStyle.copyWith(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "${orderController.getOrderStatus(orderData.status!)}",
                          style: subtitleStyle.copyWith(
                              color: orderController
                                  .getOrderColor(orderData.status!),
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      DateFormat.yMMMd()
                          .format(DateTime.parse(orderData.added_on!))
                          .toString(),
                      style: subtitleStyle.copyWith(
                          color: greyColor, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _showButtons(orderData)
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  _showButtons(Data orderModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          children: [
            InkWell(
              onTap: () => _showBottomBar(orderModel),
              child: Container(
                margin: const EdgeInsets.only(right: 5, bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: greyColor100, offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 1.0,
                      )
                    ],
                    border: Border.all(color: primaryLightColor, width: .7),
                    color: primaryLightColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "View Detail",
                  textAlign: TextAlign.center,
                  style: titleStyle.copyWith(
                      color: primaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            orderModel.status == '5'
                ? InkWell(
                    onTap: () => _showShippingOrderBottomBar(orderModel),
                    child: Container(
                      margin: const EdgeInsets.only(right: 5, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: greyColor100,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 1.0,
                            )
                          ],
                          border:
                              Border.all(color: primaryLightColor, width: .7),
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Shipping Details",
                        textAlign: TextAlign.center,
                        style: titleStyle.copyWith(
                            color: primaryColor,
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            InkWell(
              onTap: () => Get.to(() => ChatScreen(
                    orderNumber: orderModel.orderId,
                    orderStatus: orderModel.status,
                  )),
              child: Container(
                margin: const EdgeInsets.only(left: 5, bottom: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: greyColor100, offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 1.0,
                      )
                    ],
                    border: Border.all(color: lightGreenColor, width: .7),
                    color: lightGreenColor,
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "Start Chat",
                  textAlign: TextAlign.center,
                  style: titleStyle.copyWith(
                      color: greenColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
        orderModel.status == '2'
            ? InkWell(
                onTap: () {
                  orderController.generateOrders(
                      orderModel.orderId!,
                      currentUserId,
                      userName,
                      userEmail,
                      userNumber,
                      double.parse(orderModel.product_price!),
                      context);
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 5, bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black, offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 1.0,
                        )
                      ],
                      border: Border.all(color: Colors.black, width: .7),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Pay Now",
                    textAlign: TextAlign.center,
                    style: titleStyle.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  _showBottomBar(Data orderModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 8,
                width: 50,
                decoration: BoxDecoration(
                    color: greyColor100,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Order Details",
                style: headingStyle.copyWith(color: Colors.black),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Order Id- ${orderModel.id}",
                        style: titleStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Details ",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person, color: primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                orderModel.name!,
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                color: primaryColor,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(
                                        DateTime.parse(orderModel.added_on!))
                                    .toString(),
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Delivery Address ",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            orderModel.building!,
                            style: titleStyle.copyWith(
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: [
                          Text(
                            "Photos Uploaded ",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: orderModel.media!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoViewerScreen(
                                                imageUrl: APIEndpoint
                                                        .baseImageApi +
                                                    orderModel.media![index],
                                              ))),
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      APIEndpoint.baseImageApi +
                                          orderModel.media![index],
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: greyColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          width: 200,
                                          height: 200,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return Material(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.asset(
                                            'assets/images/img_not_available.jpeg',
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _showShippingOrderBottomBar(Data orderModel) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 8,
                width: 50,
                decoration: BoxDecoration(
                    color: greyColor100,
                    borderRadius: BorderRadius.circular(10)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Shipping Details",
                style: headingStyle.copyWith(color: Colors.black),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Shipping Id- ${orderModel.shippingid}",
                        style: titleStyle.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipping Company ",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.local_shipping_outlined,
                                  color: primaryColor),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                orderModel.shippingcompany!,
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryLightColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: [
                          Text(
                            "Shipping Slip ",
                            style: headingStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 120,
                            child: ListView.builder(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: orderModel.media!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhotoViewerScreen(
                                                imageUrl:
                                                    APIEndpoint.baseImageApi +
                                                        orderModel.shipimage!,
                                              ))),
                                  child: Container(
                                    width: 100,
                                    height: 80,
                                    margin: const EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.network(
                                      APIEndpoint.baseImageApi +
                                          orderModel.shipimage!,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: greyColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          width: 200,
                                          height: 200,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: primaryColor,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return Material(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Image.asset(
                                            'assets/images/img_not_available.jpeg',
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      },
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget imagesList(List<String> images) {
    return Wrap(
        children: images
            .map(
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
            )
            .toList());
  }
}
