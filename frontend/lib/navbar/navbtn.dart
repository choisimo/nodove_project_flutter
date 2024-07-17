import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'dart:math' as math;

Widget navbarTitle(BuildContext context,String title,double? fontSize){
  return SizedBox(
    child: Text(
      title,
      style : TextStyle(
        color : Theme.of(context).colorScheme.onSurface ,
        fontSize : fontSize??18
      )
    ),
  );
}

Widget backBtn(BuildContext context){
  return Row(
    children: [
      IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon : SvgPicture.asset(
          'assets/icons/common/left.svg',
          width : 20,
          height : 20,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
        )
      ),
    ],
  );
}

Widget searchBtn(BuildContext context){
  return IconButton(
    onPressed: (){},
    icon : SvgPicture.asset(
      'assets/icons/navbar/search.svg',
      width : 20,
      height : 20,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
    )
  );
}

Widget alertBtn(BuildContext context){
  return IconButton(
    onPressed: (){},
    icon : SvgPicture.asset(
      'assets/icons/navbar/alert.svg',
      width : 20,
      height : 20,
      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
    )
  );
}

Widget etcBtn(BuildContext context,Function? cb,int id){
  return SizedBox(
    width : 42,
    height : 42,
    child: TextButton(
      onPressed: ()=>cb?.call(id),
      style : TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onSurface,
      ),
      child: Transform.rotate(
        angle : 90 * math.pi / 180,
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