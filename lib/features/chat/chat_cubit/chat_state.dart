part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class SendMessageSuccess extends ChatState {}
class GetMessagesSuccess extends ChatState {}
