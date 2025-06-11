import 'package:flutter/material.dart';
import 'package:save_knee_23/core/utils/assets.dart';

class KneeImage extends StatelessWidget {
  const KneeImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.1,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsData.kneeImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
