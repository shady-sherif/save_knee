import 'package:flutter/material.dart';
import 'package:save_knee_23/features/auth/auth_cubit/auth_cubit.dart';
import 'package:save_knee_23/features/home/views/widgets/chat_list_View.dart';

import '../view_models/user_model.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key, this.docModel});

  final UserModel? docModel;

  @override
  Widget build(BuildContext context) {
    var auth = AuthCubit.get(context);
    return Scaffold(
        body: ListView.builder(
      itemCount: auth.doctorsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: ChatListItem(docModel: auth.doctorsList[index]),
        );
      },
    ));
  }
}
