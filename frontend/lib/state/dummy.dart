import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/model/user.dart';

class Dump{
  static final List<Room> friendLists = [
    Room(
      roomId: 1,
      user : User(
        userId : "javascript",
        profile : "https://modulabs.co.kr/wp-content/uploads/2023/11/image-1536x864.jpeg",
        role : "USER",
        nickname : "자바스크립트",
        certifications: [],
        groups : [],
        hashtags : ["언어","자바스크립트"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      ),
      lastMsg: ChatContent(
        chatId: 1,
        content : "자바스크립트입니다",
        createdAt: "2024-08-20 12:12:12"
      )
    ),
    Room(
      roomId : 2,
      user : User(
        userId : "golang",
        profile : "https://www.freecodecamp.org/news/content/images/2021/10/golang.png",
        role : "USER",
        nickname : "GO",
        certifications: [],
        groups : [],
        hashtags : ["언어","GO"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      ),
      lastMsg: ChatContent(
        chatId: 1,
        content : "고랭",
        createdAt: "2024-08-20 12:12:12"
      )
    ),
    Room(
      roomId: 3,
      user : User(
        userId : "java",
        profile : "https://velog.velcdn.com/images/pak4184/post/98ba8b4f-7b89-4d28-8376-0dc8d1be805a/image.png",
        role : "USER",
        nickname : "자바",
        certifications: [],
        groups : [],
        hashtags : ["언어","자바"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      ),
      lastMsg: ChatContent(
        chatId: 1,
        content : "자바입니다",
        createdAt: "2024-08-20 12:12:12"
      )
    ),
  ];
  static final List<Chat> chatLists = [
    Chat(
      chatId: 3,
      content : ChatContent(
        chatId: 3,
        content : "채팅 예시입니다1",
        createdAt: "2024-08-22 03:11:00"
      ),
      user : User(
        userId : "java",
        profile : "https://velog.velcdn.com/images/pak4184/post/98ba8b4f-7b89-4d28-8376-0dc8d1be805a/image.png",
        role : "USER",
        nickname : "자바",
        certifications: [],
        groups : [],
        hashtags : ["언어","자바"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      )
    ),
    Chat(
      chatId: 2,
      content : ChatContent(
        chatId: 2,
        content : "채팅 예시입니다2",
        createdAt: "2024-08-22 03:11:00"
      ),
      user : User(
        userId : "java",
        profile : "https://velog.velcdn.com/images/pak4184/post/98ba8b4f-7b89-4d28-8376-0dc8d1be805a/image.png",
        role : "USER",
        nickname : "자바",
        certifications: [],
        groups : [],
        hashtags : ["언어","자바"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      )
    ),
    Chat(
      chatId: 1,
      content : ChatContent(
        chatId: 1,
        content : "채팅 예시입니다3",
        createdAt: "2024-08-22 03:11:00"
      ),
      user : User(
        userId : "java",
        profile : "https://velog.velcdn.com/images/pak4184/post/98ba8b4f-7b89-4d28-8376-0dc8d1be805a/image.png",
        role : "USER",
        nickname : "자바",
        certifications: [],
        groups : [],
        hashtags : ["언어","자바"],
        userActivities: [],
        birthDate: DateTime.now().millisecondsSinceEpoch,
        private: false,
      )
    ),
  ];
}