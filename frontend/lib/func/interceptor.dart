import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/state/user.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    const storage = FlutterSecureStorage();

    final String token = "Bearer ${await storage.read(key: "userToken")}";
    final String refresh = "${await storage.read(key: "refreshToken")}";
    options.headers['Authorization'] = token;
    options.headers['cookie'] = refresh;

    super.onRequest(options, handler);
  }

  /*@override
  void onError(DioException err, ErrorInterceptorHandler handler) async{
    const FlutterSecureStorage storage = FlutterSecureStorage();
    final tokenError = (err.response?.statusCode == 401); 
    Dio dio = Dio(BaseOptions(
      baseUrl: Url.authServerUrl, // 요청의 기본 URL
      connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
      receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
    ));
    
    final String? refresh = await storage.read(key: "refreshToken");
    
    if(refresh == null){
      return handler.reject(err);
    }
    
    if (tokenError){
      print("토큰에러! 재시도중...");
      Future.delayed(const Duration(milliseconds: 1000));
      try{
        final res = await dio.post("/");
        handler.resolve(res);
      }catch(e){
        await storage.delete(key: 'userToken');
        await storage.delete(key: 'refreshToken');
        Get.off(()=>const LoginMainPage());
      }
    }
    return super.onError(err, handler);
  }*/

  @override
  void onResponse(response, ResponseInterceptorHandler handler) async{
    final String? cookie = response.headers['set-cookie']?[0];
    final String? jwt = response.headers['Authorization']?[0];
    final user = Get.put(UserState());

    if (jwt != null && cookie != null){
      final res = await decoding(jwt,cookie);
      if (res['parsed'] != null){
        user.setIndex(res['parsed']['userId']);
        print(user.id);
      } else{
        print("아이디 찾기 실패");
      }
    }
    
    super.onResponse(response, handler);
  }
}

