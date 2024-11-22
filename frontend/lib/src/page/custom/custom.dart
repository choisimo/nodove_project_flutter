import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
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
            ),
            onPressed: ()=>profileUpload(),
            icon: SvgPicture.asset(
              "assets/icons/post/picture.svg",
              width : 24 , height : 24,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onPrimaryFixed,
                BlendMode.srcIn
              ),
            ),
          )
        )
      ],
    );
  }
}

void showCustomModal(BuildContext context,Widget child){
  showModalBottomSheet(
    enableDrag: true,
    useRootNavigator: true,
    isScrollControlled: true,
    context: context,
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