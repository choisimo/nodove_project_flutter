import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/state/color.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static const storage = FlutterSecureStorage();
  late String? token = "";

  void _checkToken() async{
    token = await storage.read(key: "userToken");
    if(token != null){
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
      body : 
      (token != "")?
        const SafeArea(child: LoginForm())
        :SizedBox.shrink(),
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
      child: SizedBox(
        width : MediaQuery.of(context).size.width * 0.9,
        height : MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width : MediaQuery.of(context).size.width * 0.25,
              height : MediaQuery.of(context).size.width * 0.25,
              child : Image.asset(
                "assets/images/logo.png"
              )
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
                  backgroundColor: CommonStyle.first,
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
            const SizedBox(
              height : 84,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("아이디나 비밀번호를 잊어버리셨나요?"),
                  Text("아니면"),
                  Text("회원가입")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}