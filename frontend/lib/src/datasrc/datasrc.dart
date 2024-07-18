import 'dart:convert';
import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/url.dart';

class DataSrc{
  Dio dio = Dio(BaseOptions(
    baseUrl: Url.serverUrl, // 요청의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    },
  ));
  
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
  Future<void> postFeed(FeedWrite formData) async {
    final res = await dio.post(
      '${Url.apiUrl}/restrict/user/write',
      data : formData
    );
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

  Future<void> postComment(Map<String,dynamic> formData) async {
    try{
      dio.interceptors.add(ApiInterceptors());
      await dio.post(
        '${Url.apiUrl}/restrict/user/commentWrite',
        data : formData,
      );
    }catch(e){
      print("댓글 작성 에러 : $e");
    }
  }

  Future<void> PostLogin(Map<String,String> formData) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        "/login",
        data : formData
      );
      if (res.statusCode == 200){
        Get.off(()=>const MyHome());
      } else {
        print("로그인 실패");
      }
    } catch(e){
      print("로그인 에러 : $e");
    }
  }
}