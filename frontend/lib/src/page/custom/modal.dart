import 'package:flutter/material.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/state/color.dart';

class CustomFloatingButton extends StatelessWidget {
  final Widget? child;
  final Widget? icon;
  final double? iconWidth;
  final double? iconHeight;
  final Function? onClick;
  final Color? backgroundColor;
  final String? heroTag;
  const CustomFloatingButton({
    this.child,this.icon,this.onClick,this.backgroundColor,this.heroTag,
    this.iconHeight = 24,this.iconWidth = 24,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'comment',
      onPressed: ()=>onClick?.call(),
      backgroundColor: backgroundColor??Theme.of(context).colorScheme.onPrimary,
      child : SizedBox(
        width : iconWidth,
        height : iconHeight,
        child: icon
      )
    );
  }
}

class CustomModalFloatingButton extends StatelessWidget {
  final Widget? child;
  final Widget? icon;
  final Color? backgroundColor;
  final String? heroTag;
  final double? iconWidth;
  final double? iconHeight;
  const CustomModalFloatingButton({
    this.child,this.icon,this.backgroundColor,
    this.heroTag,this.iconHeight = 24,this.iconWidth = 24,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return CustomFloatingButton(
      heroTag: 'comment',
      onClick: ()=>showModalBottomSheet(
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
      ),
      backgroundColor: backgroundColor,
      iconHeight: iconHeight,
      iconWidth: iconWidth,
      icon : icon,
      child: child
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final String? label;
  final List<Widget> children;
  const CustomDrawer({super.key,this.label,required this.children});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: label,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      child : SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children : children,
        )
      )
    );
  }
}

class CustomDialog extends StatelessWidget {
  final Color? backgroundColor;
  final Widget title;
  final Widget content;
  final List<Widget> bottomBtns;
  final bool hasCloseBtn;
  final void Function()? onClose;
  const CustomDialog({
    super.key,
    this.backgroundColor,
    this.title = const SizedBox.shrink(),
    this.content = const SizedBox.shrink(),
    this.bottomBtns = const [SizedBox.shrink()],
    this.hasCloseBtn = true,
    this.onClose
  });

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;
    return Dialog(
      shape : const RoundedRectangleBorder(
        borderRadius: RowContainer.radius
      ),
      insetAnimationCurve: Curves.easeIn,
      backgroundColor: backgroundColor,
      child :Container(
        padding: const EdgeInsets.all(8.0),
        constraints: BoxConstraints(
          maxHeight: sHeight * 0.9,
          maxWidth : sWidth * 0.9,
          minHeight: sHeight * 0.1,
          minWidth: sWidth * 0.1,
        ),
        child: SizedBox(
          width : sWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              (hasCloseBtn)?
              Align(
                alignment: Alignment.topLeft,
                child : DialogCloseBtn(
                  onPressed: (){
                    onClose?.call();
                    Navigator.of(context).pop();
                  },
                )
              ):const SizedBox.shrink(),
              title,
              content,
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: bottomBtns
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogStrTitle extends StatelessWidget {
  final String title;
  const DialogStrTitle(this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style : const TextStyle(
        fontSize : 18,
        fontWeight: FontWeight.bold
      )
    );
  }
}

class DialogStrContent extends StatelessWidget {
  final String content;
  const DialogStrContent(this.content,{super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style : const TextStyle(
        fontSize : 16,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class DialogCloseBtn extends StatelessWidget {
  final Function? onPressed;
  final Color? iconColor;
  const DialogCloseBtn(
    {
      super.key,
      this.onPressed,
      this.iconColor
    }
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ()=>onPressed?.call(),
      icon: const CustomSvg(
        "common/close.svg",
        width : 16,height : 16,
      ),
    );
  }
}

class DialogBottomBtn extends StatelessWidget {
  final String? title;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  const DialogBottomBtn({super.key,
  this.title,
  this.onPressed,
  this.backgroundColor,
  this.fontColor
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style : FilledButton.styleFrom(
        backgroundColor: backgroundColor??Theme.of(context).colorScheme.onSecondary,
      ),
      onPressed: ()=>onPressed?.call(),
      child : Text(
        title.toString(),
        style: TextStyle(
          color: fontColor??Theme.of(context).colorScheme.onPrimaryFixed,
        ),
      )
    );
  }
}