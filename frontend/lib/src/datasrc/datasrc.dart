import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData hide MultipartFile;
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/state/url.dart';

class DataSrc{
  Dio dio = Dio(BaseOptions(
    baseUrl: Url.serverUrl, // 요청의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
  ));
  
  Future<List<Feed>> getFeedList(int page,String url,String opt) async{
    try{
      final res = await dio.get("$url/$page?$opt");
      return res.data.map<Feed>((json)=>Feed.fromJson(json)).toList();
    }catch(e){
      log(e.toString());
      return [Feed.defaultState()];
    }
  }
  Future<Feed> getFeedPage(int page,String url) async{
    try{
      final res = await dio.get("$url/$page");
      return Feed.fromJson(res.data);
    }catch(e){
      log(e.toString());
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
  Future<Categories> getCateOne(String url,String opt) async{
    try{
      final res = await dio.get("$url$opt");
      return res.data;
    }catch(e){
      return Categories.initialState();
    }
  }
  Future<List<Comment>> getCommentList(int page,String url,String opt) async{
    try{
      final res = await dio.get("$url/$page?$opt");
      final data = res.data['comments'];
      return data.map<Comment>((json)=>Comment.fromJson(json)).toList();
    }catch(e){
      log(e.toString());
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
      log("댓글 작성 에러 : $e");
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
        log("로그인 실패");
      }
    } catch(e){
      log("로그인 에러 : $e");
    }
  }

  Future<User> getUserInfo(String id) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("${Url.apiUrl}/restrict/user/userInfo?userId=$id");
      return User.fromJson(res.data);
    }catch(e){
      log("불러오기 에러 : $e");
      return User.defaultState();
    }
  }

  Future<List<String>> postImagesData(List<XFile> images) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      dio.options.contentType = "multipart/form-data";
      dio.options.maxRedirects.isFinite;
      final uploadList = <MultipartFile>[];
      for (final imageFiles in images) {
          uploadList.add(
              await MultipartFile.fromFile(
                  imageFiles.path,
                  filename: imageFiles.path.split('/').last,
                  contentType: DioMediaType('image', 'jpg'),
              ),
          );
      }
      FormData formdata = FormData.fromMap({"file" : uploadList});
      
      final res = await dio.post(
        "${Url.apiUrl}/restrict/user/postFileUpload",
        data : formdata
      );

      return res.data;
    } catch(e){
      return [];
    }
  }
}