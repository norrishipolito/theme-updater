import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Image.asset(
        'assets/imgs/logo.png',
        width: 70,
        height: 70,
      ),
    );
  }
}
