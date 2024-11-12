import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';

class FeedSettingPage extends StatelessWidget {
  const FeedSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title: const NavbarTitle("피드 설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: NavbarTop(navbarOpt, centerTitle: false,),
      body: const FeedSettingList()
    );
  }
}

class FeedSettingList extends StatefulWidget {
  const FeedSettingList({super.key});

  @override
  State<FeedSettingList> createState() => _FeedSettingListState();
}

class _FeedSettingListState extends State<FeedSettingList> {
  final storage = const FlutterSecureStorage();
  late bool collected = false;
  final int size = 10;

  @override
  void initState() {
    _checkcollected();
    super.initState();
  }

  void _checkcollected() async{
    String? c = await storage.read(key: 'collectedView');
    setState((){
      collected = ((c == null)||(c == 'false'))?false:true;
    });
  }
  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: RowContainer.radius,
      border : Border.all(
        color: Theme.of(context).colorScheme.onSurface,
        width: 0.5
      )
    );
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
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "피드 형식",
              style: title,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: rowBorderLine()
              )
            ),
            child: notiRow(
              context,
              leading : Text(
                "간략하게",
                style: content,
              ),
              actions : Switch(
                value: collected,
                onChanged: (b)=>
                setState((){
                  collected = !collected;
                  storage.write(key : 'collectedView',value : collected.toString());
                })
              )
            ),
          ),
          notiRow(
            context,
            leading : Text(
              "피드 갯수",
              style: content,
            ),
            actions : const Text("선택")
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              "초기화",
              style: title,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: rowBorderLine()
              )
            ),
            child : GestureDetector(
            onTap : (){},
            child: notiRow(
                context,
                title: Text(
                  "설정 초기화",
                  style: important,
                ),
              ),
            ),
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
        border: Border(
          bottom: rowBorderLine()
        ),
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