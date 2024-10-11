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

class NotiSettingList extends StatefulWidget {
  const NotiSettingList({super.key});

  @override
  State<NotiSettingList> createState() => _NotiSettingListState();
}

class _NotiSettingListState extends State<NotiSettingList> {
  @override
  Widget build(BuildContext context) {
    bool newFeed = true;
    TextStyle title = TextStyle(
      fontSize : 14,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface
    );
    TextStyle content = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    );
    TextStyle important = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Theme.of(context).colorScheme.error
    );
    return SingleChildScrollView(
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            child: Text(
              "알림 필터링",
              style: title,
            ),
          ),
          notiRow(
            context,
            leading : Text(
              "새 피드",
              style: content,
            ),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : Text(
              "새 댓글",
              style: content,
            ),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : Text(
              "광고성 메세지",
              style: content,
            ),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          notiRow(
            context,
            leading : Text(
              "허",
              style: content,
            ),
            actions : Switch(
              value: newFeed,
              onChanged: (b){
                
              }
            )
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "알림 지우기",
              style: title,
            ),
          ),
          GestureDetector(
            onTap : (){},
            child: notiRow(
              context,
              title: Text(
                "알림 모두 지우기",
                style: important,
              ),
            ),
          ),
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