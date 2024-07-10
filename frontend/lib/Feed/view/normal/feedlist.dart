import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/Feed/repo/repo.dart';
import 'package:nodove_flutter/Feed/view/normal/feedrow.dart';
import 'package:nodove_flutter/Feed/vmodel/vmodel.dart';
import 'package:nodove_flutter/navbar.dart';
import 'package:nodove_flutter/Feed/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget{
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: navbarTop(context),
      bottomNavigationBar: navbarBottom(context),
      floatingActionButton: writeButton(),
      body : ChangeNotifierProvider<FeedViewModel>(
        create : (context) => FeedViewModel(),
        child : const FeedList(categoryId: 3)
      ),
    );
  }
  Widget writeButton(){
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
  final int categoryId;
  const FeedList({super.key , required this.categoryId});
  
  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  Dio dio = Dio();
  final size = 5;
  final cateid = 3;
  final url = "https://gcp.nodove.com/api/getPostByList/";
  FeedRepo _repo = FeedRepo();
  late List<Feed> feedList;
  final PagingController<int, Feed> _pagingController =
    PagingController(firstPageKey: 0);

  Future<void> _initLoad() async {

  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newData = await _repo.getFeedList(pageKey, size, cateid, url);
      final isLastPage = newData.isEmpty;
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
    return RefreshIndicator(
      onRefresh: () => _initLoad(),
      child : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child : PagedListView<int,Feed>(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<Feed>(
                itemBuilder : (con,item,index) => FeedRow(props : item)
              ),
            )
      )
    );
  }
}

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