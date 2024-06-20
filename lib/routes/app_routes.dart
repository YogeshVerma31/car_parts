import 'package:car_parts/bindings/auth_binding.dart';
import 'package:car_parts/bindings/car_binding.dart';
import 'package:car_parts/controller/splash_binding.dart';
import 'package:car_parts/ui/forget_password/forget_password.dart';
import 'package:car_parts/ui/forget_password/otp_verification.dart';
import 'package:car_parts/ui/homepage_screen.dart';
import 'package:car_parts/ui/login_screen.dart';
import 'package:car_parts/ui/my_order_screen.dart';
import 'package:car_parts/ui/my_profile.dart';
import 'package:car_parts/ui/place_order.dart';
import 'package:car_parts/ui/signup_screen.dart';
import 'package:car_parts/ui/splash_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import 'app_routes_constant.dart';

class Routes {
  static final routes = [
    GetPage(
        name: RouteConstant.SIGINROUTE,
        page: () => LoginScreen(),
        binding: AuthBinding()),
    GetPage(
        name: RouteConstant.SIGNUPROUTE,
        binding: AuthBinding(),
        page: () => SignUpScreen()),
    GetPage(
        name: RouteConstant.INITIALROUTE,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: RouteConstant.HOMEROUTE,
        binding: CarBinding(),
        page: () => HomePageScreen()),
    GetPage(
        name: RouteConstant.myOrder,
        binding: CarBinding(),
        page: () => MyOrderscreen()),

    GetPage(
        name: RouteConstant.myProfile,
        binding: AuthBinding(),
        page: () => MyProfile()),

    GetPage(
        name: RouteConstant.FORGETPASSWORDROUTE,
        binding: AuthBinding(),
        page: () => ForgetPassword()),
    GetPage(
        name: RouteConstant.otpVerification,
        binding: AuthBinding(),
        page: () => OtpVerification()),
  ];
}


