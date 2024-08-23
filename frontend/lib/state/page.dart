import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/feed.dart';

class PageState{
  static PageState get page => Get.find();

  final RxInt index = 0.obs;
  final RxInt cateIndex = 0.obs;

  void setIndex(int i){
    index(i);
  }
  void setCateIndex(int i){
    index(i);
  }
}

class ViewPageState{
  static ViewPageState get page => Get.find();

  final Rx<PageUrl> view = PageUrl(url: "").obs;
  final Rx<PageUrl> comment = PageUrl(url: "").obs;

  void setView(String url,String? opt){
    view(PageUrl(url: url,opt : opt!));
  }
  void setComment(String url,String? opt){
    comment(PageUrl(url: url,opt : opt!));
  }
}