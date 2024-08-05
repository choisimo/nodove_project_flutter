import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/menu/submenu.dart';
import 'package:nodove_flutter/src/view/collected/colrow.dart';
import 'package:nodove_flutter/src/view/list/feedrow.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/view/post/write.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:shimmer/shimmer.dart';

class FeedListPage extends StatefulWidget{
  const FeedListPage({super.key});

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage>{
  final int cateid = int.parse(Get.parameters['page']??'0');
  final storage = const FlutterSecureStorage();
  late bool collected = false;
  final int size = 15;

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
    GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        leading: backBtn(context),
        actions : [
          searchBtn(context),
          IconButton(
            onPressed: (){
              _key.currentState!.openEndDrawer();
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
      floatingActionButton: plusButton(),
      body : FeedList(
        collected: collected,
        url : "${Url.apiUrl}${Url.feedList}",
        opt : "pageSize=$size&categoryId=$cateid"
      ),
      endDrawer: drawer(cateid),
    );
  }
  Widget drawer(id){
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,

      child : ListView(
        children: [
          const MenuTitle(title: "이미지로 보기"),
          Switch(
            value: collected,
            onChanged: (b)=>
            setState((){
              collected = !collected;
              storage.write(key : 'collectedView',value : collected.toString());
            })
          )
        ],
      )
    );
  }
  Widget plusButton(){
    return FloatingActionButton(
      onPressed: (){
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_)=>const WritePage()
            )
        );
      },
      backgroundColor: CommonStyle.first,
      child : SvgPicture.asset(
        'assets/icons/navbar/noBorderAdd.svg',
        width : 24,
        height : 24,
        colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn),
      )
    );
  }
}

class FeedList extends StatefulWidget {
  final bool collected;
  final String url;
  final String opt;
  const FeedList({
    super.key ,
    required this.collected,
    required this.url,
    required this.opt,
  });
  
  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  Dio dio = Dio();

  bool firstPageFetched = true;
  final FeedListModel _con = Get.put(FeedListModel());
  final PagingController<int, Feed> _pagingController = PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    String url = widget.url;
    String opt = widget.opt;
    try {
      final newData = await _con.getFeedList(pageKey,url,opt);
      final isLastPage = newData.isEmpty;
      if (!mounted) return;
      if (isLastPage) {
        _pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool collected = widget.collected;
    return (collected)?
    collectedRow()
    :normalRow();
  }

  Widget normalRow (){
    return RefreshIndicator(
      color : Theme.of(context).colorScheme.onSurface,
      backgroundColor : Theme.of(context).colorScheme.onPrimary,
      onRefresh: ()=>Future.sync(()=>_pagingController.refresh()),
      child : 
      PagedListView<int,Feed>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Feed>(
          itemBuilder : (con,item,index) => FeedRow(props : item),
      )
      )
    );
  }
  Widget collectedRow(){
    return RefreshIndicator(
      color : Theme.of(context).colorScheme.onSurface,
      backgroundColor : Theme.of(context).colorScheme.onPrimary,
      onRefresh: ()=>Future.sync(()=>_pagingController.refresh()),
      child : PagedGridView<int,Feed>(
        pagingController: _pagingController,
        gridDelegate : const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<Feed>(
          itemBuilder : (con,item,index) => CollectedRow(props : item)
        ),
      ),
    );
  }
}

class CollectedVList extends StatefulWidget {
  final String url;
  final String opt;
  const CollectedVList({
    super.key,
    required this.url,
    required this.opt
  });

  @override
  State<CollectedVList> createState() => _CollectedVListState();
}

class _CollectedVListState extends State<CollectedVList> {
  final FeedListModel _con = Get.put(FeedListModel());
  late dynamic  list = [];
  
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future : _con.getFeedList(0,widget.url,widget.opt),
      builder: (BuildContext context,AsyncSnapshot snapshot) {
        print(snapshot.data.toString());
        return
        (snapshot.data != null)? 
        SizedBox(
          height : 298,
          child: ListView.builder(
            shrinkWrap : true,
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder:(context,index){
              return CollectedVRow(props: snapshot.data[index]);
            }
          ),
        ):const Center(
          child : CircularProgressIndicator(
            strokeWidth: 2,
          )
        );
      }
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