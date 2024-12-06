import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class FeedSettingModel extends GetxController {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  RxMap<String, dynamic> settings = {
    "feedListCount": "15",
    "feedListSummarize" : "false",
    "communityListCount": "15",
  }.obs;

  void changeSetting(String key, dynamic value) {
    settings[key] = value;
  }

  void loadSetting({
    List<String> keys = const [],
    Function(Map<String, dynamic> value)? onLoaded,
    Function(bool success)? isSuccess,
  }) async {
    try {
      Map<String, dynamic> list = {};
      await Future.forEach(keys, (key) async {
        await storage.read(key: key).then((value) {
          list[key] = value;
        });
      }).then((_) {
        onLoaded?.call(list);
        isSuccess?.call(true);
      });
    } catch (e) {
      isSuccess?.call(false);
      print(e);
    }
  }

  void resetSetting(){
    settings({
      "feedListCount": "15",
      "feedListSummarize" : "false",
      "communityListCount": "15",
    });
  }

  void writeSetting({
    String key = "",
    dynamic value,
    Function(bool success)? isSuccess,
  }) async {
    try {
      storage
          .write(key: key, value: value)
          .then((value) => isSuccess?.call(true));
    } catch (e) {
      isSuccess?.call(false);
      print(e);
    }
  }
}
