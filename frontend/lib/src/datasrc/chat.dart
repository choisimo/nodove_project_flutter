import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/url.dart';

class ChatDataSrc{
  Dio dio = Dio(BaseOptions(
    baseUrl: Url.chatServerUrl, // 요청의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 시간 초과 (밀리초)
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 시간 초과 (밀리초)
  ));


  Future<List<Room>> getChatRoomList() async{
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.get(
        "${Url.chatServerUrl}${Url.chatUrl}/user/restrict/room/userRooms"
      );
      final list = res.data.map<Room>((json)=>Room.fromJson(json)).toList();
      return list;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<bool> postRoom(Map<dynamic,dynamic> formData) async {
    try{
      dio.interceptors.add(ApiInterceptors());
      final res = await dio.post(
        '${Url.chatServerUrl}${Url.chatUrl}/user/restrict/room/create',
        data : jsonEncode(formData)
      );
      if (res.statusCode == 200){
        return true;
      } else{
        return false;
      }
    }catch(e){
      showToast("피드를 올릴 수 없어요😢");
      print(e);
      return false;
    }
  }
}