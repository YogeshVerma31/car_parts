import 'package:car_parts/routes/app_routes.dart';
import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/services/service_locator.dart';
import 'package:car_parts/ui/homepage_screen.dart';
import 'package:car_parts/ui/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'data/sharedPreference/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light));
  await SharedPreference().init();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      initialRoute: RouteConstant.INITIALROUTE,
    );
  }
}
