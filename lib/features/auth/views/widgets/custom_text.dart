import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.width,
    required this.height, required this.text,
  });

  final double width;
  final double height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: width * 0.03,
      top: height * 0.21,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff40688F),
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
