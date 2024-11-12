
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/src/datasrc/chat.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';

class FeedRepo{
  final DataSrc _source = DataSrc();

  Future<List<Feed>?> getFeedList(pageKey,url,opt) {
    return _source.getFeedList(pageKey,url,opt);
  }
  Future<Feed?> getFeedPage(url,opt) {
    return _source.getFeedPage(url,opt);
  }
  Future<bool> postFeed(Map<String,dynamic> formData){
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
  Future<Categories> getCateOne(String url,String opt){
    return _source.getCateOne(url,opt);
  }
  Future<List<Comment>> getCommentPage(pageKey,url,opt){
    return _source.getCommentList(pageKey,url,opt);
  }
  Future<User> getUserInfo(id){
    return _source.getUserInfo(id);
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
  Future<List<RecruitFeed>> getRecruitmentList(int page , int size){
    return _source.getRecruitmentList(page,size);
  }
  Future<RecruitFeed> getRecruitmentPage(String id){
    return _source.getRecruitmentPage(id);
  }
  Future<void> deleteRecruitmentFeed(String id) {
    return _source.deleteRecruitmentFeed(id);
  }
  Future<void> editRecruitmentFeed(Map<String,dynamic> formData,String id) {
    return _source.editRecruitmentFeed(formData,id);
  }
}

class ChatRepo{
  final ChatDataSrc _source = ChatDataSrc();

  Future<List<Room>> getUserRooms(){
    return _source.getChatRoomList();
  }
}