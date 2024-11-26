import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/collected/colrow.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedsetting.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
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
  TempFeed ccon = Get.put(TempFeed());

  @override
  void initState() {
    _checksettings();
    refresh();
    _initLoad();
    scrollController = ScrollController()..addListener(fetchPage);
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

  ScrollController scrollController = ScrollController();
  int pageKey = 0;

  void fetchPage() async {
    /*String url = widget.url;
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
    }*/
  }


  void _initLoad() async{
    final int cateid = widget.page??int.parse(Get.parameters['page']??'0');
    String url = "${Url.apiUrl}${Url.feedList}";
    String opt = "pageSize=$size&categoryId=$cateid";
    pageKey = 0;
    PageState.page.setView(url, opt);
    //con.getFeedFirst(url,opt);
  }

  @override
  void dispose() {
    scrollController.removeListener(fetchPage);
    super.dispose();
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
    
    final int cateid = widget.page??int.parse(Get.parameters['page']??'0');
    final feed = (cateid == 0)?ccon.feedList:(cateid == 1)?ccon.feedListb:ccon.feedListc;
    
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed: ()=>Navigator.of(context).pop()),
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
      bottomNavigationBar: FeedBottomNavbar(cate : ccon.currentCate.value),
      body : 
      CustomRefreshIndicator(
        edgeOffset : 54,
        displacement: 54,
        onRefresh: ()=>refresh(),
        child: CustomScrollView(
          controller: scrollController,
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
            /*SliverPersistentHeader(
              delegate: SliverCustomBarDelegate(
                widget: MinimalVList(
                  list : ccon.catelist[0].children!.map((dynamic cate)=>cate.categoryName).toList(),
                  onClick: (index)=>
                  Get.to(
                    ()=>FeedListPage(page : ccon.catelist[0].children?[index].categoryId),
                    preventDuplicates: false
                  )
                )
              ),
            ),*/
            FeedList(
              collected: collected,
              feed: feed,
              onCommentClick: (id)=>showCustomModal(context, CommentListModal(page: id,)),
              onFeedClick: (id)=>Get.to(()=>FeedPage(feed: feed[id],)),
            ),
            const SliverPadding(padding: EdgeInsets.all(32))
          ],//Get.toNamed("/view/$id")
        ),
      ),
    );
  }
}
//

class FeedList extends StatelessWidget {
  final bool collected;
  final List<Feed> feed;
  final bool shortContent;
  final Function(int id)? onFeedClick;
  final Function(int id)? onCommentClick;
  const FeedList({
    super.key ,
    required this.collected,
    required this.feed,
    this.shortContent = true,
    this.onCommentClick,
    this.onFeedClick,
  });
  

  @override
  Widget build(BuildContext context) {
    TempFeed con = Get.put(TempFeed());
    if(con.isFetching.isTrue){
      return  SliverList.builder(
        itemCount: 3,
        itemBuilder:(context, index){
          return const SkelFeedRow();
        },
      );
    } else if (feed.isEmpty){
      return const SliverToBoxAdapter(
        child: Center(
          child: Text("피드가 없어요"),
        ),
      );
    } else{
      if (collected){
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2
          ),
          itemBuilder:  (context, index)=>CollectedRow(feed : feed[index]),
          itemCount: feed.length,
        );
      } else {
        return SliverList.builder(
          itemBuilder : (context, index) => 
          FeedRow(
            feed : feed[index],
            onCommentClick: onCommentClick,
            onFeedClick: onFeedClick,
            shortContent: shortContent,
          ),
          itemCount: feed.length,
        );
      }
    }
    /*return CustomRefreshIndicator(
      enabled : true,
      onRefresh: ()=>Future.sync(()=>_initLoad()),
      child : Obx((){
        if (collected){
          return collectedRow();
        } else{
          return normalRow();
        }
      })
    );*/
  }
}

class CollectedVList extends StatelessWidget {
  final List<Feed> feed;
  final String? title;
  final Function(int id)? onFeedClick;
  const CollectedVList({
    super.key,
    required this.feed,
    this.title,
    this.onFeedClick
  });

  @override
  Widget build(BuildContext context) {
    TempFeed con = Get.find();
    return Column(
      children: [
        (title != null)?Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title??"",
            style : TextStyle(
              fontSize : 16,
              color: Theme.of(context).colorScheme.onPrimaryFixed
            )
          )
        ):const SizedBox.shrink(),
        Obx((){
          if(con.isFetching.isTrue){
            return SizedBox(
              height : 200,
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
          } else if(feed.isEmpty){
            return const SizedBox(
              height : 200,
              child : Center(child: Text("피드가 없어요..."))
            );
          }
          else{
            return SizedBox(
              height : 200,
              child: Align(
                alignment: Alignment.centerLeft,
                child: ListView.builder(
                  shrinkWrap : true,
                  itemCount: feed.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    return CollectedVRow(
                      feed: feed[index],
                      onFeedClick: onFeedClick,
                    );
                  }
                ),
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
      child: FeedRow(feed: Feed.defaultState(),),
      baseColor: Theme.of(context).colorScheme.onSecondary,
      highlightColor: Theme.of(context).colorScheme.onPrimary
    );
  },
)
*/