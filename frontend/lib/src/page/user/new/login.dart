
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();
  Future<String?> token = storage.read(key: "userToken");
  Future<String?> cookie = storage.read(key : 'refreshToken');

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(callback: ()=>Get.back())
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
              CommonTextInput(
                onChanged: (str){
                  id = str;
                },
                placeholder: "아이디",
                keyboard: TextInputType.text,
              ),
              const SizedBox(height : 32),
              CommonTextInput(
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