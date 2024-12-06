import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

List<BoxShadow> rowBorderShadow(){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return [
    BoxShadow(
      color : Theme.of(context).colorScheme.shadow,
      offset: RowContainer.offset,
      blurRadius: RowContainer.blurRadius
    )
  ];
}

Border rowBorderLineAll({Color? color}){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return Border.all(
    color: color??Theme.of(context).colorScheme.onSecondary,
    width: 0.5,
  );
}

BorderSide rowBorderLine({Color? color}){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return BorderSide(
    color: color??Theme.of(context).colorScheme.onSecondary,
    width: 0.5,
  );
}

void showToast(String msg) {
  BuildContext context = GlobalContext.navigatorState.currentContext!;
  showTopSnackBar(
    Overlay.of(context),
    ToastWidget(msg),
    safeAreaValues: const SafeAreaValues(top: false),
    curve: Curves.fastEaseInToSlowEaseOut,
    dismissType: DismissType.onSwipe,
    animationDuration: const Duration(milliseconds: 500),
    padding: const EdgeInsets.all(0),
  );
}

void showCustomModal(BuildContext context,Widget child){
  showModalBottomSheet(
    context: context,
    enableDrag: true,
    useRootNavigator: true,
    isScrollControlled: true,
    showDragHandle: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    builder :(BuildContext context) {
      return Padding(
        padding : EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: child
      );
    },
  );
}

class ToastWidget extends StatelessWidget {
  final String msg;
  const ToastWidget(this.msg,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: RowContainer.radius,
        border: rowBorderLineAll()
      ),
      width: double.infinity,
      child: SafeArea(
        child: SizedBox(
          height: 42,
          child: Center(
            child: Text(
              msg,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                decoration: TextDecoration.none),
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileSetting extends StatefulWidget {
  final double width;
  final double height;
  final double iconWidth;
  final double iconHeight;
  final Function(String url)? onUpdated;
  final String? current;
  const ProfileSetting({
    super.key,
    this.width = 104,
    this.height = 104,
    this.iconWidth = 32,
    this.iconHeight = 32,
    this.onUpdated,
    this.current
  });

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final ImagePicker picker = ImagePicker();
  final FeedImageModel imageModel = Get.put(FeedImageModel());

  void profileUpload() async{
    XFile? selectImage = await picker.pickImage(
      source : ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 30,
    );
    if (selectImage != null){
      imageModel.postProfile(selectImage);
      widget.onUpdated?.call(imageModel.profile.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Profile(
          profile : widget.current??"",
          width : 104,
          height : 104,
          borderRadius: 1.0,
        ),
        SizedBox(
          width : 32,
          height : 32,
          child : IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              side: rowBorderLine()
            ),
            onPressed: ()=>profileUpload(),
            icon: const CustomSvg(
              "post/edit.svg",
              width : 24 , height : 24,
            ),
          )
        )
      ],
    );
  }
}

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
  } else if (context != null){
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
              title:"설정 열기",
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