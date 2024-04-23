import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_config.dart';
import 'vaahextendflutter/base/base_controller.dart';
import 'firebase_options.dart';
import 'vaahextendflutter/services/api_self_signed.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseController baseController = Get.put(BaseController());
  HttpOverrides.global = SelfSignedHttps();
  await baseController.init(
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    app: const AppConfig(),
    errorApp: const ErrorAppConfig(),
  ); // Pass main app as argument in init method
}
