import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';
import 'package:nodove_flutter/src/vmodel/vsetting.dart';

class FeedSettingPage extends StatelessWidget {
  const FeedSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed: ()=>Navigator.of(context).pop(),),
      title: const NavbarTitle("피드 설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: NavbarTop(navbarOpt, centerTitle: true,),
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
  final FeedSettingModel fscon = Get.find();
  late bool collected = false;
  final int size = 10;
  late List<bool> listSelected;
  late List<bool> commuSelected;

  @override
  void initState() {
    _checkcollected();
    super.initState();
  }

  void _checkcollected() async{
    fscon.loadSetting(
      keys: [
        "feedListCount"
        "feedListSummarize"
        "communityListCount"
      ],
      onLoaded: (map)=>map.forEach((key,value){
        fscon.changeSetting(key, value);
        listSelected = [
          fscon.settings['feedListCount'] == "5",
          fscon.settings['feedListCount'] == "15" ||
              fscon.settings['feedListCount'] == "null",
          fscon.settings['feedListCount'] == "25"
        ];
        commuSelected = [
          fscon.settings['commuListCount'] == "5",
          fscon.settings['commuListCount'] == "15" ||
              fscon.settings['commuListCount'] == "null",
          fscon.settings['commuListCount'] == "25"
        ];
      })
    );
    listSelected = [false, false, false];
    commuSelected = [false, false, false];
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
            title : "일반 피드"
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
            title : "블럭 커뮤니티"
          ),
          SettingContent(
            children: [
              SettingRow(
                leading : Text(
                  "피드 갯수",
                  style: content,
                ),
                actions : SettingToggle(
                  isSelected: commuSelected,
                  children: const [
                    Text("5"),
                    Text("15"),
                    Text("25"),
                  ],
                )
              ),
            ],
          ),
          const SettingTitle(
            title : "초기화"
          ),
          SettingContent(
            children: [
              SettingRow(
                onClick: ()=>fscon.resetSetting(),
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