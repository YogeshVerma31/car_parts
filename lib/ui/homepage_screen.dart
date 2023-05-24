import 'package:car_parts/controller/car_controller.dart';
import 'package:car_parts/data/sharedPreference/shared_preference.dart';
import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/ui/car_by_brand.dart';
import 'package:car_parts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../providers/network/api_endpoint.dart';

class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  CarController carController = Get.find();

  @override
  void initState() {
    carController.getCarBrands();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cars Company",
        ),
      ),
      drawer:  Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(SharedPreference().getString('name')),
              accountEmail: Text(SharedPreference().getString('email')),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text(
                  SharedPreference().getString('name').toString().substring(0,1),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.contact_emergency), title: Text("My Profile"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(RouteConstant.myProfile);
              },
            ),
            ListTile(
              leading: Icon(Icons.book), title: Text("My Orders"),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed(RouteConstant.myOrder);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout), title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
                SharedPreference().remove();
                Get.offAllNamed(RouteConstant.SIGINROUTE);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Obx(() => carController.isLoading.value
                    ? const CircularProgressIndicator(
                        backgroundColor: Colors.transparent,
                        color: Colors.blue,
                      )
                    : Expanded(
                        child: GridView.builder(
                        itemCount: carController.carBrandList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              elevation: 3.5,
                              child: InkWell(
                                  onTap: () {
                                    Get.to(() => CarsByBrand(
                                          id: carController
                                              .carBrandList[index].id!,
                                          name: carController
                                              .carBrandList[index].name!,
                                        ));
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        APIEndpoint.baseImageApi +
                                            carController
                                                .carBrandList[index].icon
                                                .toString(),
                                        width: 50,
                                        height: 50,
                                      ),
                                      Center(
                                          child: Text(
                                        carController.carBrandList[index].name!,
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
