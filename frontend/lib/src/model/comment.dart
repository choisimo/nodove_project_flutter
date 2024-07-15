import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Comment{
  final int commentId;
  final String comment;
  final String writer;
  final String createdAt;
  final List<dynamic>? replies;

  Comment({
    required this.commentId,
    required this.comment,
    required this.writer,
    required this.createdAt,
    this.replies,
  });

  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
      commentId : json['commentId'],
      comment : json['comment'],
      writer : json['writer'],
      createdAt : json['createdAt'],
      replies : json['replies'],
    );
  }
}