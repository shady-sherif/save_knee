import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_knee_23/core/utils/app_router.dart';
import 'package:save_knee_23/core/utils/assets.dart';

import '../../view_models/user_model.dart';

class DoctorContainer extends StatelessWidget {
  const DoctorContainer(
      {super.key, required this.doctorModel, required this.color});

  final UserModel doctorModel;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AspectRatio(
      aspectRatio: 6 / 3.8,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: color.withOpacity(0.2)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            doctorModel.profileImage != null &&
                    doctorModel.profileImage!.isNotEmpty
                ? Expanded(
                    flex: 3,
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: color,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(doctorModel.profileImage!))),
                    ),
                  )
                : Expanded(
                    flex: 3,
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          color: color,
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AssetsData.doctorImage))),
                    ),
                  ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr.${doctorModel.name}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16)),
                      child: IconButton(
                        padding: EdgeInsets.zero,

                        // icon thatttttttttttttttttt onPressed
                        onPressed: () {
                          GoRouter.of(context)
                              .push(AppRouter.kChatView, extra: doctorModel);
                        },
                        icon: Icon(Icons.message_outlined, color: color),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
