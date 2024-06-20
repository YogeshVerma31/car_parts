import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/ui/place_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller/car_controller.dart';
import '../providers/network/api_endpoint.dart';
import '../utils/color.dart';
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
      carController.startCarBrandAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLightColor,
      appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: primaryColor,
            // Status bar brightness (optional)
            statusBarIconBrightness: Brightness.light,
            // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          backgroundColor: primaryColor,
          title: Text("Fuel Type")),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                carController.isLoading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.blue,
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        padding: const EdgeInsets.all(12.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Kishan Automobiles Pvt. Ltd.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Via Kashmere Gate",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                            _showAddSlider(),
                            GridView.builder(
                              padding: const EdgeInsets.all(10),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: carController.carByIdList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
                                    elevation: 1,
                                    child: InkWell(
                                        onTap: () =>
                                            Get.to(() => PlaceOrderScreen(
                                                  data: carController
                                                      .carByIdList[index],
                                                  compnay: widget.name,
                                                )),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'images/fuel_type.png',
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Center(
                                                child: Text(
                                              carController
                                                  .carByIdList[index].models!,
                                              style: titleStyle.copyWith(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            )),
                                          ],
                                        )));
                              },
                            ),
                          ],
                        )),
              ],
            )),
      ),
    );
  }

  _showAddSlider() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: PageView.builder(
          controller: carController.carBrandController,
          scrollDirection: Axis.horizontal,
          itemCount: carController.getAdList.length,
          itemBuilder: (context, index) {
            return Image.network(
              APIEndpoint.baseImageApi +
                  carController.getAdList[index].icon.toString(),
              height: 190,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
