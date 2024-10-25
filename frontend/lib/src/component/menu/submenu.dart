import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';

class menuBtn extends StatelessWidget {
  final Function? onClick;
  final String? iconSrc;
  final double iconSize;
  final String title;
  final Color? iconColor;
  final Color? tColor;
  
  const menuBtn({
    super.key,
    this.onClick,
    this.iconSrc,
    this.iconSize = 18,
    this.title = "",
    this.iconColor,
    this.tColor
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
            const RoundedRectangleBorder(
              borderRadius: RowContainer.radius
            )
          )
        ),
        onPressed: ()=>onClick?.call(),
        child: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (iconSrc!= null)?
                SvgPicture.asset(
                  iconSrc!,
                  width : iconSize,
                  height : iconSize,
                  colorFilter: ColorFilter.mode(
                    iconColor??Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn
                  ),
                ): const SizedBox.shrink(),
                const SizedBox(width : 8),
                Container(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth * 0.3,
                  ),
                  child : Text(
                    title,
                    textAlign: TextAlign.center,
                    style : TextStyle(
                      color: tColor??Theme.of(context).colorScheme.primary,
                      fontSize: 16,
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
          fontSize : 14,
          fontWeight: FontWeight.bold,
          color : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}

class ListMenuBtn extends StatelessWidget {
  final Function? onClick;
  final String? iconSrc;
  final double iconSize;
  final String title;
  final Color? iconColor;
  final Color? tColor;
  
  const ListMenuBtn({
    super.key,
    this.onClick,
    this.iconSrc,
    this.iconSize = 18,
    this.title = "",
    this.iconColor,
    this.tColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width : MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(4),
      height : 42,
      decoration: BoxDecoration(
        border: Border(
          bottom : rowBorderLine()
        )
      ),
      child: TextButton(
        onPressed: ()=>onClick?.call(),
        child: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (iconSrc!= null)?
                SvgPicture.asset(
                  iconSrc!,
                  width : iconSize,
                  height : iconSize,
                  colorFilter: ColorFilter.mode(
                    iconColor??Theme.of(context).colorScheme.onSurface,
                    BlendMode.srcIn
                  ),
                ): const SizedBox.shrink(),
                const SizedBox(width : 8),
                Container(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth * 0.3,
                  ),
                  child : Text(
                    title,
                    textAlign: TextAlign.center,
                    style : TextStyle(
                      color: tColor??Theme.of(context).colorScheme.primary,
                      fontSize: 16,
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