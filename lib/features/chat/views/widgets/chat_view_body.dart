import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:save_knee_23/core/utils/assets.dart';
import 'package:save_knee_23/features/chat/chat_cubit/chat_cubit.dart';
import 'package:save_knee_23/features/home/view_models/user_model.dart';

import 'chat_bubble.dart';

class ChatViewBody extends StatefulWidget {
  final UserModel? doctorModel;

  const ChatViewBody({super.key, this.doctorModel});

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  TextEditingController controller = TextEditingController();

  @override
  void didChangeDependencies() {
    ChatCubit.get(context).getMessages(widget.doctorModel?.uId ?? '');
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    ChatCubit.get(context).messagesList.clear();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    var chat = ChatCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff274460),
        foregroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                'chat with ${widget.doctorModel!.name}',
                style:const TextStyle(color: Colors.white),
              ),
            ),
            widget.doctorModel!.profileImage != null &&
                    widget.doctorModel!.profileImage!.isNotEmpty
                ? CircleAvatar(
                    radius: 20,
                    backgroundImage:
                        NetworkImage(widget.doctorModel!.profileImage!),
                  )
                : const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(AssetsData.doctorImage),
                  )
          ],
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (_, state) {
          if (state is SendMessageSuccess) {}
        },
        builder: (_, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chat.messagesList.length,
                  itemBuilder: (_, index) => ChatBubble(
                    messageModel: chat.messagesList[index],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Send Message',
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                      ),
                      onPressed: () {
                        final message = controller.text;
                        if (controller.text.isNotEmpty) {
                          controller.clear();
                          chat.sendMassage(
                              message,
                              widget.doctorModel?.uId ?? '',
                              FirebaseAuth.instance.currentUser?.uid ?? '');
                          debugPrint("Messages: ${chat.messagesList.length}");
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
