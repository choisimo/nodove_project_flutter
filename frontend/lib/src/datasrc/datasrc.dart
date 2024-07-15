import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';

class DataSrc{
  Dio dio = Dio();
  Future<List<Feed>> getFeedList(int page,String url,String opt) async{
    try{
      final res = await dio.get("$url/$page?$opt");
      return res.data.map<Feed>((json)=>Feed.fromJson(json)).toList();
    }catch(e){
      print(e);
      return [Feed.defaultState()];
    }
  }
  Future<Feed> getFeedPage(int page,String url) async{
    try{
      final res = await dio.get("$url/$page");
      return Feed.fromJson(res.data);
    }catch(e){
      print(e);
      return Feed.defaultState();
    }
  }
  Future<List<Categories>> getCateList(String url,String opt,bool child) async{
    try{
      final res = await dio.get("$url$opt");
      final data = (child)?res.data[0]['children']:res.data;
      return data.map<Categories>((json)=>Categories.fromJson(json)).toList();
    }catch(e){
      return [];
    }
  }
  Future<List<Comment>> getCommentList(int page,String url,String opt) async{
    try{
      final res = await dio.get("$url/$page?$opt");
      print("$url/$page?$opt");
      return res.data.map<Comment>((json)=>Comment.fromJson(json)).toList();
    }catch(e){
      return [];
    }
  }
}