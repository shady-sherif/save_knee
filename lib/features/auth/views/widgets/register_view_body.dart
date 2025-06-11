import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:save_knee_23/core/utils/app_router.dart';
import 'package:save_knee_23/features/auth/view_models/register_data.dart';
import 'package:save_knee_23/features/auth/views/widgets/custom_container.dart';
import 'package:save_knee_23/features/auth/views/widgets/custom_text.dart';
import 'package:save_knee_23/features/auth/views/widgets/custom_text_fields_container.dart';
import '../../../../core/utils/custom_button.dart';
import '../../auth_cubit/auth_cubit.dart';
import 'back_arrow.dart';
import 'knee_image.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var auth = BlocProvider.of<AuthCubit>(context);
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          auth.isLoading = true;
        } else if (state is AuthSuccess) {
          auth.getDoctorsList();
          auth.isLoading = false;
          GoRouter.of(context).push(AppRouter.kHomeView);
        } else if (state is AuthFailure) {
          auth.isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: auth.isLoading!,
          child: SizedBox(
            height: height,
            width: width,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Stack(
                children: [
                  const KneeImage(),
                  const BackArrow(),
                  CustomText(
                    width: width,
                    height: height,
                    text: 'Register',
                  ),
                  Positioned(
                    bottom: 0,
                    child: CustomDecorationGradientContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * .02,
                            ),
                            CustomTextFieldContainer(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter you name';
                                        }
                                        return null;
                                      },
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                          hintText: 'Enter your name',
                                          border: InputBorder.none),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
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

                                          hintText: 'Enter your Email',
                                          border: InputBorder.none),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter you password';
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                        hintText: 'Password',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.grey,
                                    ),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please confirm password';
                                        }
                                        return null;
                                      },
                                      controller: confirmPasswordController,
                                      decoration: const InputDecoration(
                                          hintText: 'Confirm Password',
                                          border: InputBorder.none),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onTap: () {
                                if (passwordController.text ==
                                    confirmPasswordController.text) {
                                  // user.addName(userName);
                                  final registerData = RegisterData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  auth.userRegister(registerData);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('password do not match'),
                                    ),
                                  );
                                }
                              },
                              text: 'Sign Up',
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
