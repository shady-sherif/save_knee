import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          padding: EdgeInsets.symmetric(horizontal: 55.w, vertical: 17.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          )),
      child: Text(
        text,
        style: kButtonTextStyle,
      ),
    );
  }
}
