import 'package:flutter/material.dart';
class CustomDecorationGradientContainer extends StatelessWidget {
  const CustomDecorationGradientContainer({super.key,required this.child});
  final Widget child ;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: height * 0.6,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xffE2ECF4),
              Color(0XFF376089),
            ]),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: child,
    );
  }
}
