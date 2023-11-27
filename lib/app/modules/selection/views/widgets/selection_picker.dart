// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'dart:io';

class SelectionPicker extends StatefulWidget {
  const SelectionPicker({super.key});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<SelectionPicker> {
  // late VideoPlayerController _controller;
  // int? _selectedVideoIndex = 0;

  // final List<String> _videoUrls = [
  //   'https://example.com/video1.mp4',
  //   'https://example.com/video2.mp4',
  //   'https://example.com/video3.mp4',
  // ];

  // @override
  // void initState() {
  //   super.initState();
  //   _controller =
  //       VideoPlayerController.network(_videoUrls[_selectedVideoIndex!])
  //         ..initialize().then((_) {
  //           setState(() {
  //             _controller.play();
  //           });
  //         });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void _onRadioValueChanged(int? index) {
  //   setState(() {
  //     _selectedVideoIndex = index;
  //     _controller.pause();
  //     _controller =
  //         VideoPlayerController.network(_videoUrls[_selectedVideoIndex!])
  //           ..initialize().then((_) {
  //             setState(() {
  //               _controller.play();
  //             });
  //           });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Player'),
      ),
      body: Column(
          // children: [
          //   AspectRatio(
          //     aspectRatio: _controller.value.aspectRatio,
          //     child: VideoPlayer(_controller),
          //   ),
          //   SizedBox(height: 16),
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       _videoUrls.length,
          //       (index) => Radio(
          //         value: index,
          //         groupValue: _selectedVideoIndex,
          //         onChanged: _onRadioValueChanged,
          //       ),
          //     ),
          //   ),
          // ],
          ),
    );
  }
}
