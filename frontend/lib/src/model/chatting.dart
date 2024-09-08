import 'package:nodove_flutter/src/model/user.dart';

class Room{
  final String roomId;
  final String? roomName;
  final String? profile;
  final ChatUser user;
  final ChatContent lastMsg;
  
  Room({
    required this.roomId,
    required this.user,
    required this.lastMsg,
    this.roomName,
    this.profile,
  });

  factory Room.fromJson(Map<String,dynamic> json){
    final room = json['room'];
    final user  = json['user'];
    final lastMsg = room['lastMessage'];
    return Room(
      roomId: json['id'],
      roomName : room['id'],
      profile : room['profile'],
      user : ChatUser(
        id : user['id'],
        userId : user['userId'],
        username : user['username'],
        lastOnline : user['lastOnline'],
        profile : user['profile'],
      ),
      lastMsg: ChatContent(
        chatId: lastMsg['id'],
        content : lastMsg['content'],
        createdAt: lastMsg['timestamp']
      )
    );
  }
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

class ChatUser{
  final String userId;
  final String username;
  final String profile;
  final DateTime lastOnline;
  final String id;

  ChatUser({
    required this.userId,
    required this.username,
    required this.profile,
    required this.lastOnline,
    required this.id,
  });
}

class LastMsg{
  final int id;
  final String content;
  final String timestamp;

  LastMsg({
    required this.id,
    required this.content,
    required this.timestamp
  });
}