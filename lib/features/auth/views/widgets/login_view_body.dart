import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:save_knee_23/core/utils/app_router.dart';
import 'package:save_knee_23/features/auth/auth_cubit/auth_cubit.dart';
import 'package:save_knee_23/features/auth/view_models/login_data.dart';
import 'package:save_knee_23/features/auth/views/widgets/custom_container.dart';
import '../../../../core/utils/custom_button.dart';
import 'custom_text.dart';
import 'custom_text_fields_container.dart';
import 'knee_image.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = BlocProvider.of<AuthCubit>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is LoginLoading) {
          auth.isLoading = true;
        } else if (state is LoginFailure) {
          auth.isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
            ),
          );
        } else if (state is LoginSuccess) {
          await auth.getDoctorsList();
          auth.isLoading = false;
          GoRouter.of(context).push(AppRouter.kHomeView);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: auth.isLoading!,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                const KneeImage(),
                CustomText(text: 'Login', width: width, height: height),
                Positioned(
                  bottom: 0,
                  child: CustomDecorationGradientContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .06,
                            ),
                            CustomTextFieldContainer(
                              child: Column(
                                children: [
                                  TextFormField(
                                    validator: (value) {
                                      final RegExp regex = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+",
                                      );
                                      if (value == null || value.isEmpty) {
                                        return "Please Enter Email";
                                      } else {
                                        if (!regex.hasMatch(value)) {
                                          return 'Enter valid Email';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        hintStyle: TextStyle(),
                                        hintText: 'Email or Phone number',
                                        border: InputBorder.none),
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else if (value.length < 6) {
                                        return "Password can't be less than 6 characters";
                                      }
                                      return null;
                                    },
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onTap: () async {
                                final loginData = LoginData(
                                    email: emailController.text,
                                    password: passwordController.text);
                                print(
                                    'email controller ${emailController.text} ========== pass ${passwordController.text}');
                              await  auth.userLogin(loginData);
                              },
                              text: 'Sign In',
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                TextButton(
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.deepPurple),
                                  ),
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .push(AppRouter.kRegisterView);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
