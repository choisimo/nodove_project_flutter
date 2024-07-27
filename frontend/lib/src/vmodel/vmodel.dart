
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/state/url.dart';

class FeedListModel extends GetxController {
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Feed> feedList = <Feed>[].obs;

  Future<List<Feed>> getFeedList(int page,String url,String opt) async{
    final feedList = await _feedrepo.getFeedList(page,url,opt);
    return feedList;
  }
}

class UserInfoModel extends GetxController{
  final FeedRepo _feedRepo = FeedRepo();
  RxMap<String,dynamic> userInfo = <String,dynamic>{}.obs;

  Future<User> getUserInfo(id) async{
    final userInfo = await _feedRepo.getUserInfo(id);
    return userInfo;
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
  late final FeedRepo _feedrepo;
  List<Categories> _cate = List.empty();
  List<Categories> get cate => _cate;
  bool isdisposed  = false;

  @override
  void dispose(){
    isdisposed = true;
    super.dispose();
  }

  CateListModel(page){
    _feedrepo = FeedRepo();
    _getCateList(page);
  }

  Future<void> _getCateList(page) async{
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