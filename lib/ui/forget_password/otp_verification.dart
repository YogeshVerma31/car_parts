import 'package:car_parts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../common_ui/custom_button.dart';
import '../../common_ui/custom_input_field.dart';
import '../../controller/authentication_controller.dart';
import '../../utils/color.dart';

class OtpVerification extends StatefulWidget {
  OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  AuthController authController = Get.find();
  var _otpController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Otp Verification"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.asset(
            "images/otp.jpg",
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Please enter 6 digit code sent to ${Get.parameters['phone']}",
                textAlign: TextAlign.center,
                style: titleStyle.copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          OtpTextField(
            numberOfFields: 6,
            borderColor: primaryLightColor,
            filled: true,
            showFieldAsBox: true,
            fillColor: primaryLightColor,
            onCodeChanged: (String code) {
              _otpController.text = code;
              return;
            },
            onSubmit: (String verificationCode) {
              _otpController.text = verificationCode;
              print(verificationCode);
              return;
            }, // end onSubmit
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: CustomInputField(
              title: 'Password',
              hint: 'Enter Password',
              readOnly: false,
              textInputType: TextInputType.name,
              controller: _passwordController,
              obscureText: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: CustomInputField(
              title: 'Phone Number',
              hint: 'Confirm Password',
              readOnly: false,
              textInputType: TextInputType.name,
              controller: _confPasswordController,
              obscureText: false,
            ),
          ),
          Obx(
            () => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CustomButton(
                    isProgressBar: authController.isLoading.value,
                    label: 'Change Password',
                    onTap: () => validate(),
                    color: Colors.blue)),
          )
        ],
      ),
    );
  }

  void validate() {
    if (_otpController.text.isEmpty || _otpController.text.length < 6) {
      Fluttertoast.showToast(
          msg: "Otp should not empty or less than 6 digits!");
      return;
    } else if (_passwordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password field should not empty!");
      return;
    } else if (_confPasswordController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Confirm Password field should not empty!");
      return;
    } else if (_passwordController.text != _confPasswordController.text) {
      Fluttertoast.showToast(
          msg: "Password and Confirm Password field not matched!");
      return;
    } else {
      authController.doSafeChangePassword(Get.parameters['phone']!,
          _otpController.text, _passwordController.text);
    }
  }
}
