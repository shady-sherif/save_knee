import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, this.onTap});
  final String text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * .5,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0xff1C4B7F),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 20, color: Color(0xff314F6A)),
            )),
      ),
    );
  }
}
