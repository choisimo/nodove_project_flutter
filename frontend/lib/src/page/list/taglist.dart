import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/page/list/feedlist.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class TagListPage extends StatefulWidget{
  const TagListPage({super.key});

  @override
  State<TagListPage> createState() => _TagListPageState();
}

class _TagListPageState extends State<TagListPage>{
  final String tag = Get.parameters['tag']??"";
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
  Widget build(BuildContext context){
    Get.put(PageState());
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: backBtn(context,callback: (){Navigator.of(context).pop();}),
        actions : [
          navbarCommonBtn(
          context,
          "assets/icons/navbar/search.svg",
          cb : (){},
          ),
          IconButton(
            onPressed: (){
              key.currentState!.openEndDrawer();
            },
            icon: SvgPicture.asset(
              "assets/icons/navbar/menu.svg",
              width : 16 , height : 16,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
            )
          )
        ],
        shape : Border(
          bottom: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary)
        ),
      ),
      body : FeedList(
        collected: collected,
        url : "${Url.apiUrl}${Url.tagFeed}/$tag",
        opt : "pageSize=15",
        scrollEnabled: true,
      ),
      endDrawer: drawer(),
    );
  }
  Widget drawer(){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child : SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "#$tag",
              style : const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            Text(
              '"$tag를 공유한 피드들입니다"',
            ),
            SizedBox(
              height : 64,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("이미지로 보기"),
                  Switch(
                    value: collected,
                    onChanged: (b)=>
                    setState((){
                      collected = !collected;
                      storage.write(key : 'collectedView',value : collected.toString());
                    })
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}