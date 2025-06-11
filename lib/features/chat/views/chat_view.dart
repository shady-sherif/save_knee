import 'package:flutter/material.dart';
import 'package:save_knee_23/features/chat/views/widgets/chat_view_body.dart';
import 'package:save_knee_23/features/home/view_models/user_model.dart';

class ChatView extends StatelessWidget {
  final UserModel? doctorModel;

  const ChatView({super.key, this.doctorModel});

  @override
  Widget build(BuildContext context) {
    return ChatViewBody(doctorModel: doctorModel);
  }
}
