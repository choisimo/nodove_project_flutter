import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodove_flutter/func/token.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    const storage = FlutterSecureStorage();

    final String? token = await storage.read(key: "userToken");
    final String? cookie = await storage.read(key: "cookie");
    if (token != null){options.headers['Authorization'] = token;}
    if (cookie != null){options.headers['cookie'] = cookie;}

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioError, ErrorInterceptorHandler handler) {
    print(dioError);
    super.onError(dioError, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async{
    final String? cookie = response.headers['set-cookie']?[0];
    final String? jwt = response.headers['Authorization']?[0];

    if (jwt!.isNotEmpty&&cookie!.isNotEmpty){await decoding(jwt,cookie);}
    
    super.onResponse(response, handler);
  }
}