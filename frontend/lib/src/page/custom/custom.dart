import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:nodove_flutter/state/color.dart';

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
    (src.isNotEmpty)?
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
      "assets/images/logo.png",
      fit: fit??BoxFit.contain,
      width : width??200,
      height : height??200,
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

void showToast(String msg){
  Fluttertoast.showToast(
    msg : msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color.fromRGBO(0,0,0,0.5),
    textColor : Colors.white,
    fontSize : 20,
  );
}

Widget customRefreshIndicator(
  BuildContext context,{
    bool enabled = true,
    required Function onRefresh,
    Widget? child,
    Color? strokeColor,
    Color? backgroundColor
  }
){
  return RefreshIndicator(
    notificationPredicate: (_)=>enabled,
    color : strokeColor??Theme.of(context).colorScheme.onSurface,
    backgroundColor : backgroundColor??Theme.of(context).colorScheme.onPrimary,
    onRefresh: ()=>onRefresh.call(),
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