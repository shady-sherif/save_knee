import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_knee_23/features/auth/views/widgets/custom_text_fields_container.dart';
import '../../auth_cubit/auth_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key, this.onChanged});

  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<AuthCubit>(context);

    return CustomTextFieldContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            onChanged: (value) {
              // user.email = value;
            },
            decoration: const InputDecoration(
                hintStyle: TextStyle(),
                hintText: 'Email or Phone number',
                border: InputBorder.none),
          ),
          const Divider(
            color: Colors.grey,
          ),
          TextFormField(
            onChanged: (value) {
              // user.password = value;
            },
            decoration: const InputDecoration(
              hintText: 'Password',
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
