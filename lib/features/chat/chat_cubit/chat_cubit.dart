import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:save_knee_23/constants.dart';
import 'package:save_knee_23/features/chat/view_models/message_model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<MessageModel> messagesList = [];
  CollectionReference doctorCollection =
      FirebaseFirestore.instance.collection(kDoctorsCollection);
  final String uId = FirebaseAuth.instance.currentUser!.uid;

  static ChatCubit get(BuildContext context) => BlocProvider.of(context);

  CollectionReference messagesCollection =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  Future<void> sendMassage(
      String message, String docId, String senderId) async {
    final DocumentReference groupMessageDocRef =
        messagesCollection.doc(docId).collection(kMessagesCollection).doc();
    final messageId = groupMessageDocRef.id;
    final messageModel = MessageModel(
        message: message,
        date: DateTime.now(),
        uId: uId,
        messageId: messageId,
        senderId: senderId);
    await groupMessageDocRef.set(messageModel.toJson());
    emit(SendMessageSuccess());
  }

  void getMessages(String docId) {
    messagesCollection
        .doc(docId)
        .collection(kMessagesCollection)
        .snapshots()
        .listen(
      (querySnapshot) {
        if (querySnapshot.docs.isEmpty) return;
        messagesList = querySnapshot.docs
            .map((doc) => MessageModel.fromJson(doc.data()))
            .toList();
        emit(GetMessagesSuccess());
      },
    );
  }
}
