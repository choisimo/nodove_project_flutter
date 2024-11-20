import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/graphic/transform.dart';

class NavbarTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? textColor;
  const NavbarTitle(this.title,{
    super.key,
    this.fontSize = 20,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        title,
        style : TextStyle(
          color : textColor??Theme.of(context).colorScheme.onPrimaryFixed,
          fontWeight: FontWeight.w900,
          fontSize : fontSize??18,
        )
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  final String? displayText;
  final Function? callback;
  const BackBtn({
    super.key,
    this.displayText,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ()=>callback?.call(),
      child : (displayText != null)?
      Text(
        displayText.toString(),
        style: TextStyle(
          fontSize: 18,
          color : Theme.of(context).colorScheme.primary
        ),
      )
      :SvgPicture.asset(
        'assets/icons/common/left.svg',
        width : 18,
        height : 18,
        colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed,BlendMode.srcIn),
      )
    );
  }
}
class NextBtn extends StatelessWidget {
  final String? displayText;
  final Function? callback;
  const NextBtn({
    super.key,
    this.displayText,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
    onPressed: ()=>callback?.call(),
    child : (displayText != null)?
    Text(
      displayText.toString(),
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
}

class etcBtn extends StatefulWidget {
  final Function? cb;
  final dynamic id;
  final double? fontSize;
  const etcBtn({super.key , this.cb , required this.id,this.fontSize = 14});

  @override
  State<etcBtn> createState() => _etcBtnState();
}

class _etcBtnState extends State<etcBtn> {
  @override
  Widget build(BuildContext context) {
    final Function? cb = widget.cb;
    final dynamic id = widget.id;
    return 
    TextButton(
      iconAlignment: IconAlignment.end,
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
              fontSize: widget.fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface
            )
          ),
        )
      );
  }
}

PopupMenuItem popupMenu(BuildContext context,{
  String? iconSrc,
  Widget? title,
  Function? onClick
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
    onTap: () => onClick?.call(),
  );
}

class EtcCommonBtn extends StatelessWidget {
  final Function? onClick;
  final double fontSize;
  final Color? iconColor;
  final double iconSize;
  const EtcCommonBtn ({
    super.key,
    this.onClick,
    this.fontSize = 12,
    this.iconColor,
    this.iconSize = 24
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : iconSize,
      height : iconSize,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0.0)
        ),
        onPressed: ()=>onClick?.call(),
        child : Rotate(
          angle: 90,
          child: Text(
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
      ),
    );
  }
}

class NavbarCommonBtn extends StatelessWidget {
  final String src;
  final Function? onClick;
  final double width;
  final double height;
  final Color? iconColor;
  const NavbarCommonBtn(this.src,{
    super.key,
    this.onClick,
    this.width = 18,
    this.height = 18,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return 
    (onClick != null)?
    IconButton(
      onPressed: ()=>onClick?.call(),
      icon : icon(context)
    ):icon(context);
  }

  Widget icon(BuildContext context){
    return CustomSvg(
      src,
      width : width,
      height : height,
      iconColor : iconColor??Theme.of(context).colorScheme.primary,
    );
  }
}