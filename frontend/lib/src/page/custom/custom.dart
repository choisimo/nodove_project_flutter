import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

List<BoxShadow> rowBorderShadow(){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return [
    BoxShadow(
      color : Theme.of(context).colorScheme.shadow,
      offset: RowContainer.offset,
      blurRadius: RowContainer.blurRadius
    )
  ];
}

Border rowBorderLineAll({Color? color}){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return Border.all(
    color: color??Theme.of(context).colorScheme.onSecondary,
    width: 0.5,
  );
}

BorderSide rowBorderLine({Color? color}){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return BorderSide(
    color: color??Theme.of(context).colorScheme.onSecondary,
    width: 0.5,
  );
}

void showToast(String msg) {
  BuildContext context = GlobalContext.navigatorState.currentContext!;
  showTopSnackBar(
    Overlay.of(context),
    ToastWidget(msg),
    safeAreaValues: const SafeAreaValues(top: false),
    curve: Curves.fastEaseInToSlowEaseOut,
    dismissType: DismissType.onSwipe,
    animationDuration: const Duration(milliseconds: 500),
    padding: const EdgeInsets.all(0),
  );
}

class ToastWidget extends StatelessWidget {
  final String msg;
  const ToastWidget(this.msg,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: RowContainer.radius,
        border: rowBorderLineAll()
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
}

class CustomRefreshIndicator extends StatelessWidget {
  final bool enabled;
  final Function? onRefresh;
  final Widget? child;
  final Color? strokeColor;
  final Color? backgroundColor;
  const CustomRefreshIndicator({
    super.key,
    this.enabled = true,
    this.onRefresh,
    this.child,
    this.strokeColor,
    this.backgroundColor
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 30,
      notificationPredicate: (_)=>enabled,
      color : strokeColor??Theme.of(context).colorScheme.onSurface,
      backgroundColor : backgroundColor??Theme.of(context).colorScheme.onPrimary,
      onRefresh: ()=>Future.sync(()=>onRefresh?.call()),
      child : child!
    );
  }
}

class CustomDialog extends StatelessWidget {
  final Color? backgroundColor;
  final Widget title;
  final Widget content;
  final List<Widget> bottomBtns;
  const CustomDialog({
    super.key,
    this.backgroundColor,
    this.title = const SizedBox.shrink(),
    this.content = const SizedBox.shrink(),
    this.bottomBtns = const [SizedBox.shrink()]
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
      icon: SvgPicture.asset(
        "assets/icons/common/close.svg",
        width : 16,height : 16,
        colorFilter: ColorFilter.mode(
          iconColor??Theme.of(context).colorScheme.secondary,
          BlendMode.srcIn),
      ),
    );
  }
}
class DialogBottomBtn extends StatelessWidget {
  final Widget? child;
  final Function? onPressed;
  final Color? backgroundColor;
  const DialogBottomBtn({super.key,
  this.child,
  this.onPressed,
  this.backgroundColor,});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style : FilledButton.styleFrom(
        backgroundColor: backgroundColor??Theme.of(context).colorScheme.onPrimaryFixed,
      ),
      onPressed: ()=>onPressed?.call(),
      child : child
    );
  }
}

class CommonTextInput extends StatelessWidget {
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final TextEditingController? controller;
  final String? customkey;
  final TextStyle? style;
  final List<TextInputFormatter>? filter;
  final Function? onChanged;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboard;
  final String? initialValue;
  final bool? enabled;
  final bool obscureText;
  final double borderWidth;
  final Color? bColor;
  final int minLength = 0;
  final String? Function(String?)? validator;
  const CommonTextInput({super.key, this.placeholder, this.placeholderStyle, this.controller, this.customkey, this.style, this.filter, this.onChanged, this.maxLength, this.maxLines, this.keyboard, this.initialValue, this.enabled, this.bColor, this.validator, this.obscureText = false, this.borderWidth = 0.5});

