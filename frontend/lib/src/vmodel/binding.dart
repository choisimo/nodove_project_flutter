
import 'package:get/get.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/user.dart';

class InitViewModel implements Bindings{
  @override
  void dependencies(){
    Get.create<FeedListModel>(()=>FeedListModel());
    Get.put<UserState>(UserState(),permanent: true);
    Get.lazyPut<CommentPageModel>(()=> CommentPageModel());
    Get.create<UserInfoModel>(()=> UserInfoModel());
    Get.lazyPut<FeedImageModel>(()=>FeedImageModel());
    Get.put<PageState>(PageState(),permanent: true);
    Get.create<CateListModel>(()=> CateListModel());
    Get.create<TagListModel>(()=>TagListModel());
    Get.create<TempFeed>(()=>TempFeed());
  }
}