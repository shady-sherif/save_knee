import 'package:flutter/material.dart';
import 'package:save_knee_23/features/auth/views/widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static String id = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginViewBody(),
    );
  }
}
