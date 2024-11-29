import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';

class UserState{
  static UserState get page => Get.find();

  final Rx<User> user = User.defaultState().obs;
  final RxString id = ''.obs;
  final RxString profile = ''.obs;
  final Rx<Pos> position = Pos(lat : 35,lon : 129).obs;

  void setIndex(String i){
    id(i);
  }
  void setProfile(String i){
    profile(i);
  }
  void setPos(Pos pos){
    position(pos);
  }
}