import 'dart:ffi';

import 'package:flutter/foundation.dart';

class Feed{
  final int id;
  final String title;
  final String writer;
  final int writerId;
  final String? caption;
  final String? content;
  final String? status;
  final String createdAt;
  final String updatedAt;
  final int likeCount;
  final int commentCount;
  final Array? hashtags;
  final Array? imageLinks;
  final Bool private;

  Feed({
    required this.id,
    required this.title,
    required this.writer,
    required this.writerId,
    this.caption,
    this.content,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.likeCount,
    required this.commentCount,
    this.hashtags,
    this.imageLinks,
    required this.private,
  });

  factory Feed.fromJson(Map<String,dynamic> json){
    return Feed(
      id : json['id'],
      title : json['title'],
      writer : json['writer'],
      writerId : json['writerId'],
      caption : json['caption'],
      content : json['content'],
      status : json['status'],
      createdAt : json['createdAt'],
      updatedAt : json['updatedAt'],
      likeCount : json['likeCount'],
      commentCount : json['commentCount'],
      hashtags : json['hashtags'],
      imageLinks : json['imageLinks'],
      private : json['private'],
    );
  }
}