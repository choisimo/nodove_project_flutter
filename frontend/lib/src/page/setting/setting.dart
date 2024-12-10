import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedsetting.dart';
import 'package:nodove_flutter/src/page/user/member/editpage.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Navigator.of(context).pop()),
      title: const NavbarTitle("설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: NavbarTop(navbarOpt,centerTitle : true,),
      body: const SettingView()
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainSettingView();
  }
}

class MainSettingView extends StatelessWidget {
  const MainSettingView({super.key});

  @override
  Widget build(BuildContext context) {
     TextStyle content = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    return SingleChildScrollView(
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingContent(
            children: [
              
              SettingRow(
                title : Text(
                  "피드",
                  style: content,
                ),
                onClick: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const FeedSettingPage())
                ),
              ),
              SettingRow(
                title : Text(
                  "메신저",
                  style: content,
                ),
              ),
              SettingRow(
                title : Text(
                  "채용",
                  style: content,
                ),
              ),
              SettingRow(
                title : Text(
                  "계정",
                  style: content,
                ),
                onClick: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const EditUserPage())
                ),
              ),
              SettingRow(
                title : Text(
                  "앱 정보",
                  style: content,
                ),
                onClick: ()=>Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=>const AppInfoView())
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}

class AppInfoView extends StatelessWidget {
  const AppInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle content = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed: ()=>Navigator.of(context).pop(),),
      title: const NavbarTitle("앱 정보")
    );
    return Scaffold(
      appBar: NavbarTop(navbarOpt,centerTitle: true,),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SingleChildScrollView(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingTitle(
              title: "앱 정보"
            ),
            SettingContent(
              children: [
                SettingRow(
                  leading : Text(
                    "앱 이름",
                    style: content,
                  ),
                  actions: const Text("커리어블록"),
                ),
                SettingRow(
                  leading : Text(
                    "앱 버전",
                    style: content,
                  ),
                  actions: const Text("1.0.0"),
                ),
                
              ],
            ),
            const SettingTitle(
              title: "기타 정보"
            ),
            SettingContent(
              children: [
                SettingRow(
                  title : Text(
                    "도움말",
                    style: content,
                  ),
                ),
                SettingRow(
                  title : Text(
                    "개인정보처리방침",
                    style: content,
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}
