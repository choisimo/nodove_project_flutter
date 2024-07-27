import 'package:get/get.dart';

class UserState{
  static UserState get page => Get.find();

  final RxString id = ''.obs;

  void setIndex(String i){
    id(i);
  }
}