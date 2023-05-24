import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/ui/place_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_controller.dart';
import '../utils/styles.dart';

class CarsByBrand extends StatefulWidget {
  String id;
  String name;

  CarsByBrand({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<CarsByBrand> createState() => _CarsByBrandState();
}

class _CarsByBrandState extends State<CarsByBrand> {
  CarController carController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      carController.getCarById(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cars Models")),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "Cars Models",
                //     style: titleStyle.copyWith(fontSize: 25),
                //   ),
                // ),
                Obx(() => carController.isLoading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.blue,
                      )
                    : Expanded(
                        child: GridView.builder(
                        itemCount: carController.carByIdList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 3.5,
                              child: InkWell(
                                  onTap: () => Get.to(() => PlaceOrderScreen(
                                        data: carController.carByIdList[index],
                                        compnay: widget.name,
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        carController
                                            .carByIdList[index].models!,
                                        style: titleStyle.copyWith(
                                            fontSize: 20, color: Colors.black),
                                      )),
                                    ],
                                  )));
                        },
                      ))),
              ],
            )),
      ),
    );
  }
}
