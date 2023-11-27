import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(600, 500));
    setWindowTitle('Theme Updater');
  }
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Files Updater",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
