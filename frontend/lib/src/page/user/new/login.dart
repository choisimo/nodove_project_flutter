
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/user/new/join.dart';
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
    } else{
      //Get.off(()=>const MyHome());
    }
  }

  @override
  void initState() {
    _checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context,callback: ()=>Get.back())
    );
    return Scaffold(
      appBar: NavbarTop(navbarOpt),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body : Stack(
        children: [
          FutureBuilder(
            future : token,
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              return const SafeArea(child: 
                LoginForm()
              );
            }
          ),
        ],
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              commonTextInput(
                context,
                onChanged: (str){
                  id = str;
                },
                placeholder: "아이디",
                keyboard: TextInputType.text,
              ),
              const SizedBox(height : 32),
              commonTextInput(
                context,
                onChanged: (str){
                  pw = str;
                },
                placeholder: "비밀번호",
                obscureText : true,
              ),
              const SizedBox(height : 32),
              const Text("혹시 아이디나 비밀번호를 잊어버리셨나요?"),
              const SizedBox(height : 64),
              FormCommitButton(
                width : double.infinity,
                title : "로그인",
                onPressed: () async{
                  if(id.isNotEmpty&&pw.isNotEmpty){
                    await AuthDataSrc().postLogin({
                      'userId' : id,
                      'password' : pw,
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}