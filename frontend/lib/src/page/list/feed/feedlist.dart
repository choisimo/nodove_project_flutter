import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/menu/submenu.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/collected/colrow.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/list/feed/feedsetting.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
import 'package:nodove_flutter/src/page/notification/noti.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:shimmer/shimmer.dart';

class FeedListPage extends StatefulWidget{
  final int? page;
  const FeedListPage({
    super.key,
    this.page
  });

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage>{
  final storage = const FlutterSecureStorage();
  late bool collected = false;
  int size = 10;
  bool search = false;

  @override
  void initState() {
    _checksettings();
    super.initState();
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
    Get.put(PageState());
    final DataSrc src = DataSrc();
    final int cateid = widget.page??int.parse(Get.parameters['page']??'0');
    final List<Widget> widgetList = [
      const SizedBox(
        height : 32,
      ),
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary
        ),
        height : 0.5,
      ),
      ListMenuBtn(
        iconSize: 12,
        iconSrc: "assets/icons/navbar/menu.svg",
        title : "카테고리",
        onClick : ()=>Navigator.of(context).push(
          MaterialPageRoute(builder: (_)=>CatePage(page: cateid))
        )
      ),
      ListMenuBtn(
        iconSize: 12,
        iconSrc: "assets/icons/navbar/hashtag.svg",
        title : "해시태그",
        onClick : (){}
      ),
      ListMenuBtn(
        iconSize: 12,
        iconSrc: "assets/icons/navbar/navi.svg",
        title : "내 위치",
        onClick : ()=>Get.to(()=>const MapPage())
      )
    ];
    
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(callback: ()=>Navigator.of(context).pop()),
      actions: [
        NavbarCommonBtn(
          "assets/icons/navbar/search.svg",
          onClick : (){
            setState((){
              search = true;
            });
          },
        ),
        NavbarCommonBtn(
          "assets/icons/navbar/menu.svg",
          onClick : (){
            key.currentState?.openEndDrawer();
          },
          width : 14,
          height : 14
        ),
      ]
    );
    
    return Scaffold(
      key: key,
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: CustomFloatingButton(
        heroTag: 'feedList',
        onClick: () => Get.to(
          ()=>const WritePage(),
          fullscreenDialog: true,
          arguments: {
            'postCategory' : cateid
          }
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        child : const CustomSvg(
          'navbar/noBorderAdd.svg',
          width : 24,
          height : 24,
          iconColor: Colors.white,
        )
      ),
      body : 
      CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
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
          SliverFillRemaining(
            child: FeedList(
              collected: collected,
              url : "${Url.apiUrl}${Url.feedList}",
              opt : "pageSize=$size&categoryId=$cateid",
              scrollEnabled: true,
            ),
          ),
        ],
      ),
      
      endDrawer: CustomDrawer(
        children: [
          FutureBuilder(
            future: src.getCateList(
              "/api/categories/getAllCategoriesByParentId/", 
              cateid.toString(),
              false
            ),
            builder:(BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.data !=null && snapshot.data.length > 0){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: ()=>Get.to(()=>const NotiPage()),
                          icon: const NavbarCommonBtn("assets/icons/navbar/alert.svg")
                        ),
                        IconButton(
                          onPressed: ()=>Get.to(()=>const FeedSettingPage()),
                          icon: const NavbarCommonBtn("assets/icons/common/setting.svg")
                        )
                      ],
                    ),
                    const Profile(profile: "",
                      width: 96,
                      height: 96,
                      borderRadius: 2,
                    ),
                    Text(
                      snapshot.data![0].categoryName,
                      style : const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      )
                    ),
                    Text(
                      '"${snapshot.data![0].categoryDescription}"',
                    ),
                    SizedBox(
                      width : MediaQuery.of(context).size.width * 0.7,
                      child : SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [...List.generate(widgetList.length, (index)=>widgetList[index])],
                        ),
                      )
                    )
                    
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator(strokeWidth: 2,));
              }
            },
          ),
        ],
      ),
    );
  }
}

class FeedList extends StatefulWidget {
  final bool collected;
  final String url;
  final String opt;
  final bool scrollEnabled;
  const FeedList({
    super.key ,
    required this.collected,
    required this.url,
    required this.opt,
    this.scrollEnabled = false,
  });
  
  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  final FeedListModel con = Get.put(FeedListModel(),permanent: false);
  ScrollController _scrollController = ScrollController();
  int pageKey = 0;

