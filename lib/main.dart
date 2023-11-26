import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setWindowMinSize(const Size(700, 700));
  setWindowTitle("Theme Updater");
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Files Updater",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
