import 'package:flutter/material.dart';
import 'package:save_knee_23/features/splash/presentation/views/widgets/splash_view_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static String id = 'splashView';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: SplashViewBody(),
    );
  }
}
