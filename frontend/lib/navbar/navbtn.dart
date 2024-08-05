import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/src/view/list/feedrow.dart';
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

Widget nextBtn(BuildContext context,Function? callback){
  return TextButton(
    onPressed: ()=>callback?.call(),
    child : const Text(
      "다음",
      style: TextStyle(
        fontSize: 18
      ),
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

class etcBtn extends StatefulWidget {
  final Function? cb;
  final int id;
  const etcBtn({super.key , this.cb , required this.id});

  @override
  State<etcBtn> createState() => _etcBtnState();
}

class _etcBtnState extends State<etcBtn> {
  @override
  Widget build(BuildContext context) {
    final Function? cb = widget.cb;
    final int id = widget.id;
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
