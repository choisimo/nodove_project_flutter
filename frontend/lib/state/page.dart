import 'package:get/get.dart';

class PageState{
  static get page => Get.find();

  final RxInt index = 0.obs;

  void setIndex(int i){
    index(i);
  }
}