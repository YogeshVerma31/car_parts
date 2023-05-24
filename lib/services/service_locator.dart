import 'package:car_parts/services/permission_handler_service.dart';
import 'package:car_parts/services/permission_service.dart';
import 'package:get_it/get_it.dart';

import 'media_services.dart';
import 'media_services_interface.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<PermissionService>(PermissionHandlerPermissionService());
  getIt.registerSingleton<MediaServiceInterface>(MediaService());
}