import 'dart:developer';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile hide FormData;
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/url.dart';

class DataSrc{
  Dio dio = Dio(BaseOptions(
    baseUrl: Url.serverUrl, // 요청의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
  ));
  
  
  Future<List<Feed>?> getFeedList(int page,String url,String opt) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("$url/$page?$opt");
      return res.data.map<Feed>((json)=>Feed.fromJson(json)).toList();
    }catch(e){
      log(e.toString());
      showToast("오류가 발생했어요😢");
    }
    return null;
  }
  Future<Feed?> getFeedPage(String url,String opt) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("$url/$opt");
      return Feed.fromJson(res.data);
    }catch(e){
      log(e.toString());
      showToast("오류가 발생했어요😢");
      return null;
    }
  }
  Future<bool> postFeed(Map<String,dynamic> formData) async {
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        '${Url.apiUrl}/restrict/user/write',
        data : jsonEncode(formData)
      );
      if (res.statusCode == 200){
        return true;
      } else{
        return false;
      }
    }catch(e){
      await RefreshToken();
      showToast("피드를 올릴 수 없어요😢");
      print(e);
      return false;
    }
  }
  Future<void> deleteFeed(int postId) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.delete(
        '${Url.apiUrl}${Url.deleteFeed}/$postId',
      );
      if(res.statusCode == 200){
        showToast("삭제가 완료되었습니다");
      } else{
        showToast("피드를 삭제 할 수 없어요😢");
      }
    }catch(e){
      await RefreshToken();
      showToast("피드를 삭제 할 수 없어요😢");
      print(e);
    }
  }
  Future<void> editFeed(Map<dynamic,dynamic> formData,int postId) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        '${Url.apiUrl}${Url.updateFeed}/$postId',
        data : jsonEncode(formData)
      );
      if(res.statusCode == 200){
        showToast("수정이 완료되었습니다");
      } else{
        showToast("피드를 수정 할 수 없어요😢");
      }
    }catch(e){
      await RefreshToken();
      showToast("피드를 수정 할 수 없어요😢");
      print(e);
    }
  }

  Future<List<Categories>> getCateList(String url,String opt,bool child) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("$url$opt");
      final data = (child)?res.data[0]['children']:res.data;
      return data.map<Categories>((json)=>Categories.fromJson(json)).toList();
    }catch(e){
      showToast("오류가 발생했어요😢");
      return [];
    }
  }
  Future<Categories> getCateOne(String url,String opt) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("$url$opt");
      return Categories.fromJson(res.data[0]);
    }catch(e){
      await RefreshToken();
      showToast("오류가 발생했어요😢");
      print(e);
      return Categories.initialState();
    }
  }

  Future<List<Comment>> getCommentList(int page,String url,String opt) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("$url/$page?$opt");
      final data = res.data['comments'];
      return data.map<Comment>((json)=>Comment.fromJson(json)).toList();
    }catch(e){
      await RefreshToken();
      showToast("오류가 발생했어요😢");
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
      await RefreshToken();
      showToast("댓글을 작성 할 수 없어요😢");
      log("댓글 작성 에러 : $e");
    }
  }

  Future<User> getUserInfo(String id) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get("${Url.apiUrl}/restrict/user/userInfo?userId=$id");
      return User.fromJson(res.data);
    }catch(e){
      await RefreshToken();
      log("불러오기 에러 : $e");
      return User.defaultState();
    }
  }

  
  Future<void> RefreshToken() async{
    dio.interceptors.add(ApiInterceptors());
    //const storage = FlutterSecureStorage();
    
    try{
      await dio.get(
        "/token",
      ).then((_){
        Get.reload();
      });
    }
    catch(e){
        //await storage.delete(key: 'userToken');
        //await storage.delete(key: 'refreshToken');
        //Get.off(()=>const LoginPage());
        showToast("refreshToken 갱신 에러");
    }
  }

  

  Future<List<dynamic>> postImagesData(List<XFile> images) async{
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
      print("${Url.fileServerUrl}${Url.fileServeUrl}${Url.fileUrl}/images");
      final res = await dio.post(
        "${Url.fileServerUrl}${Url.fileServeUrl}${Url.fileUrl}/images",
        data : formdata
      );
      return res.data;
    } catch(e){
      return [];
    }
  }

  Future<List<Noti>> getNotificationList() async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get(
        "${Url.apiUrl}/restrict/user/getAllUnReadAlarms"
      );
      return res.data.map<Noti>((json)=>Noti.fromJson(json)).toList();
    }catch(e){
      return [];
    }
  }


  Future<List<RecruitFeed>> getRecruitmentList(int page , int size) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get(
        "${Url.recruitServerUrl}/feed/all?page=$page&size=$size"
      );
      final list = res.data.map<RecruitFeed>((json)=>RecruitFeed.fromJson(json)).toList();
      return list;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<RecruitFeed> getRecruitmentPage(String id) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get(
        "${Url.recruitServerUrl}/feed?id=$id"
      );
      final list = res.data.map<RecruitFeed>((json)=>RecruitFeed.fromJson(json)).toList();
      return list;
    }catch(e){
      print(e);
      return RecruitFeed.defaultState();
    }
  }

    Future<void> deleteRecruitmentFeed(String id) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.delete(
        '${Url.recruitServerUrl}/post${Url.deleteFeed}/$id',
      );
      if(res.statusCode == 200){
        showToast("삭제가 완료되었습니다");
      } else{
        showToast("피드를 삭제 할 수 없어요😢");
      }
    }catch(e){
      await RefreshToken();
      showToast("피드를 삭제 할 수 없어요😢");
      print(e);
    }
  }
  Future<void> editRecruitmentFeed(Map<dynamic,dynamic> formData,String id) async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        '${Url.recruitServerUrl}/post/${Url.updateFeed}/$id',
        data : jsonEncode(formData)
      );
      if(res.statusCode == 200){
        showToast("수정이 완료되었습니다");
      } else{
        showToast("피드를 수정 할 수 없어요😢");
      }
    }catch(e){
      await RefreshToken();
      showToast("피드를 수정 할 수 없어요😢");
      print(e);
    }
  }
}