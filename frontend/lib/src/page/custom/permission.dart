import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:permission_handler/permission_handler.dart';

late LocationSettings locationSettings;

Future<Pos> locationPermission() async {
  BuildContext? context = GlobalContext.navigatorState.currentContext;
  PermissionStatus permission = await Permission.location.status;
  if ((permission.isGranted || permission.isLimited) &&
      await Permission.locationWhenInUse.serviceStatus.isEnabled) {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        locationSettings = AndroidSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
          forceLocationManager: true,
          intervalDuration: const Duration(seconds: 10),
        );
      } else if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS) {
        locationSettings = AppleSettings(
          accuracy: LocationAccuracy.high,
          activityType: ActivityType.fitness,
          distanceFilter: 100,
          pauseLocationUpdatesAutomatically: true,
        );
      } else {
        locationSettings = const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 100,
        );
      }
      var position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);
      return Pos(lat: position.latitude, lon: position.longitude);
    } catch (e) {
      showToast("지도 불러오기에 실패했습니다");
      print(e);
      return Pos(lat: 35, lon: 129);
    }
  } else if (context != null) {
    showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => CustomDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [DialogCloseBtn(onPressed: () => Get.back())],
          ),
          content: const Column(
            children: [
              DialogStrTitle("권한와 GPS를 설정해주세요"),
              DialogStrContent("현재 위치를 불러오려면 위치 권한과 GPS가 설정되어 있어야 합니다"),
            ],
          ),
          bottomBtns: [
            DialogBottomBtn(
                title: "설정 열기",
                onPressed: () async {
                  openAppSettings();
                })
          ]),
    );

    return Pos(lat: 35, lon: 129);
  } else {
    return Pos(lat: 35, lon: 129);
  }
}
