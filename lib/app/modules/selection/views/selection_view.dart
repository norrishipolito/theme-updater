// ignore_for_file: use_super_parameters, no_leading_underscores_for_local_identifiers

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
    final List<String> _imageSkillList = [
      'assets/imgs/logo.png',
      'assets/imgs/sample.gif',
      'assets/imgs/logo.png',
    ];
    final List<String> _imageMapList = [
      'assets/imgs/logo.png',
      'assets/imgs/sample.gif',
      'assets/imgs/logo.png',
    ];
    final List<String> _skillList = [
      'Titas Skill (Elyy Preference)',
      'Full Titas Skill',
      'Blue Reaper',
    ];
    final List<String> _mapList = [
      'BasketBall Theme',
      'Coffee Theme',
    ];
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SelectionHeader(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                      child: SelectionPicker(
                    imageList: _imageSkillList,
                    nameList: _skillList,
                  )),
                  Expanded(
                      child: SelectionPicker(
                    imageList: _imageMapList,
                    nameList: _mapList,
                  )),
                ],
              ),
              const Logo(),
            ],
          ),
        ),
      ),
    );
  }
}
