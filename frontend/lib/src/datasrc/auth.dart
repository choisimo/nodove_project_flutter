
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/url.dart';

class AuthDataSrc{
  Dio dio = Dio(BaseOptions(
    baseUrl: Url.authServerUrl, // 요청의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
    headers: {'Content-Type': "audio/wav'", "Connection": "keep-alive"}
  ));

  Future<bool> isUserIdDuplicate(String string) async{ // userId 중복 체크 요청
    try{
      dio.interceptors.add(ApiInterceptors()); // 에러 핸들링을 위한 인터셉터 추가
      final res = await dio.post(   // Post 요청
        "/api/check/userId/IsDuplicate",
        data : jsonDecode('{"userId" : string}')
      );
      if (res.statusCode == 200){   // 결과 200시 데이터 반환 아닐시 false 반환
        return res.data;
      } else {
        return false;
      }
    } catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> isUserNameDuplicate(String string) async{  // username 중복 체크 요청
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        "/api/check/username/IsDuplicate",
        data : jsonDecode("{'username' : $string}")
      );
      if (res.statusCode == 200){
        return res.data;
      } else {
        return false;
      }
    } catch(e){
      print(e);
      return false;
    }
  }
  
  Future<void> postLogin(Map<String,String> formData) async{  //유저 로그인 요청
    try{
      dio.interceptors.add(ApiInterceptors());  
      final res = await dio.post(
        "/login",
        data : jsonEncode(formData)
      );
      if (res.statusCode == 200){
        Get.off(()=>const MyHome());
      } else {
        print("로그인 실패");
      }
    } catch(e) {
      showToast("로그인 할 수 없어요😢");
      print("로그인 에러 : $e");
    }
  }

  Future<bool> postJoin(Map<String,dynamic> formData) async{  //유저 가입 요청
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        "/api/join",
        data : jsonEncode(formData)
      );
      if (res.statusCode == 200){
        return true;
      } else {
        return false;
      }
    } catch(e){
      return false;
    }
  }

  Future<bool> postCode(String email) async{  //이메일 확인용 코드 발송 요청
    try{
      final res = await dio.post(
        "/api/emailSend",
        data : {
          "email" : email
        }
      );
      if (res.statusCode == 200){
        return true;
      } else {
        return false;
      }
    } catch(e){
      return false;
    }
  }
}