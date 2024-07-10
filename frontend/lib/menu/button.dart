import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuBtn extends StatelessWidget {
  final BuildContext context;
  final Function cb;
  final String? iconSrc;
  final String title;
  final Color tcolor;

  const MenuBtn({
    super.key,
    required this.context,
    required this.cb,
    this.iconSrc,
    required this.title,
    required this.tcolor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width : MediaQuery.of(context).size.width * 0.95,
      height : 42,
      margin: EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
        style : ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )
          )
        ),
        onPressed: ()=>cb,
        child: new LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconSrc!,
                  width : 24,
                  height : 24,
                  colorFilter: ColorFilter.mode(tcolor! , BlendMode.srcIn),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.25,
                  child : Text(
                    title,
                    textAlign: TextAlign.center,
                    style : TextStyle(
                      color: tcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ],
            );
          }
        )
      ),
    );
  }
}