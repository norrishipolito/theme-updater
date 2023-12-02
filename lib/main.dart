import 'dart:io';

import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'package:window_manager/window_manager.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(900, 700),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setResizable(false);
  });
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
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
