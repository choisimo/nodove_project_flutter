
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/datasrc/chat.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:nodove_flutter/state/user.dart';

class InitViewModel implements Bindings{
  @override
  void dependencies(){
    Get.create<FeedListModel>(()=>FeedListModel());
    Get.put<UserState>(UserState());
    Get.lazyPut<CommentPageModel>(()=> CommentPageModel());
    Get.create<UserInfoModel>(()=> UserInfoModel());
    Get.lazyPut<FeedImageModel>(()=>FeedImageModel());
    Get.put<ViewPageState>(ViewPageState());
    Get.create<CateListModel>(()=> CateListModel());
    Get.create<TagListModel>(()=>TagListModel());
  }
}

class FeedListModel extends GetxController {
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Feed> feedList = <Feed>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;
  RxMap<String,dynamic> writeForm = {
    'title' : "",
    'content' : "",
    'postHashtags' : [], "caption" : "TEMP",
    "imageLinks" : [] , "status" : "published"
  }.obs;
  Rx<Feed> content = Feed.defaultState().obs;

  Future<void> setForm(String type,dynamic value) async{
    writeForm[type] = value;
    print(writeForm);
  }

  Future<void> postWrite(Map<String,dynamic> writeForm) async {
    await _feedrepo.postFeed(writeForm);
    feedList.refresh();
  }

  Future<void> deleteFeed(id) async{
    await _feedrepo.deleteFeed(id);
    feedList.refresh();
  }
  Future<void> editFeed(formData,id) async{
    await _feedrepo.editFeed(formData,id);
    feedList.refresh();
  }

  Future<void> getFeedPage(id) async{
    String url = "${Url.apiUrl}/getPostByPostId";
    String opt = "/$id";
    isFetching(true);
    Feed? feedPage = await _feedrepo.getFeedPage(url,opt);
    if (feedPage != null){
      isFetching(false);
      content(feedPage);
    }
  }

  Future<void> getFeedFirst(String url,String opt) async{
    try{
      isLastAppend(false);
      isFetching(true);
      final list = await _feedrepo.getFeedList(0,url,opt);

      if (list != null){
        feedList(list);
        isFetching(false);
      }
      else {feedList([]);}
    }catch(error){
      print(error);
    }
  }

  Future<List<Feed>> getFeedList(int page,String url,String opt) async{
    if (isLastAppend.isFalse&&isFetching.isFalse&&isFragFetching.isFalse){
      isFragFetching(true);
      final list = await _feedrepo.getFeedList(page,url,opt);
      isFragFetching(false);
      if (list != null){
        return list;
      }
      else {isLastAppend(true); return [];}
      
    } else {return [];}
  }
  Future<void> appendLastPage(List<Feed> newData) async{
    feedList.addAll(newData);
  }
  Future<void> appendPage(List<Feed> newData) async{
    feedList.addAll(newData);
  }
  /*Future<void> postComment(Map<String,dynamic> formData) async{
    await _feedrepo.post(formData);
    feedList.refresh();
  }*/
}

class FeedImageModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<dynamic> imageList = <dynamic>[].obs;
  Rx<String> profile = "".obs;

  void postProfile(XFile image) async{
    try{
      final list = await _feedrepo.postImagesRepo([image]);
      profile(list[0]);
    } catch (error){
      print("업로드에러 : $error");
    }
  }

  void postImages(List<XFile> images) async{
    try{
      final list = await _feedrepo.postImagesRepo(images);
      imageList.addAll(list);
    } catch (error){
      print("업로드에러 : $error");
    }
  }
  Future<void> postVideo(XFile video) async{
    final list = await _feedrepo.postImagesRepo([video]);
    imageList.addAll(list);
  }
  void deleteImages(int index) async{
    imageList.remove(imageList[index]);
  }
}

class TagListModel extends GetxController{
  RxList<String> tagList = <String>[].obs;
  Future<void> addTag(String tag) async{
    tagList.add(tag);
    tagList.refresh();
  }
  Future<void> addTagList(List<String> tag) async{
    tagList.addAll(tag);
    
  }
}

class CommentPageModel extends GetxController {
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Comment> commentList = <Comment>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;
  int maxPage = 5;
  
  Future<void> getCommentFirst(String url , String opt) async{
    isFetching(true);
    final list = await _feedrepo.getCommentPage(0,url,opt);
    isFetching(false);

    if (list.isNotEmpty){
      commentList(list);
    }
    else {
      commentList([]);
    }
  }
  Future<List<Comment>> fetchCommentFrag(String url , String opt ,int pageKey) async{
    isFragFetching(true);
    final list = await _feedrepo.getCommentPage(pageKey,url,opt);
    
    if (list.isNotEmpty){
      return list;
    } else{
      return [];
    }
  }
  Future<void> appendLastPage(List<Comment> newData) async{
    if(isLastAppend.isFalse) {
      commentList.addAll(newData);
      isLastAppend(true);
    }
  }
  Future<void> appendPage(List<Comment> newData) async{
    if(isLastAppend.isFalse) {
      commentList.addAll(newData);
    }
  }
  Future<void> postComment(Map<String,dynamic> formData) async{
    await _feedrepo.postComment(formData);
    commentList.refresh();
  }
}

class AddRoomModel extends GetxController{
  final RxMap<String,dynamic> addRoomForm = {
    "roomName" : "",
    "profileImage" : null,
    "isGroup" : false,
    "memberIds" : []
  }.obs;
  void setAddRoom(String key,dynamic value){
    addRoomForm.addAll({key : value});
  }
  Future<bool> addRoom() async{
    if (addRoomForm['roomName'].length > 0){
      final result = await ChatDataSrc().postRoom(addRoomForm);
      return result;
    } else{
      showToast("대화 주제를 적어주세요");
      return false;
    }
  }
}

