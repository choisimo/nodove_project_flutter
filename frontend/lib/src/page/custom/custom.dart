import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/user/new/join.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

Widget customImage(
  String src,
  {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? loading,
    Widget? alt
  }
){
  return 
    (src.contains("http"))?
    Image.network(
      src,
      fit: fit??BoxFit.contain,
      width : width,
      height : height,
      loadingBuilder: 
      (context, child, loadingProgress) {
        if (loadingProgress == null){
          return child;
        }
        return loading??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64,
        );
      },
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    ):Image.asset(
      src,
      fit: fit??BoxFit.contain,
      width : width,
      height : height,
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    );
}

ImageProvider customImgProvider(
  String src,
  {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? loading,
    Widget? alt
  }){
  return (src.isNotEmpty)?
  Image.network(
      src,
      fit: fit??BoxFit.contain,
      width : width??200,
      height : height??200,
      loadingBuilder: 
      (context, child, loadingProgress) {
        if (loadingProgress == null){
          return child;
        }
        return loading??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64,
        );
      },
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    ).image:
    Image.asset(
      "assets/images/logo.png",
      fit: fit??BoxFit.contain,
      width : width??200,
      height : height??200,
    ).image;
}

Widget customDialog(
  BuildContext context,
  {
    Color? backgroundColor,
    Widget title = const SizedBox.shrink(),
    Widget content = const SizedBox.shrink(),
    List<Widget>? bottomBtns,
  }){
  final sWidth = MediaQuery.of(context).size.width;
  final sHeight = MediaQuery.of(context).size.height;
  return Dialog(
    shape : const RoundedRectangleBorder(
      borderRadius: RowContainer.radius
    ),
    insetAnimationCurve: Curves.easeIn,
    backgroundColor: backgroundColor,
    child : LayoutBuilder(
      builder: (context,constraint) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          constraints: BoxConstraints(
            maxHeight: sHeight * 0.9,
            maxWidth : sWidth * 0.9,
            minHeight: sHeight * 0.1,
            minWidth: sWidth * 0.1,
          ),
          child: SizedBox(
            width : constraint.maxWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                title,
                content,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: bottomBtns!
                ),
              ],
            ),
          ),
        );
      }
    )
  );
}

