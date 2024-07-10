
import 'package:flutter/material.dart';
import 'package:nodove_flutter/Feed/model/feed.dart';
import 'package:nodove_flutter/Feed/repo/repo.dart';

class FeedViewModel with ChangeNotifier{
  late final FeedRepo _feedrepo;
  List<Feed> _feedList = List.empty(growable: true);
  List<Feed> get feedList => _feedList;
  int page = 0;
  int pagesize = 5;
  int cateid = 15;
  String url = "https://gcp.nodove.com/api/getPostByList/";

  FeedViewModel(){
    _feedrepo = FeedRepo();
    _getFeedList(page,pagesize,cateid,url);
  }

  Future<void> _getFeedList(int pageKey,int size,int cateid,String url) async{
    _feedList = await _feedrepo.getFeedList(pageKey,pagesize,cateid,url);
    notifyListeners();
  }
}