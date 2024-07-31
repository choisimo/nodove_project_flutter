import 'package:get/get.dart';

class PageState{
  static PageState get page => Get.find();
  static PageState get catepage => Get.find();

  final RxInt index = 0.obs;
  final RxInt cateIndex = 0.obs;

  void setIndex(int i){
    index(i);
  }
  void setCateIndex(int i){
    index(i);
  }
}

class WritePageState{
  static PageState get page => Get.find();
  static PageState get catepage => Get.find();

  final RxInt index = 0.obs;
  final RxInt cateIndex = 0.obs;

  void setIndex(int i){
    index(i);
  }
  void setCateIndex(int i){
    index(i);
  }
}