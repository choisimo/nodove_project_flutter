import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'dart:math' as math;

Widget navbarTitle(
  BuildContext context,
  String title,
  double? fontSize,
  {
    Color? color
    }
  ){
  return SizedBox(
    child: Text(
      title,
      style : TextStyle(
        color : color??Theme.of(context).colorScheme.primary,
        fontSize : fontSize??18,
      )
    ),
  );
}

Widget backBtn(BuildContext context,{String? displayText,Function? callback}){
  return TextButton(
    onPressed: ()=>callback?.call(),
    child : (displayText != null)?
    Text(
      displayText,
      style: TextStyle(
        fontSize: 18,
        color : Theme.of(context).colorScheme.primary
      ),
    )
    :SvgPicture.asset(
      'assets/icons/common/left.svg',
      width : 18,
      height : 18,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
    )
  );
}

Widget nextBtn(BuildContext context,{String? displayText,Function? callback}){
  return TextButton(
    onPressed: ()=>callback?.call(),
    child : (displayText != null)?
    Text(
      displayText,
      style: TextStyle(
        fontSize: 18,
        color : Theme.of(context).colorScheme.primary
      ),
    ):SvgPicture.asset(
        'assets/icons/common/right.svg',
        width : 18,
        height : 18,
        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary,BlendMode.srcIn),
      )
  );
}

class etcBtn extends StatefulWidget {
  final Function? cb;
  final dynamic id;
  const etcBtn({super.key , this.cb , required this.id});

  @override
  State<etcBtn> createState() => _etcBtnState();
}

class _etcBtnState extends State<etcBtn> {
  @override
  Widget build(BuildContext context) {
    final Function? cb = widget.cb;
    final dynamic id = widget.id;
    return SizedBox(
      width : 42,
      height : 42,
      child: TextButton(
        onPressed: ()=>cb?.call(id),
        style : TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
        child: Rotate(
          angle : 90,
          child: Text(
            '•••',
            overflow: TextOverflow.visible,
            softWrap: false,
            style : TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
            )
          ),
        )
      ),
    );
  }
}

PopupMenuItem popupMenu(BuildContext context,{
  String? iconSrc,
  Widget? title,
  Function? cb
}
){
  return PopupMenuItem(
    child: Row(
      children : [
        (iconSrc != null)?
        SizedBox(
          width : 24,
          child: SvgPicture.asset(
            iconSrc,
            width : 12 , height : 12,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          ),
        ):const SizedBox.shrink(),
        title??const SizedBox.shrink()
      ]
    ),
    onTap: () => cb?.call(),
  );
}

Widget etcCommonBtn(
  BuildContext context,
  {
    Function? cb,
    double fontSize = 12,
    Color? iconColor
  }){
  return SizedBox(
    width : 42,
    height : 24,
    child: TextButton(
      onPressed: ()=>cb?.call(),
      child : Text(
        '•••',
        softWrap: false,
        overflow: TextOverflow.visible,
        style : TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        )
      ),
    ),
  );
}

Widget navbarCommonBtn(
  BuildContext context,
  String src,
  {
    Function? cb,
    double width = 18,
    double height = 18,
    Color? iconColor
  }){
  return IconButton(
    onPressed: ()=>cb?.call(),
    icon : SvgPicture.asset(
      src,
      width : width,
      height : height,
      colorFilter: ColorFilter.mode(
        iconColor??Theme.of(context).colorScheme.primary,
        BlendMode.srcIn
      ),
    )
  );
}