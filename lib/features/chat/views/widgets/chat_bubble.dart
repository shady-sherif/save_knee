import 'package:flutter/material.dart';
import 'package:save_knee_23/features/chat/view_models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel messageModel;

  const ChatBubble({
    super.key,
    required this.messageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 28,
          bottom: 28,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: Color(0xff274460)),
        child: Text(
          messageModel.message,
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }
}