  void fetchPage() async {
    String url = widget.url;
    String opt = widget.opt;
    if (!con.isFetching.value && 
    !con.isFragFetching.value &&
    con.isLastAppend.isFalse&&
    _scrollController.position.extentAfter < 100){
      try {
        pageKey += 1;
        final newData = await con.getFeedList(pageKey,url,opt);
        final isLastPage = newData.isEmpty;
        if (!mounted) return;
        if (isLastPage) {
          con.appendLastPage(newData);
        } else {
          con.appendPage(newData);
        }
      } catch (error) {
        print(error);
      }
    }
  }


  void _initLoad() async{
    String url = widget.url;
    String opt = widget.opt;
    pageKey = 0;
    ViewPageState.page.setView(url, opt);
    con.getFeedFirst(url,opt);
  }
  
  @override
  void initState() {
    _initLoad();
    _scrollController = ScrollController()..addListener(fetchPage);
    super.initState();
  }
  @override
  void dispose() {
    ScrollController().removeListener(fetchPage);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool collected = widget.collected;
    return CustomRefreshIndicator(
      enabled : true,
      onRefresh: ()=>Future.sync(()=>_initLoad()),
      child : (collected)?
      collectedRow()
      :normalRow()
    );
  }

  Widget normalRow (){
    return Obx((){
        if(con.isFetching.isTrue){
          return  ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder:(context, index){
              return const SkelFeedRow();
            },
          );
        } else if (con.feedList.isEmpty){
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context,index) {
              return const Text("피드가 없어요");
            }
          );
        } else{
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder : (context, index) => FeedRow(props : con.feedList[index]),
            itemCount: con.feedList.length,
          );
        }
    });
  }

  Widget collectedRow(){
    return Obx((){
        if(con.isFetching.isTrue){
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        } else if (con.feedList.isEmpty){
          return ListView.builder(
            itemCount: 1,
            physics: (widget.scrollEnabled)?const AlwaysScrollableScrollPhysics():
            const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index) {
              return const Text("피드가 없어요");
            });
        } else {
          return CustomScrollView(
            controller: _scrollController,
            physics: (widget.scrollEnabled)?const AlwaysScrollableScrollPhysics():
            const NeverScrollableScrollPhysics(),
            slivers: [
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2
                ),
                itemBuilder:  (context, index)=>CollectedRow(props : con.feedList[index]),
                itemCount: con.feedList.length,
              )
            ],
          );
        }
      }
    );
  }
}

class CollectedVList extends StatefulWidget {
  final String url;
  final String opt;
  final String? title;
  const CollectedVList({
    super.key,
    required this.url,
    required this.opt,
    this.title
  });

  @override
  State<CollectedVList> createState() => _CollectedVListState();
}

class _CollectedVListState extends State<CollectedVList> {
  final FeedListModel con = Get.put(FeedListModel());

  void _initLoad() async{
    String url = widget.url;
    String opt = widget.opt;
    con.getFeedFirst(url,opt);
  }
  
  @override
  void initState(){
    _initLoad();
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title??"",
            style : TextStyle(
              fontSize : 16,
              color: Theme.of(context).colorScheme.onPrimaryFixed
            )
          )
        ),
        Obx((){
          if(con.isFetching.isTrue){
            return SizedBox(
              height : 298,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context,index){
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.surface,
                    highlightColor: Theme.of(context).colorScheme.onPrimary,
                    child: const CollectedVRowSkel()
                  );
                }
              ),
            );
          } else if(con.feedList.isEmpty){
            return const SizedBox(
              height : 298,
              child : Center(child: Text("피드가 없어요..."))
            );
          }
          else{
            return SizedBox(
              height : 298,
              child: ListView.builder(
                shrinkWrap : true,
                itemCount: con.feedList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context,index){
                  return CollectedVRow(props: con.feedList[index]);
                }
              ),
            );
          }
        })
      ],
    );
    
  }
}

/*
:ListView.builder(
  itemCount: 5,
  itemBuilder: (context, index){
    return Shimmer.fromColors(
      child: FeedRow(props: Feed.defaultState(),),
      baseColor: Theme.of(context).colorScheme.onSecondary,
      highlightColor: Theme.of(context).colorScheme.onPrimary
    );
  },
)
*/