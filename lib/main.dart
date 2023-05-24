import 'package:car_parts/routes/app_routes.dart';
import 'package:car_parts/routes/app_routes_constant.dart';
import 'package:car_parts/services/service_locator.dart';
import 'package:car_parts/ui/homepage_screen.dart';
import 'package:car_parts/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'data/sharedPreference/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light
      //transparent status bar
      ));
  await SharedPreference().init();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Routes.routes,
      initialRoute: RouteConstant.INITIALROUTE,
    );
  }
}
