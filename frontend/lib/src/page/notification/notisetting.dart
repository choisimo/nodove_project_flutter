import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';

class NotiSettingPage extends StatelessWidget {
  const NotiSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title: const NavbarTitle("알림 설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(navbarOpt,centerTitle : false,),
      body: const NotiSettingList()
    );
  }
}

class NotiSettingList extends StatelessWidget {
  const NotiSettingList({super.key});

  @override
  Widget build(BuildContext context) {
    bool newFeed = true;
    TextStyle important = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.error
    );
     return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SettingTitle(
              title : "알림 필터링"
            ),
            SettingContent(
              children: [
                SettingRow(
                  leading : const Text(
                    "새 피드",
                  ),
                  actions : Switch(
                    value: newFeed,
                    onChanged: (b){
                      
                    }
                  )
                ),
                SettingRow(
                  leading : const Text(
                    "새 댓글",
                  ),
                  actions : Switch(
                    value: newFeed,
                    onChanged: (b){
                      
                    }
                  )
                ),
                SettingRow(
                  leading : const Text(
                    "광고성 메세지",
                  ),
                  actions : Switch(
                    value: newFeed,
                    onChanged: (b){
                      
                    }
                  )
                ),
              ]
            ),
            const SettingTitle(
              title : "알림 비우기"
            ),
            SettingContent(
              children: [
                SettingRow(
                  title: Text(
                    "알림 모두 지우기",
                    style: important,
                  ),
                  onClick: (){},
                )
              ]
            )
          ],
        ),
    );
  }
}