class UserInfoModel extends GetxController{
  final FeedRepo _feedRepo = FeedRepo();
  Rx<User> userInfo = User.defaultState().obs;
  RxMap<dynamic,dynamic> editInfo = {}.obs;
  RxBool isFetching = false.obs;
  final RxMap<String,dynamic> joinForm = {
    "userId": null,
    "userPw": null,
    "userName": null,
    "nickname": null,
    "phone": null,
    "email": null,
    "role": "USER",
    "birthDate": DateTime.now(),
    "gender": 'M',
    "profile": null,
    "code": null,
    "private": false,
    "isPrivate": false
  }.obs;

  Future<void> getUserInfo(id) async{
    isFetching(true);
    final info = await _feedRepo.getUserInfo(id);
    isFetching(false);
    userInfo(info);
  }
  void editUserInfo(String key,dynamic value){
    editInfo.addAll({key : value});
  }

  void setJoinForm(String key , dynamic value){
    if (key.isNotEmpty){
      joinForm[key] = value;
    }
  }

  void resetJoinForm(){
    joinForm({
      "userId": null,
      "userPw": null,
      "userName": null,
      "nickname": null,
      "phone": null,
      "email": null,
      "role": "USER",
      "birthDate": DateTime.now(),
      "gender": 'M',
      "profile": null,
      "code": null,
      "private": false,
      "isPrivate": false
    });
  }

  Future<bool> postJoin() async{
    final result = await AuthDataSrc().postJoin(joinForm);
    return result;
  } 
  Future<bool> isUserIdDuplicate(String userId) async{
    final result = await AuthDataSrc().isUserIdDuplicate(userId);
    return result;
  }
  Future<bool> isUserNameDuplicate(String username) async{
    final result = await AuthDataSrc().isUserNameDuplicate(username);
    return result;
  }
}

class CateListModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Categories> catelist = <Categories>[].obs;
  Rx<Categories> currentCate = Categories.initialState().obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;
  RxBool isSubscribed = false.obs;

  Future<void> getCate({int page = 0,String? url,String? opt}) async{
    List<Categories> list = [];
    final optStr = opt??"";
    String urlStr = "";
    isFetching(true);
    if (page > 0){
      urlStr = url??"${Url.apiUrl}/categories/getAllCategoriesByParentId/$page";
      list = await _feedrepo.getCateList(urlStr,optStr,true);
    } else {
      urlStr = url??"${Url.apiUrl}/categories/getDepth1Categories";
      list = await _feedrepo.getCateList(urlStr,optStr,false);
    }
    isFetching(false);
    if (list.isNotEmpty){
      catelist(list);
    } else {
      catelist([]);
    }
  }

  Future<void> getCateOne({String? url , String? opt}) async{
    isFetching(true);
    String urlStr = url??"${Url.apiUrl}/categories/getAllCategoriesByParentId/";
    String urlOpt = opt??"0";
    final cate = await _feedrepo.getCateOne(urlStr,urlOpt);
    currentCate(cate);
    
    isFetching(false);
  }

  Future<void> setSubscribe (int id) async{
    if (catelist[id].subscribed == false){
      catelist[id].subscribed = true;
    } else if (catelist[id].subscribed == true){
      catelist[id].subscribed = false;
    }
  }
}

class NotiListModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<Noti> notilist = <Noti>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;

  Future<void> getNofification() async{
    if (isFetching.isFalse){
      isFetching(true);
      List<Noti> list = await _feedrepo.getNotiList();
      isFetching(false);
      if (list.isNotEmpty){
        notilist(list);
      } else{
        notilist([]);
      }
    }
  }
  Future<void> deleteNotification(int index) async{
    notilist.removeAt(index);
  }
}

class RoomListModel extends GetxController{
  final ChatRepo _chatrepo = ChatRepo();
  RxList<Room> roomlist = <Room>[].obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;

  Future<void> getRoomList() async{
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      isFetching(true);
      List<Room> list = await _chatrepo.getUserRooms();
      isFetching(false);
      if (list.isNotEmpty){
        roomlist(list);
      } else{
        roomlist([]);
      }
    });
  }

}

class RecruitListModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<RecruitFeed> recruitlist = <RecruitFeed>[].obs;
  late Rx<RecruitFeed?> content;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;

  Future<void> deleteRecruitmentFeed(id) async{
    await _feedrepo.deleteRecruitmentFeed(id);
    recruitlist.refresh();
  }
  Future<void> editRecruitmentFeed(formData,id) async{
    await _feedrepo.editRecruitmentFeed(formData,id);
    recruitlist.refresh();
  }

  Future<void> getRecruitmentPage(id) async{
    isFetching(true);
    RecruitFeed feedPage = await _feedrepo.getRecruitmentPage(id);
    isFetching(false);
    content(feedPage);
  }

  Future<void> getRecruitmentFirst(int page,int size) async{
    try{
      isLastAppend(false);
      isFetching(true);
      final list = await _feedrepo.getRecruitmentList(page,size);

      recruitlist(list);
      isFetching(false);
        }catch(error){
      print(error);
    }
  }

  Future<List<RecruitFeed>> getRecruitmentList(int page,int size) async{
    if (isLastAppend.isFalse&&isFetching.isFalse&&isFragFetching.isFalse){
      isFragFetching(true);
      final list = await _feedrepo.getRecruitmentList(page,size);
      isFragFetching(false);
      return list;
          
    } else {return [];}
  }
  Future<void> appendLastPage(List<RecruitFeed> newData) async{
    recruitlist.addAll(newData);
  }
  Future<void> appendPage(List<RecruitFeed> newData) async{
    recruitlist.addAll(newData);
  }
}