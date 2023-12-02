// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Skills {
  final String tag;
  final List<Img> images;

  Skills({required this.tag, required this.images});

  factory Skills.fromJson(Map<String, dynamic> json) {
    var imageList = json['images'] as List;
    List<Img> images = imageList.map((i) => Img.fromJson(i)).toList();
    return Skills(
      tag: json['tag'],
      images: images,
    );
  }
  static Future<List<Skills>> fetchSkills() async {
    final response = await http.get(
        Uri.parse('https://norrisasd.github.io/theme-updater-api/skills.json'));

    if (response.statusCode == 200) {
      List<dynamic> jsonItems = jsonDecode(response.body);
      return jsonItems.map((jsonItem) => Skills.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }
}

class Img {
  final String src;
  Img({required this.src});

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      src: json['src'],
    );
  }
}

class SelectionPicker extends StatefulWidget {
  final List<String> imageList;
  final List<String> nameList;

  const SelectionPicker({
    super.key,
    required this.imageList,
    required this.nameList,
  });

  @override
  _SelectionPickerState createState() => _SelectionPickerState();
}

class _SelectionPickerState extends State<SelectionPicker> {
  int _selectedImageIndex = 0;

  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: widget.imageList
              .map((item) => Center(
                  child: Image.asset(item, fit: BoxFit.cover, width: 300)))
              .toList(),
          options: CarouselOptions(
            height: 300,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
          carouselController: buttonCarouselController,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => buttonCarouselController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              child: const Text('←'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => buttonCarouselController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear),
              child: const Text('→'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildRadioButtons(),
          ),
        )
      ],
    );
  }

  List<Widget> _buildRadioButtons() {
    return widget.nameList.asMap().entries.map((entry) {
      final index = entry.key;
      final image = entry.value;
      // List<Img> images = Skills.;
      return ListTile(
        leading: Radio(
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white; // The color when the button is selected
            }
            return Colors.grey; // The color when the button is unselected
          }),
          value: index,
          groupValue: _selectedImageIndex,
          onChanged: (value) {
            setState(() {
              _selectedImageIndex = value as int;
            });
          },
        ),
        title: Text(
          entry.value, // Replace this with your actual text
          style: GoogleFonts.inter(
              color: Colors.white), // Replace this with your desired color
        ),
      );
    }).toList();
  }
}

class Carousel extends StatelessWidget {
  final List<String> imageList;
  final int selectedIndex;

  const Carousel({
    super.key,
    required this.imageList,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Image.asset(
        imageList[selectedIndex],
        fit: BoxFit.cover,
      ),
    );
  }
}
