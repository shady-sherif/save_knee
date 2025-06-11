import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/core/utils/assets.dart';
import '../../../auth/auth_cubit/auth_cubit.dart';

class CustomHomeViewAppBar extends StatefulWidget {
  const CustomHomeViewAppBar({super.key});

  @override
  State<CustomHomeViewAppBar> createState() => _CustomHomeViewAppBarState();
}

class _CustomHomeViewAppBarState extends State<CustomHomeViewAppBar> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var auth = BlocProvider.of<AuthCubit>(context);
    return Stack(
      children: [
        Container(
          height: height * 0.15,
          width: width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
            color: kPrimaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Opacity(
                        opacity: .9,
                        child: Text(
                          'Hi ${auth.userModel.name}',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        )),
                    const Text(
                      'Find Your Doctor',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (_, currentState) =>
                      currentState is ImageInitial ||
                      currentState is ImageFailure ||
                      currentState is ImageLoaded,
                  builder: (context, state) {
                    return Row(
                      children: [
                        auth.userModel.profileImage != null &&
                                auth.userModel.profileImage!.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                backgroundImage: NetworkImage(
                                  auth.userModel.profileImage!,
                                ),
                                radius: 40,
                              )
                            : const CircleAvatar(
                                backgroundImage: AssetImage(
                                  AssetsData.kneeImage,
                                ),
                                radius: 40,
                              ),
                        IconButton(
                            onPressed: () async {
                              await pickImage(auth);
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 16,
                            ))
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Future<void> pickImage(AuthCubit auth) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? xFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
      if (xFile != null) {
        File xFilePathToFile(XFile xFile) {
          return File(xFile.path);
        }

        imageFile = xFilePathToFile(xFile);
        if (imageFile != null) {
          auth.uploadImages(imageFile!);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('please pick an image')));
    }
  }
}
