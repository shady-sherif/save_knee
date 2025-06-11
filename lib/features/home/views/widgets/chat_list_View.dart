import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:save_knee_23/core/utils/app_router.dart';
import 'package:save_knee_23/core/utils/assets.dart';
import 'package:save_knee_23/features/home/view_models/user_model.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.docModel});

  final UserModel docModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        docModel.profileImage != null && docModel.profileImage!.isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                backgroundImage: NetworkImage(docModel.profileImage!),
              )
            : const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
                backgroundImage: AssetImage(AssetsData.doctorImage),
              ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              'Dr. ${docModel.name}',
              style: const TextStyle(fontSize: 18),
            ),
            const Text('Physiotherapist')
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 6),
          child: IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kChatView, extra: docModel);
              },
              icon: const Icon(Icons.chat)),
        )
      ],
    );
  }
}
