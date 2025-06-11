import 'package:flutter/material.dart';

class VidList extends StatelessWidget {
  final double height;
  final String label;
  final bool hasSeeAllButton;
  final Widget tile;

  const VidList(
      {super.key, required this.height,
        required this.label,
        required this.hasSeeAllButton,
        required this.tile});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              TextButton(
                  onPressed: () {},
                  child: hasSeeAllButton ? const Text('see all >') : const Text('')),
            ],
          ),
          SizedBox(
            height: height,
            child: tile,
          )
        ],
      ),
    );
  }
}
