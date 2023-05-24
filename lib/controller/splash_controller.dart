import 'package:get/get.dart';

import '../constants/app_constants.dart';
import '../data/sharedPreference/shared_preference.dart';
import '../routes/app_routes_constant.dart';

class SplashController extends GetxController {
  var name = 0;

  @override
  void onInit() {
    name = 1;
    navigateToPage();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  navigateToPage() {
    Future.delayed(const Duration(seconds: 3), () {
      if (SharedPreference().getString(AppConstants().authToken) == null) {
        Get.offAllNamed(RouteConstant.SIGINROUTE);
      } else {
        Get.offAllNamed(RouteConstant.HOMEROUTE);
      }
    });
  }
}
