
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/component/oauth/kakao.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();
  Future<String?> token = storage.read(key: "userToken");
  String id = "";
  String pw = "";

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Get.back())
    );
    return Scaffold(
      appBar: NavbarTop(navbarOpt),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          width : double.infinity,
          height : 96,
          child : Column(
            children: [
              const SizedBox(
                width : double.infinity,
                height : 32,
              ),
              FormCommitButton(
                height: 54,
                width : MediaQuery.of(context).size.width * 0.75,
                title: "로그인",
                onPressed: () async{
                  if(id.isNotEmpty&&pw.isNotEmpty){
                    await AuthDataSrc().postLogin({
                      'userId' : id,
                      'password' : pw,
                    });
                  }
                },
              ),
            ],
          )
        ),
      ),
      body : Stack(
        children: [
          FutureBuilder(
            future : token,
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              return SafeArea(child: 
                LoginForm(
                  onIdChanged: (String fid)=>id = fid,
                  onPwChanged: (String fpw)=>pw = fpw,
                )
              );
            }
          ),
        ],
      )
    );
  }
}

KakaoLoginApi kakao = KakaoLoginApi();

class LoginForm extends StatelessWidget {
  final void Function(String id)? onIdChanged;
  final void Function(String pw)? onPwChanged;
  const LoginForm({super.key,this.onIdChanged,this.onPwChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SizedBox(
          width : MediaQuery.of(context).size.width * 0.9,
          height : MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SNS를 통해 로그인하기"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      IconButton(
                        style: const ButtonStyle(
                          
                        ),
                        onPressed: (){},
                        icon : const Profile(
                          profile : "assets/icons/user/Oauth.png",
                          width : 56 , height : 56
                        )
                      ),
                      const Text("구글")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: ()=>kakao.login(),
                        icon : const Profile(
                          profile : "assets/icons/user/Kakao.png",
                          width : 56 , height : 56
                        )
                      ),
                      const Text("카카오")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        onPressed: (){},
                        icon : const Profile(
                          profile : "assets/icons/user/Naver.png",
                          width : 56 , height : 56
                        )
                      ),
                      const Text("네이버")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon : const Profile(
                          profile : "assets/icons/user/Apple.png",
                          width : 56 , height : 56,
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
                      const Text("애플")
                    ],
                  ),
                ],
              ),
              const SizedBox(height : 32),
              const Text("ID를 통해 로그인하기"),
              CommonTextInput(
                onChanged: (str)=>onIdChanged?.call(str),
                placeholder: "아이디",
                keyboard: TextInputType.text,
              ),
              const SizedBox(height : 32),
              CommonTextInput(
                onChanged: (str)=>onPwChanged?.call(str),
                placeholder: "비밀번호",
                obscureText : true,
              ),
              const SizedBox(height : 32),
              const Text("혹시 아이디나 비밀번호를 잊어버리셨나요?"),
              TextButton(onPressed: (){}, child: const Text("아이디 혹은 비밀번호 찾기"))
            ],
          ),
        ),
      ),
    );
  }
}