void showToast(String msg) {
  BuildContext context = GlobalContext.navigatorState.currentContext!;
  showTopSnackBar(
    Overlay.of(context),
    toast(context, msg),
    safeAreaValues: const SafeAreaValues(top: false),
    curve: Curves.fastEaseInToSlowEaseOut,
    dismissType: DismissType.onSwipe,
    animationDuration: const Duration(milliseconds: 500),
    padding: const EdgeInsets.all(0),
  );
}
Widget toast(BuildContext context, String msg) {
  return Container(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: RowContainer.radius,
      boxShadow: [
        BoxShadow(
          color : Theme.of(context).colorScheme.shadow,
          offset: RowContainer.offset,
          blurRadius: RowContainer.blurRadius
        )
      ]
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

Widget customRefreshIndicator(
  BuildContext context,{
    bool enabled = true,
    Function? onRefresh,
    Widget? child,
    Color? strokeColor,
    Color? backgroundColor
  }
){
  return RefreshIndicator(
    notificationPredicate: (_)=>enabled,
    color : strokeColor??Theme.of(context).colorScheme.onSurface,
    backgroundColor : backgroundColor??Theme.of(context).colorScheme.onPrimary,
    onRefresh: ()=>Future.sync(()=>onRefresh?.call()),
    child : child!
  );
}

Widget dialogStrTitle(
  String title
){
  return Text(
    title,
    style : const TextStyle(
      fontSize : 18,
      fontWeight: FontWeight.bold
    )
  );
}
Widget dialogStrContent(
  String content
){
  return Text(
    content,
    style : const TextStyle(
      fontSize : 16,
    ),
    textAlign: TextAlign.center,
  );
}

Widget dialogCloseBtn(
  BuildContext context,
  {
    Function? onPressed,
    Color? iconColor
  }
){
  return IconButton(
    onPressed: ()=>onPressed?.call(),
    icon: SvgPicture.asset(
      "assets/icons/common/close.svg",
      width : 16,height : 16,
      colorFilter: ColorFilter.mode(
        iconColor??Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn),
    ),
  );
}

Widget dialogBottomBtn(
  BuildContext context,
  {
    Widget? child,
    Function? onPressed,
    Color? backgroundColor,
  }
){
  return FilledButton(
    style : FilledButton.styleFrom(
      backgroundColor: backgroundColor??Theme.of(context).colorScheme.onPrimaryFixed,
    ),
    onPressed: ()=>onPressed?.call(),
    child : child
  );
}

Widget commonTextInput(
  BuildContext context,{
    String? placeholder,
    TextStyle? placeholderStyle,
    String? key,
    TextStyle? style,
    List<TextInputFormatter>? filter,
    Function? onChanged,
    int? maxLength,
    int? maxLines,
    TextInputType? keyboard,
    String? initialValue,
    bool? enabled,
    bool obscureText = false,
    double? borderWidth = 0.5,
    Color? bColor,
    int minLength = 0,
    String? Function(String?)? validator
  }
){
  final borderColor = bColor??Theme.of(context).colorScheme.onSurface;
  final TextStyle textStyle = TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
  );
  return TextFormField(
    initialValue: initialValue,
    keyboardType: keyboard,
    maxLength: maxLength,
    style : style,
    autovalidateMode: AutovalidateMode.always,
    validator: validator,
    inputFormatters: filter,
    obscureText : obscureText,
    decoration: InputDecoration(
      counterText: "",
      focusedBorder: (borderWidth != null)
      ?OutlineInputBorder(
        borderRadius: RowContainer.radius,
        borderSide: BorderSide(
          color : borderColor,
          width : borderWidth
        )
      ):InputBorder.none,
      hintText: placeholder,
      hintStyle: placeholderStyle??textStyle,
      border: (borderWidth != null)
      ?OutlineInputBorder(
        borderRadius: RowContainer.radius,
        borderSide: BorderSide(
          color : borderColor,
          width : borderWidth
        )
      ):InputBorder.none,
      focusColor: Colors.transparent,
    ),
    onChanged:(value) => onChanged?.call(value),
  );
}


Widget profileSetting(
  BuildContext context,{
    double width = 104,
    double height = 104,
    double iconWidth = 32,
    double iconHeight = 32,
    Function(String)? onUpdated,
    String? current
  }
){
  final ImagePicker _picker = ImagePicker();
  final FeedImageModel _imageModel = Get.put(FeedImageModel());
  void profileUpload() async{
    XFile? selectImage = await _picker.pickImage(
      source : ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 30,
    );
    if (selectImage != null){
      _imageModel.postProfile(selectImage);
      onUpdated?.call(_imageModel.profile.value);
    }
  }

  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Profile(
        profile : current??"",
        width : 104,
        height : 104,
        borderRadius: 4.0,
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

class CustomToggle extends StatefulWidget {
  final List<Widget> childState;
  final List<Color> childColors;
  final Function? onChanged;
  final int? initialIndex;
  const CustomToggle({
    super.key,
    required this.childState,
    required this.childColors,
    this.onChanged,
    this.initialIndex = 0,
  });

  @override
  State<CustomToggle> createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  int index = 0;

  @override
  void initState() {
    setState((){
      index = widget.initialIndex!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> state = widget.childState;
    List<Color> colors = widget.childColors;
    return GestureDetector(
      onTap : (){
        setState((){
        if (index < state.length - 1){
          index += 1;
        } else {
          index = 0;
        }});
        widget.onChanged?.call(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width : 50,
        height : 25,
        decoration: BoxDecoration(
          color : colors[index],
          borderRadius: RowContainer.radius
        ),
        child : Center(child: state[index])
      ),
    );
  }
}