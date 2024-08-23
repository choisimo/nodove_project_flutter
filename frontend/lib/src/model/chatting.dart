import 'package:nodove_flutter/src/model/user.dart';

class Room{
  final int roomId;
  final String? roomName;
  final String? profile;
  final User user;
  final ChatContent lastMsg;
  
  Room({
    required this.roomId,
    required this.user,
    required this.lastMsg,
    this.roomName,
    this.profile,
  });
}

class Chat{
  final int chatId;
  final ChatContent content;
  final User user;
  
  Chat({
    required this.chatId,
    required this.content,
    required this.user
  });
}

class ChatContent{
  final int chatId;
  final String content;
  final String createdAt;

  ChatContent({
    required this.chatId,
    required this.content,
    required this.createdAt
  });
}