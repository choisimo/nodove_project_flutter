import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/src/view/collected/colrow.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class FeedListPage extends StatefulWidget{
  const FeedListPage({super.key});

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage>{
  final int cateid = int.parse(Get.parameters['page']??'0');
  final bool collected = false;
  final int size = 15;
  final String url = "${Url.apiUrl}${Url.feedList}";

  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context),
      actions : [
        searchBtn(context),
        
        etcBtn(
          context,
          (id){
            
          },
          cateid
        )
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,true),
      floatingActionButton: plusButton(),
      body : FeedList(
        cateId: cateid,
        collected : collected,
        url : url,
      )
    );
  }
  Widget plusButton(){
    return FloatingActionButton(
      onPressed: (){},
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
  final int? cateId;
  final bool collected;
  final String url;

  const FeedList({super.key ,
  required this.cateId,
  required this.collected,
  required this.url
  });
  
  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  Dio dio = Dio();
  final size = 10;
  late List<Feed> feedList;

  final PagingController<int, Feed> _pagingController = PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newData = await FeedRepo().getFeedList(pageKey,widget.url,"pageSize=$size&categoryId=${widget.cateId}");
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
    return (widget.collected)?
    collectedRow()
    :normalRow();
  }

  Widget normalRow (){
    return RefreshIndicator(
      color : Theme.of(context).colorScheme.onSurface,
      backgroundColor : Theme.of(context).colorScheme.onPrimary,
      onRefresh: ()=>Future.sync(()=>_pagingController.refresh()),
      child : PagedListView<int,Feed>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Feed>(
          itemBuilder : (con,item,index) => FeedRow(props : item)
        ),
      )
    );
  }
  Widget collectedRow(){
    return RefreshIndicator(
      onRefresh: ()=>Future.sync(()=>_pagingController.refresh()),
      child : Builder(
        builder: (context) {
          return PagedGridView<int,Feed>(
            pagingController: _pagingController,
            gridDelegate : const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2
            ),
            builderDelegate: PagedChildBuilderDelegate<Feed>(
              itemBuilder : (con,item,index) => CollectedRow(props : item)
            ),
          );
        }
      )
    );
  }
}
//CollectedRow
/*
ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feedList.length,
              itemBuilder: (BuildContext cont,int index){
                return FeedRow(props : feedList[index]);
              }
            );
*/