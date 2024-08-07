
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/state/url.dart';

class InitViewModel implements Bindings{
  @override
  void dependencies(){
    Get.lazyPut<FeedListModel>(()=> FeedListModel());
    Get.lazyPut<CommentPageModel>(()=> CommentPageModel());
    Get.lazyPut<UserInfoModel>(()=> UserInfoModel());
  }
}

class FeedListModel extends GetxController {
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Feed> feedList = <Feed>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;

  Future<void> getFeedFirst(String url,String opt) async{
    isFetching(true);
    final list = await _feedrepo.getFeedList(0,url,opt);
    isFetching(false);

    if (list.isNotEmpty) feedList(list);
  }

  Future<List<Feed>> getFeedList(int page,String url,String opt) async{
    final list = await _feedrepo.getFeedList(page,url,opt);
    return feedList(list);
  }
}

class FeedImageModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<String> imageList = <String>[].obs;
  void postImages(List<XFile> images) async{
    final list = await _feedrepo.postImagesRepo(images);
    imageList.addAll(list);
  }
  void postVideo(XFile video) async{
    final list = await _feedrepo.postImagesRepo([video]);
    imageList.addAll(list);
  }
}

class CommentPageModel extends GetxController {
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Comment> commentList = <Comment>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  int maxPage = 5;
  int page = int.parse(Get.parameters['page']??'3');
  

  Future<void> getCommentFirst() async{
    String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";
    isFetching(true);
    final list = await _feedrepo.getCommentPage(0,url,"maxSize=$maxPage");
    isFetching(false);

    if (list.isNotEmpty) commentList(list);
  }
  Future<List<Comment>> fetchCommentFrag(int page) async{
    String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";
    isFragFetching(true);
    final list = await _feedrepo.getCommentPage(page,url,"maxSize=$maxPage");
    isFragFetching(false);
    return list;
  }
  Future<void> appendLastPage(List<Comment> newData) async{
    commentList.addAll(newData);
  }
  Future<void> appendPage(List<Comment> newData) async{
    commentList.addAll(newData);
  }
  Future<void> postComment(Map<String,dynamic> formData) async{
    await _feedrepo.postComment(formData);
    commentList.refresh();
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