
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/state/url.dart';

class FeedViewModel with ChangeNotifier{
  late final FeedRepo _feedrepo;
  List<Feed> _feedList = List.empty(growable: true);
  List<Feed> get feedList => _feedList;
  int page = 0;
  int pagesize = 5;
  int cateid = Get.arguments;
  String url = "${Url.apiUrl}/getPostByList/";

  FeedViewModel(page,url,opt){
    _feedrepo = FeedRepo();
    _getFeedList(page,url,opt);
  }

  Future<void> _getFeedList(int page,String url,String opt) async{
    _feedList = await _feedrepo.getFeedList(page,url,opt);
    notifyListeners();
  }
}

class PageViewModel with ChangeNotifier{
  final int page = int.parse(Get.parameters['page']??'3');
  final String url = "${Url.apiUrl}/getPostByPostId";
  late final FeedRepo _feedrepo;
  Feed _feed = Feed.defaultState();
  Feed get feed => _feed;
  bool isdisposed  = false;

  PageViewModel(){
    _feedrepo = FeedRepo();
    _getFeedList(page,url);
  }

  @override
  void dispose(){
    isdisposed = true;
    super.dispose();
  }

  Future<void> _getFeedList(int page,String url) async{
    _feed = await _feedrepo.getFeedPage(page,url);
    notifyListeners();
  }
  
  @override
  void notifyListeners() {
    if (!isdisposed){
      super.notifyListeners();
    }
  }
}

class CateListModel with ChangeNotifier{
  final int page = int.parse(Get.parameters['page']??'0');
  late final FeedRepo _feedrepo;
  List<Categories> _cate = List.empty();
  List<Categories> get cate => _cate;
  bool isdisposed  = false;
  @override
  void dispose(){
    isdisposed = true;
    super.dispose();
  }

  CateListModel(){
    _feedrepo = FeedRepo();
    _getCateList();
  }

  Future<void> _getCateList() async{
    if (page > 0){
      String opt = "";
      String url = "${Url.apiUrl}/categories/getAllCategoriesByParentId/$page";
      _cate = await _feedrepo.getCateList(url,opt,true);
    } else {
      String opt = "";
      String url = "${Url.apiUrl}/categories/getDepth1Categories";
      _cate = await _feedrepo.getCateList(url,opt,false);
    }
    notifyListeners();
  }
  
  @override
  void notifyListeners() {
    if (!isdisposed){
      super.notifyListeners();
    }
  }
}