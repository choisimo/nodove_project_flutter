import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/page/user/join.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();
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
        print("아이디 찾기 오류");
      }
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
      body : FutureBuilder(
        future : token,
        builder: (BuildContext context,AsyncSnapshot snapshot) {
          return SafeArea(child: 
          (snapshot.hasData)?
          const SizedBox.shrink()
          :const LoginForm()
          );
        }
      )
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    String id = "";
    String pw = "";
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width : MediaQuery.of(context).size.width * 0.9,
          height : MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width : MediaQuery.of(context).size.width * 0.25,
                height : MediaQuery.of(context).size.width * 0.25,
                child : Image.asset(
                  "assets/images/logo.png"
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 IconButton(
                    onPressed: (){},
                    icon : Image.asset(
                      "assets/icons/user/Oauth.png",
                      width : 42 , height : 42
                    )
                  ),
                  IconButton(
                    onPressed: (){},
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
              TextFormField(
                onChanged: (str){
                  id = str;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: RowContainer.radius,
                    borderSide: BorderSide(
                      color : Theme.of(context).colorScheme.secondary,
                      width : 1
                    )
                  ),
                  focusColor: Colors.transparent,
                  hintText: "아이디",
                  hintStyle: TextStyle(
                    color : Theme.of(context).colorScheme.onSurface
                  )
                ),
                keyboardType: TextInputType.text,
              ),
              TextFormField(
                onChanged: (str){
                  pw = str;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: RowContainer.radius,
                    borderSide: BorderSide(
                      color : Theme.of(context).colorScheme.secondary,
                      width : 1
                    )
                  ),
                  hintText: "비밀번호",
                  hintStyle: TextStyle(
                    color : Theme.of(context).colorScheme.onSurface
                  )
                ),
                obscureText : true 
              ),
              SizedBox(
                width : double.infinity,
                height : 48,
                child: TextButton(
                  style : TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    shape: const RoundedRectangleBorder(
                      borderRadius: RowContainer.radius,
                      
                    ),
                  ),
                  onPressed: () async{
                    if(id.isNotEmpty&&pw.isNotEmpty){
                      await DataSrc().PostLogin({
                        'userId' : id,
                        'password' : pw,
                      });
                    }
                  },
                  child: const Text(
                    "로그인",
                    style: TextStyle(
                      fontSize : 20,
                      fontWeight: FontWeight.bold,
                      color : Colors.white
                    ),
                  ),
                ),
              ),
              SizedBox(
                height : 84,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height : 48,
                      child: TextButton(
                        style : TextButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                          shape: const RoundedRectangleBorder(
                            borderRadius: RowContainer.radius,
                          ),
                        ),
                        onPressed: ()=>Get.to(
                          ()=>const JoinPage(page : 0),
                        ),
                        child: const Text(
                          "새로 가입하기",
                          style: TextStyle(
                            fontSize : 16,
                            fontWeight: FontWeight.bold,
                            color : Colors.white
                          ),
                        ),
                      ),
                    ),
                    const Text("혹시 아이디나 비밀번호를 잊어버리셨나요?"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}