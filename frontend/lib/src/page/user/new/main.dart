

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/main.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/user/new/join.dart';
import 'package:nodove_flutter/src/page/user/new/login.dart';
import 'package:nodove_flutter/state/user.dart';

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
      final UserState user = Get.find();

      final res = await decoding(await token,await cookie);
      if (res['parsed'] != null){
        user.setIndex(res['parsed']['userId']);
        Get.off(()=>const MyHome());
      } else {
        setState((){loaded = true;});
        //Get.off(()=>const MyHome());
      }
    } else{
      setState((){loaded = true;});
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
    final maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
      ),
      bottomNavigationBar: SizedBox(
        height : 172,
        child: Column(
          children: [
            FormCommitButton(
              width : maxwidth * 0.8,
              height : 48,
              onPressed: ()=>Get.to(
                ()=>const JoinPage(),
              ),
              title : "새로 시작하기"
            ),
            const SizedBox(height : 16),
            FormCommitButton(
              width : maxwidth * 0.8,
              height : 48,
              onPressed: ()=>Get.to(
                ()=>const LoginPage(),
              ),
              title : "로그인"
            ),
          ],
        ),
      ),
    );
  }
}

class LoginMainForm extends StatelessWidget {
  const LoginMainForm({super.key});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
    return Center(
      child: SingleChildScrollView(
        child: 
        SizedBox(
          width : maxwidth * 0.9,
          child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width : MediaQuery.of(context).size.width,
              height : MediaQuery.of(context).size.width * 0.25,
              child : Image.asset(
                "assets/images/main_logo.png"
              )
            ),
          ],
        ),
      ),)
    );
  }
}