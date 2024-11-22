import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedsetting.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class CommuListPage extends StatefulWidget{
  final int? page;
  const CommuListPage({
    super.key,
    this.page
  });

  @override
  State<CommuListPage> createState() => _CommuListPageState();
}

class _CommuListPageState extends State<CommuListPage>{
  final storage = const FlutterSecureStorage();
  late bool collected = false;
  int size = 10;
  bool search = false;
  TempFeed ccon = Get.put(TempFeed());
  final int cateid = 16;
  final List<String> categories = [
    "전체" , "공기업" , "인턴십" , "커리어" , "대외활동"
  ];

  @override
  void initState() {
    _checksettings();
    refresh();
    super.initState();
  }

  void refresh(){
    /*final int cateid = widget.page??int.parse(Get.parameters['page']??'0');
    ccon.getCate(
      page : cateid,
      url : "/api/categories/getAllCategoriesByParentId/",
      opt : cateid.toString(),
    );
    ccon.getCateOne(
      url : "/api/categories/getAllCategoriesByParentId/",
      opt : cateid.toString(),
    );*/
  }

  void _checksettings() async{
    String? c = await storage.read(key: 'collectedView');
    String? s = await storage.read(key: 'ContentSize');
    setState((){
      collected = ((c == null)||(c == 'false'))?false:true;
      size = (s != null)?int.parse(s):10;
    });
  }

  @override
  Widget build(BuildContext context){
    final int cateid = widget.page??int.parse(Get.parameters['page']??'0');
    
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("블록"),
      actions: [
        NavbarCommonBtn(
          "post/edit.svg",
          onClick: ()=>Get.to(
            ()=>const WritePage(),
            fullscreenDialog: true,
            arguments: {
              'postCategory' : cateid
            }
          ),
        ),
        NavbarCommonBtn(
          "navbar/search.svg",
          onClick : (){
            setState((){
              search = true;
            });
          },
        ),
        NavbarCommonBtn(
          "common/setting.svg",
          iconColor: Theme.of(context).colorScheme.onPrimaryFixed,
          onClick : ()=>Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=>const FeedSettingPage())
          ),
        ),
      ]
    );
    
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body : 
      CustomRefreshIndicator(
        edgeOffset : 54,
        displacement: 54,
        onRefresh: ()=>refresh(),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              leading: navbarOpt.leading,
              title: navbarOpt.title,
              actions: navbarOpt.actions,
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              shadowColor: Colors.transparent,
              elevation: 0.0,
              scrolledUnderElevation: 0.0,
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
              delegate: SliverCustomBarDelegate(
                minHeight: 48,
                maxHeight: 48,
                widget: MinimalVList(
                  list : categories,
                  onClick: (index){

                  }
                )
              ),
            ),
            FeedList(
              collected: collected,
              url : "${Url.apiUrl}${Url.feedList}",
              opt : "pageSize=$size&categoryId=$cateid",
            ),
            const SliverPadding(padding: EdgeInsets.all(32))
          ],
        ),
      ),
    );
  }
}