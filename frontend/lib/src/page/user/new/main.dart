
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/component/oauth/kakao.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/user/new/join.dart';
import 'package:nodove_flutter/src/page/user/new/login.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({super.key});

  @override
  State<LoginMainPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginMainPage> {
  static const storage = FlutterSecureStorage();
  bool loaded = false;
  Future<String?> token = storage.read(key: "userToken");
  Future<String?> cookie = storage.read(key : 'refreshToken');

  void _checkToken() async{
    if(await token != null&&await cookie != null){
        final user = Get.put(UserState());

      final res = await decoding(await token,await cookie);
      if (res['parsed'] != null){
        user.setIndex(res['parsed']['userId']);
        Get.off(()=>const MyHome());
      } else {
        setState((){loaded = true;});
        print("아이디 찾기 오류");
      }
    } else{
      //setState((){loaded = true;});
      Get.off(()=>const MyHome());
    }
  }

  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body : Stack(
        children: [
          /*Container(
            decoration: const BoxDecoration(
              image : DecorationImage(
                image : ExactAssetImage(
                  "assets/images/background.jpg",
                ),
                fit : BoxFit.fitHeight,
                alignment: Alignment(-0.5,0)
              )
            ),
            child : BackdropFilter(
              filter : ImageFilter.blur(sigmaX: 10 , sigmaY: 10),
              child: const SizedBox(
                width : double.infinity,
                height : double.infinity
              )
            ),
          ),*/
          FutureBuilder(
            future : token,
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              return SafeArea(child: (loaded)?const LoginMainForm():const SizedBox.shrink());
            }
          ),
        ],
      )
    );
  }
}

class LoginMainForm extends StatelessWidget {
  const LoginMainForm({super.key});

  @override
  Widget build(BuildContext context) {
    KakaoLoginApi kakao = KakaoLoginApi();
    final maxwidth = MediaQuery.of(context).size.width;
    final maxheight = MediaQuery.of(context).size.height;
    return Center(
      child: SingleChildScrollView(
        child: 
        SizedBox(
          width : maxwidth * 0.9,
          height : maxheight * 0.5,
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width : MediaQuery.of(context).size.width * 0.25,
              height : MediaQuery.of(context).size.width * 0.25,
              child : Image.asset(
                "assets/images/logo.png"
              )
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      style: const ButtonStyle(
                        
                      ),
                      onPressed: (){},
                      icon : Image.asset(
                        "assets/icons/user/Oauth.png",
                        width : 42 , height : 42
                      )
                    ),
                    IconButton(
                      onPressed: ()=>kakao.login(),
                      icon : Image.asset(
                        "assets/icons/user/Kakao.png",
                        width : 42 , height : 42
                      )
                    ),
                    IconButton(
                      onPressed: (){},
                      icon : Image.asset(
                        "assets/icons/user/Naver.png",
                        width : 42 , height : 42
                      )
                    ),
                    IconButton(
                      icon : Image.asset(
                        "assets/icons/user/Apple.png",
                        width : 42 , height : 42,
                      ),
                      onPressed: () async {
                        await SignInWithApple.getAppleIDCredential(
                          scopes: [
                            AppleIDAuthorizationScopes.email,
                            AppleIDAuthorizationScopes.fullName,
                          ],
                        );
                      },
                    ),
                    const Text("로 로그인")
                  ],
                ),
                FormCommitButton(
                  width : maxwidth * 0.8,
                  height : 48,
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  onPressed: ()=>Get.to(
                    ()=>const JoinPage(page : 0),
                  ),
                  title : "새로 시작하기"
                )
              ],
            ),
            Column(
              children: [
                FormCommitButton(
                  height : 48,
                  backgroundColor: Theme.of(context).colorScheme.onSecondary,
                  onPressed: ()=>Get.to(
                    ()=>const LoginPage(),
                  ),
                  title : "로그인",
                ),
                const SizedBox(height : 16),
              ],
            ),
            
          ],
        ),
      ),)
    );
  }
}