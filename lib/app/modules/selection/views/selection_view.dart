import 'package:files_updater/app/modules/selection/views/widgets/selection_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../shared/logo.dart';
import '../controllers/selection_controller.dart';
import 'widgets/header.dart';

class SelectionView extends GetView<SelectionController> {
  const SelectionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.black87],
            ),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SelectionHeader(),
              Expanded(child: SelectionPicker()),
              Logo(),
            ],
          ),
        ),
      ),
    );
  }
}
