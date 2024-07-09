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
  final List<dynamic> hashtags;
  final List<dynamic> imageLinks;
  final bool private;

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
    required this.hashtags,
    required this.imageLinks,
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