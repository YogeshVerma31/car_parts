import 'package:car_parts/controller/car_controller.dart';
import 'package:car_parts/data/sharedPreference/shared_preference.dart';
import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/ui/car_by_brand.dart';
import 'package:car_parts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/network/api_endpoint.dart';
import '../utils/color.dart';

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
      backgroundColor: primaryLightColor,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          // Status bar color
          statusBarColor: primaryColor, // Status bar brightness (optional)
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text(
          "Vehicle Type",
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250,
              child: Stack(
                children: [
                  Image.asset(
                    'images/drawer_bg1.jpg',
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.only(top: 70, left: 10),
                          child: Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                          child: Text(
                            SharedPreference().getString('name'),
                            style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                          child: Text(
                            SharedPreference().getString('email'),
                            style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                          child: Text(
                            SharedPreference().getString('number'),
                            style: headingStyle.copyWith(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: primaryLightColor,
                splashColor: primaryLightColor,
                leading: const Icon(
                  Icons.contact_emergency,
                ),
                title: Text(
                  "My Profile",
                  style: headingStyle.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(RouteConstant.myProfile);
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  //set border radius more than 50% of height and width to make circle
                ),
                tileColor: primaryLightColor,
                leading: Icon(Icons.book),
                title: Text("My Orders",
                    style: headingStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed(RouteConstant.myOrder);
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  //set border radius more than 50% of height and width to make circle
                ),
                tileColor: primaryLightColor,
                leading: Icon(Icons.privacy_tip_outlined),
                title: Text("Privacy Policy",
                    style: headingStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  // Navigator.pop(context);
                  _launchUrl();
                },
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  //set border radius more than 50% of height and width to make circle
                ),
                tileColor: primaryLightColor,
                leading: const Icon(Icons.logout),
                title: Text("Logout",
                    style: headingStyle.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  SharedPreference().remove();
                  Get.offAllNamed(RouteConstant.SIGINROUTE);
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: carController.isLoading.value == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView(
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
                              itemCount: carController.carBrandList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5.0,
                                      mainAxisSpacing: 4.0),
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      //set border radius more than 50% of height and width to make circle
                                    ),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              APIEndpoint.baseImageApi +
                                                  carController
                                                      .carBrandList[index].icon
                                                      .toString(),
                                              width: 100,
                                              height: 100,
                                            ),
                                            Center(
                                                child: Text(
                                              carController
                                                  .carBrandList[index].name!,
                                              style: titleStyle.copyWith(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            )),
                                          ],
                                        )));
                              },
                            ),
                          ],
                        ),
                ),
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
          controller: carController.pageController,
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(Uri.parse("https://spareman.in/privacy-policy"))) {
      throw Exception('Could not launch');
    }
  }
}
