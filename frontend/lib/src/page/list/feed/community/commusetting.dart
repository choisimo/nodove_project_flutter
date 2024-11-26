import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';

class FeedCommuSettingPage extends StatelessWidget {
  const FeedCommuSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title: const NavbarTitle("커뮤니티 설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(navbarOpt, centerTitle: false,),
      body: const FeedCommuSettingList()
    );
  }
}

class FeedCommuSettingList extends StatefulWidget {
  const FeedCommuSettingList({super.key});

  @override
  State<FeedCommuSettingList> createState() => _FeedCommuSettingListState();
}

class _FeedCommuSettingListState extends State<FeedCommuSettingList> {
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
          const SettingTitle(
            title : "형식"
          ),
          SettingContent(
            children: [
              SettingRow(
                leading : Text(
                  "간략하게",
                  style: content,
                ),
                actions : SettingSwitch(
                  value: collected,
                  onChanged: (b)=>
                  setState((){
                    collected = !collected;
                    storage.write(key : 'collectedView',value : collected.toString());
                  })
                )
              ),
              SettingRow(
                leading : Text(
                  "피드 갯수",
                  style: content,
                ),
                actions : const Text("선택")
              ),
            ],
          ),
          const SettingTitle(
            title : "초기화"
          ),
          SettingContent(
            children: [
              SettingRow(
                onClick: (){},
                title: Text(
                  "설정 초기화",
                  style: important,
                ),
              )
            ],
          )
        ],
      )
    );
  } 
}