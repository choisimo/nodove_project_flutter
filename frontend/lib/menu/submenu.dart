import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuBtn extends StatelessWidget {
  final BuildContext context;
  final Function cb;
  final String? iconSrc;
  final String title;
  final Color? tcolor;

  const MenuBtn({
    super.key,
    required this.context,
    required this.cb,
    this.iconSrc,
    required this.title,
    this.tcolor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width : MediaQuery.of(context).size.width * 0.95,
      height : 42,
      margin: const EdgeInsets.symmetric(vertical: 4),
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
        child: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  iconSrc!,
                  width : 24,
                  height : 24,
                  colorFilter: ColorFilter.mode(
                    tcolor??Theme.of(context).colorScheme.onSurface ,
                    BlendMode.srcIn
                  ),
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

class MenuTitle extends StatelessWidget {
  final String title;
  const MenuTitle({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : MediaQuery.of(context).size.width * 0.95,
      child: Text(
        title,
        style: TextStyle(
          fontSize : 16,
          fontWeight: FontWeight.bold,
          color : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}