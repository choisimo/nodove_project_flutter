import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/state/color.dart';
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
  int pageKey = 0;
  TempFeed ccon = Get.put(TempFeed());

  @override
  void initState() {
    _checkcollected();
    super.initState();
  }

  void _initLoad() async{
    String url = "${Url.apiUrl}${Url.tagFeed}/$tag";
    String opt = "pageSize=15";
    pageKey = 0;
    PageState.page.setView(url, opt);
    //con.getFeedFirst(url,opt);
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
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed: ()=>Navigator.of(context).pop()),
      actions: [
        NavbarCommonBtn(
          "navbar/search.svg",
          onClick : (){
          },
        ),
      ]
    );
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body : CustomScrollView(
        slivers : [
          SliverAppBar(
            leading: navbarOpt.leading,
            title: navbarOpt.title,
            actions: navbarOpt.actions,
            scrolledUnderElevation: 0.0,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: const FlexibleSpaceBar(
                centerTitle: true,
              ),
            ),
          ),
          ),
          SliverPersistentHeader(
            floating: true,
            delegate: SliverCustomBarDelegate(
              minHeight: 64,
              maxHeight: 64,
              widget : Container(
                width: double.infinity,
                height : 64,
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: rowBorderLine()
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "#$tag",
                            style : const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            )
                          ),
                          Text(
                            '#$tag 해시태그를 공유한 피드들입니다',
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: (){},
                        style : OutlinedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape : RoundedRectangleBorder(
                            borderRadius: RowContainer.radius,
                            side : BorderSide(
                              color: Theme.of(context).colorScheme.onPrimaryFixed
                            )
                          )
                        ),
                        child: const Text(
                          "구독",
                        ),
                      )
                    ],
                  ),
                ),
              )
            ),
          ),
          FeedList(
            key : Key("tag-page-key-$tag"),
            collected: collected,
            feed: ccon.tagList[tag]??[Feed.defaultState()],
            //onFeedClick: (id)=>Get.to(()=>FeedPage(feed: ccon.tagList[tag]![id],)),
          ),
        ],
      ),
    );
  }
}

/*
child: Row(
                  children: [
                    Column(
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
                      ],
                    ),
                  ],
                ),
*/