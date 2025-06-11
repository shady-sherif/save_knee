import 'package:flutter/material.dart';
class BackArrow extends StatelessWidget {
  const BackArrow({super.key});

  @override
  Widget build(BuildContext context) {
  var  height = MediaQuery.of(context).size.height;
    return Positioned(
      top: height * 0.03,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 35,
          color: Color(0xff40688F),
        ),
      ),
    );
  }
}