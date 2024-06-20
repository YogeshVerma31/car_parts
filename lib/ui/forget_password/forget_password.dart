import 'package:car_parts/ui/forget_password/otp_verification.dart';
import 'package:car_parts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_ui/custom_button.dart';
import '../../common_ui/custom_input_field.dart';
import '../../controller/authentication_controller.dart';
import '../../routes/app_routes_constant.dart';
import '../../utils/color.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  AuthController authController = Get.find();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Forget Password"),
        leading: const Icon(Icons.arrow_back),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Image.asset("images/forget_password.jpg"),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Enter your registered phone number below to receive otp.",
                textAlign: TextAlign.center,
                style: titleStyle.copyWith(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: CustomInputField(
              title: 'Phone Number',
              hint: 'Enter Phone Number',
              readOnly: false,
              textInputType: TextInputType.emailAddress,
              controller: emailController,
              obscureText: false,
            ),
          ),
          Obx(
            () => Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: CustomButton(
                    isProgressBar: authController.isLoading.value,
                    label: 'Send Otp',
                    onTap: () {
                      authController.doSafeSendPassword(emailController.text);
                    },
                    color: Colors.blue)),
          )
        ],
      ),
    );
  }
}
