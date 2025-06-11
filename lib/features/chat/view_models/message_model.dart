import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final DateTime date;
  final String uId;
  final String messageId;
  final String senderId;

  MessageModel({
    required this.message,
    required this.date,
    required this.uId,
    required this.messageId,
    required this.senderId,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'] ?? '',
      date: (json['date'] as Timestamp).toDate().toLocal(),
      uId: json['uId'] ?? '',
      messageId: json['messageId'] ?? '',
      senderId: json['senderId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'date': Timestamp.fromDate(date),
      'uId': uId,
      'messageId': messageId,
      'senderId': senderId,
    };
  }
}