  @override
  Widget build(BuildContext context) {
    final borderColor = bColor??Theme.of(context).colorScheme.onSurface;
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    );
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboard,
      maxLength: maxLength,
      style : style,
      enabled : enabled,
      controller : controller,
      autovalidateMode: AutovalidateMode.always,
      validator: validator,
      inputFormatters: filter,
      obscureText : obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: RowContainer.radius,
            borderSide: BorderSide(color: borderColor, width: borderWidth)),
        counterText: "",
        focusedBorder:
        OutlineInputBorder(
          borderRadius: RowContainer.radius,
          borderSide: BorderSide(
            color : borderColor,
            width : borderWidth
          )
        ),
        hintText: placeholder,
        contentPadding: const EdgeInsets.symmetric(vertical: 0,horizontal: 16),
        hintStyle: placeholderStyle??textStyle,
        border: 
        OutlineInputBorder(
          borderRadius: RowContainer.radius,
          borderSide: BorderSide(
            color : borderColor,
            width : borderWidth
          )
        ),
        focusColor: Colors.transparent,
      ),
      onChanged:(value) => onChanged?.call(value),
    );
  }
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
  final ImagePicker picker = ImagePicker();
  final FeedImageModel imageModel = Get.put(FeedImageModel());
  void profileUpload() async{
    XFile? selectImage = await picker.pickImage(
      source : ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 30,
    );
    if (selectImage != null){
      imageModel.postProfile(selectImage);
      onUpdated?.call(imageModel.profile.value);
    }
  }

  return Stack(
    alignment: Alignment.bottomRight,
    children: [
      Profile(
        profile : current??"",
        width : 104,
        height : 104,
        borderRadius: 2.0,
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

class FormCommitButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  const FormCommitButton({
    super.key,
    this.title = "",
    required this.onPressed,
    this.backgroundColor,
    this.width,
    this.height = 48,
    this.borderRadius,
    this.fontSize = 20,
    this.fontColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : width,
      height : height,
      child: TextButton(
        style : TextButton.styleFrom(
          backgroundColor: backgroundColor??Theme.of(context).colorScheme.onPrimaryFixed,
          shape: const RoundedRectangleBorder(
            borderRadius: RowContainer.radius
          ),
        ),
        onPressed: () => onPressed.call(),
        child: Text(
          title,
          style: TextStyle(
            fontSize : fontSize,
            color : fontColor
          ),
        ),
      ),
    );
  }
}

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

void showCustomModal(BuildContext context,Widget child){
  showModalBottomSheet(
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
  );
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

class SettingRow extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? actions;
  final Function? onClick;
  const SettingRow({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height : 42,
      decoration: BoxDecoration(
        border: Border(
          bottom: rowBorderLine()
        ),
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child: Center(child: leading),
              ),
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child: Center(child: title),
              ),
              SizedBox(
                width : constraint.maxWidth * 0.33,
                child : Center(child: actions)
              )
            ],
          );
        }
      )
    );
  }
}

class SettingTitle extends StatelessWidget {
  final String title;
  const SettingTitle({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
      fontSize : 14,
      color: Theme.of(context).colorScheme.onSurface
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}
class SettingContent extends StatelessWidget {
  final List<Widget> children;
  const SettingContent({super.key,required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top : rowBorderLine()
        )
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final Function(bool)? onChanged;
  final bool value;
  const SettingSwitch({
    super.key,
    this.onChanged,
    this.value = false
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value : value,
      onChanged: onChanged,
      trackOutlineWidth: const WidgetStatePropertyAll(1),
      trackOutlineColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)?
        Colors.transparent
        :Theme.of(context).colorScheme.onSecondary;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)?
          Colors.white
          :Theme.of(context).colorScheme.onPrimaryFixed;
      }),
    );
  }
}

class MinimalVList extends StatelessWidget {
  final List<dynamic> list;
  final Function(int index)? onClick;
  const MinimalVList({super.key,required this.list,this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      width: MediaQuery.of(context).size.width,
      height : 64,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder:(context, index){
            return MinimalVRow(
              title : list[index],
              onClick: ()=>onClick?.call(index),
            );
          }
        )
      ),
    );
  }
}

class MinimalVRow extends StatelessWidget {
  final Function? onClick;
  final String title;
  const MinimalVRow({super.key,this.onClick,required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0
          ),
          side: rowBorderLine(color : Theme.of(context).colorScheme.secondary),
          shape: const RoundedRectangleBorder(
            borderRadius: RowContainer.radius
          ),
        ),
        onPressed: ()=>onClick?.call(),
        child: Text(title),
      ),
    );
  }
}