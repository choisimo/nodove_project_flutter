import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_talk/kakao_flutter_sdk_talk.dart';

class KakaoLoginApi{
  final UserApi api = UserApi.instance;
  
  login() async{
    bool installed = await isKakaoTalkInstalled();
    if (installed){
      try{
        api.loginWithKakaoTalk().then((_){
          return api.me();
        });
      }catch(e){
        print(e);
        if (e is PlatformException && e.code == 'CANCELED') {
          return;
        } else {
          try {
            return await UserApi.instance.loginWithKakaoAccount().then((_){
              return api.me();
            });
            
          } catch(e){
            print(e);
          }
        }
      }
    } else {
      try {
        return await UserApi.instance.loginWithKakaoAccount().then((_){
          return api.me();
        });
        
      } catch(e){
        print(e);
      }
    }
  }

  logout() async{
    try{
      await UserApi.instance.logout().then((_){
        print("로그아웃 완료");
      });
    } catch(e){
      print(e);
    }
  }
}