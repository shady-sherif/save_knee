import 'package:flutter/material.dart';

class CustomTextFieldContainer extends StatelessWidget {
  const CustomTextFieldContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0xff1C4B7F),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}
