import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_ui/custom_button.dart';
import '../common_ui/custom_input_field.dart';
import '../controller/authentication_controller.dart';

class MyProfile extends StatefulWidget {
  MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  AuthController authController = Get.find();

  @override
  void initState() {
    authController.doSafeFetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        child: Obx(() => authController.isLoading.value == true
            ? const CircularProgressIndicator(
                backgroundColor: Colors.transparent,
                color: Colors.blue,
              )
            : Container(
                margin: const EdgeInsets.only(top: 10), child: signUpForm)),
      ),
    );
  }

  Widget get signUpForm => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: CustomInputField(
                controller: authController.nameController,
                title: "Name",
                hint: "Enter Name Number",
                readOnly: false),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: CustomInputField(
                controller: authController.emailController,
                title: "Email",
                hint: "Enter Email Address",
                readOnly: false),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: CustomInputField(
                controller: authController.phoneController,
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
                controller: authController.alternatePhoneController,
                title: "Alternate Number",
                hint: "Enter Alternate Number",
                textInputType: TextInputType.phone,
                readOnly: false),
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomButton(
                  isProgressBar: authController.isButtonLoading.value,
                  label: 'Update Profile',
                  onTap: () {
                    authController.checkSignUpdateValidation();
                  },
                  color: Colors.blue)),
        ],
      );
}
