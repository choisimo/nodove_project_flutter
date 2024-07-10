import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/Feed/model/feed.dart';
import 'package:nodove_flutter/Feed/vmodel/vmodel.dart';

class DataSrc{
  Future<List<Feed>> getFeedList(int page,int size,int id,String url) async{
    List<Feed> feeds;
    Dio dio = Dio();
    final res = await dio.get("$url$page?pageSize=$size&categoryId=$id");
    return res.data.map<Feed>((json)=>Feed.fromJson(json)).toList();
  }
}