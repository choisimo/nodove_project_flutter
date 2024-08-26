
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/model/user.dart';

class FeedRepo{
  final DataSrc _source = DataSrc();

  Future<List<Feed>?> getFeedList(pageKey,url,opt) {
    return _source.getFeedList(pageKey,url,opt);
  }
  Future<Feed?> getFeedPage(url,opt) {
    return _source.getFeedPage(url,opt);
  }
  Future<bool> postFeed(Map<dynamic,dynamic> formData){
    return _source.postFeed(formData);
  }
  Future<void> deleteFeed(int page) {
    return _source.deleteFeed(page);
  }
  Future<void> editFeed(Map<String,dynamic> formData,int page) {
    return _source.editFeed(formData,page);
  }

  Future<List<Categories>> getCateList(url,opt , child){
    return _source.getCateList(url, opt , child);
  }
  Future<List<Comment>> getCommentPage(pageKey,url,opt){
    return _source.getCommentList(pageKey,url,opt);
  }
  Future<User> getUserInfo(id){
    return _source.getUserInfo(id);
  }
  Future<bool> postJoin(Map<String,dynamic> formData) async{
    return _source.postJoin(formData);
  }
  
  Future<void> postComment(Map<String,dynamic> formData){
    return _source.postComment(formData);
  }
  Future<List<dynamic>> postImagesRepo(List<XFile> images) async{
    return _source.postImagesData(images);
  }
  Future<List<Noti>> getNotiList(){
    return _source.getNotificationList();
  } 
}