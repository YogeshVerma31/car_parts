import 'package:car_parts/common_ui/custom_button.dart';
import 'package:car_parts/common_ui/custom_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/authentication_controller.dart';
import '../routes/app_routes_constant.dart';
import '../utils/color.dart';
import '../utils/styles.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  AuthController authController = Get.find();

  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title:Text('SignUp')),
      body: SafeArea(
          child: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Sign Up",
                          style: headingStyle.copyWith(color: Colors.blue)),
                      Text(
                        "",
                        style: subtitleStyle.copyWith(color: Colors.black),
                      )
                    ],
                  )),
              signUpForm
            ],
          ),
        ),
      )),
    );
  }

  Widget get signUpForm => Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.nameController,
                  title: "Name",
                  hint: "Enter Name Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.emailController,
                  title: "Email",
                  hint: "Enter Email Address",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                  controller: authController.phoneController,
                  textInputType: TextInputType.phone,
                  title: "Phone Number",
                  hint: "Enter Phone Number",
                  readOnly: false),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                widget: Image.asset('images/whatsapp.png',color: Colors.green,width:30,),
                  controller: authController.alternatePhoneController,
                  title: "Alternate Number",
                  hint: "Enter Alternate Number",
                  textInputType: TextInputType.phone,
                  readOnly: false),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                title: 'Password',
                hint: 'Enter your password',
                readOnly: false,
                controller: authController.passwordController,
                obscureText: authController.isPasswordVisible.value,
                widget: IconButton(
                  color: greyColor,
                  icon: authController.isPasswordVisible.isTrue
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                  onPressed: () => authController.isPasswordVisible.value =
                      !authController.isPasswordVisible.value,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: CustomInputField(
                title: 'Confirm Password',
                hint: 'Enter your Confirm password',
                readOnly: false,
                controller: authController.confirmPasswordController,
                obscureText: authController.isPasswordVisible.value,
                widget: IconButton(
                  color: greyColor,
                  icon: authController.isPasswordVisible.isTrue
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.remove_red_eye),
                  onPressed: () => authController.isPasswordVisible.value =
                      !authController.isPasswordVisible.value,
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0, right: 10),
            //   child: CustomInputField(
            //       controller: authController.buildingController,
            //       title: "Building",
            //       hint: "Enter Building Number",
            //       readOnly: false),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0, right: 10),
            //   child: CustomInputField(
            //       controller: authController.areaController,
            //       title: "Area",
            //       hint: "Enter Area Number",
            //       readOnly: false),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0, right: 10),
            //   child: CustomInputField(
            //       controller: authController.pinCodeController,
            //       title: "Pincode",
            //       hint: "Enter Pincode Number",
            //       readOnly: false),
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 10.0, right: 10),
            //   child: CustomInputField(
            //       controller: authController.cityController,
            //       title: "City",
            //       hint: "Enter City",
            //       readOnly: false),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, right: 10),
            //   child: CustomInputField(
            //       controller: authController.stateController,
            //       title: "State",
            //       hint: "Enter State",
            //       readOnly: false),
            // ),
            SizedBox(height: 10,),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CustomButton(
                    isProgressBar: authController.isLoading.value,
                    label: 'SignUp',
                    onTap: () {
                      authController.checkSignUpValidation();
                    },
                    color: Colors.blue)),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Registered?",
                  style: subtitleStyle.copyWith(color: textColorGrey),
                ),
                GestureDetector(
                    onTap: () {
                      Get.offNamed(RouteConstant.SIGINROUTE);
                    },
                    child: Text(
                      " Sign In",
                      style: subtitleStyle.copyWith(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    )),
              ],
            ),
          ],
        ),
      );
}
