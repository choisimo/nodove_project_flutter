import 'package:flutter/material.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';

class NotiSettingPage extends StatelessWidget {
  const NotiSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title: navbarTitle(context, "알림 설정", 18)
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false,),
      body: const NotiSettingList()
    );
  }
}

class NotiSettingList extends StatelessWidget {
  const NotiSettingList({super.key});

  @override
  Widget build(BuildContext context) {
    bool newFeed = true;
    return SingleChildScrollView(
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: const Text(
              "알림 필터링",
              style: TextStyle(
                fontSize : 18,
              ),
            ),
          ),
          notiRow(
            context,
            leading : navbarTitle(context,"새 피드",18),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : navbarTitle(context,"새 댓글",18),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : navbarTitle(context,"광고성 메세지",18),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : navbarTitle(context,"응애",18),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          )
        ],
      )
    );
  }
  Widget notiRow(
    BuildContext context,{
      Widget? title,
      Widget? leading,
      Widget? actions,
    }){

    return Container(
      height : 42,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color : Theme.of(context).colorScheme.shadow,
            offset: RowContainer.offset,
            blurRadius: RowContainer.blurRadius
          )
        ],
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child: Center(child: leading),
              ),
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child: Center(child: title),
              ),
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child : Center(child: actions)
              )
            ],
          );
        }
      )
    );
  }
}