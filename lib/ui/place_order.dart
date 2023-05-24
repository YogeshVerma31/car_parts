import 'dart:io';
import 'package:car_parts/common_ui/custom_button.dart';
import 'package:car_parts/common_ui/custom_input_field.dart';
import 'package:car_parts/controller/car_controller.dart';
import 'package:car_parts/services/media_services_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/model/car_model.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class PlaceOrderScreen extends StatefulWidget {
  CarData? data;
  String compnay;

  PlaceOrderScreen({Key? key, this.data, required this.compnay})
      : super(key: key);

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  CarController carController = Get.find();

  @override
  void initState() {
    carController.companyDescController.text = widget.compnay;
    carController.modelDescController.text = widget.data!.models!;
    carController.imageFileName.clear();
    carController.videoFileName.value = '';
    carController.nameController.clear();
    carController.emailController.clear();
    carController.confirmPasswordController.clear();
    carController.buildingController.clear();
    carController.pinCodeController.clear();
    carController.areaController.clear();
    carController.cityController.clear();
    carController.stateController.clear();
    carController.shortDescController.clear();
    carController.imageDescController.clear();
    carController.videoDescController.clear();
    carController.yearDescController.clear();
    carController.doSafeFetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Orders'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [placeOrderForm],
          ),
        ),
      ),
    );
  }

  Widget get placeOrderForm => Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.nameController,
                  title: "Name",
                  hint: "Enter Name Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.phoneController,
                  title: "Phone Number",
                  hint: "Enter Phone Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  widget: Image.asset(
                    'images/whatsapp.png',
                    color: Colors.green,
                    width: 30,
                  ),
                  controller: carController.alternatePhoneController,
                  title: "Alternate Number",
                  hint: "Enter Alternate Number",
                  textInputType: TextInputType.phone,
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.emailController,
                  title: "Email",
                  hint: "Enter Email Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.buildingController,
                  title: "Building",
                  hint: "Enter Building Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.areaController,
                  title: "Area",
                  hint: "Enter Area Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.pinCodeController,
                  title: "Pincode",
                  hint: "Enter Pincode Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.cityController,
                  title: "City",
                  hint: "Enter City",
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.stateController,
                  title: "State",
                  hint: "Enter State",
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.shortDescController,
                  title: "Short Description",
                  hint: "Enter Short Description",
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Upload Image",
                      style: titleStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 200),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        carController.getPhoto(
                            menuOptions.gallery, true, context);
                      },
                      child: Obx(() => carController.imageFileImages.isEmpty
                          ? Center(
                              child: Text('Select Image',
                                  style: headingStyle.copyWith(
                                      color: Colors.black, fontSize: 16)),
                            )
                          : Wrap(
                              children: carController.imageFileImages
                                  .map((element) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.file(
                                          File(element.path),
                                          fit: BoxFit.fill,
                                          height: 200,
                                        ),
                                      )).toList())),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Upload Video",
                      style: titleStyle.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .5,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: borderColor, width: 1.0),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        carController.getPhoto(
                            menuOptions.gallery, false, context);
                      },
                      child: Row(
                        children: [
                          Expanded(
                              child: Obx(
                                  () => carController.videoFileName.value == ''
                                      ? Center(
                                          child: Text(
                                          'Select Video',
                                          style: headingStyle.copyWith(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ))
                                      : Image.file(
                                          File(carController.imageVideo),
                                          fit: BoxFit.contain,
                                        )))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.companyDescController,
                  title: "Company",
                  hint: "Company",
                  readOnly: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.modelDescController,
                  title: "Model",
                  hint: "Model",
                  readOnly: true),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.fuelTypeController,
                  title: "Car Fuel Type (Ex. Petrol, Diesel and CNG)",
                  hint: "Enter Car Fuel Type",
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: carController.yearDescController,
                  title: "Year or Car Purchase",
                  hint: "Enter Year or Car Purchase",
                  readOnly: false),
            ),
            Obx(() => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomButton(
                    isProgressBar: carController.isLoading.value,
                    label: 'Place Order',
                    onTap: () {
                      carController.checkSignUpValidation();
                    },
                    color: Colors.blue))),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
