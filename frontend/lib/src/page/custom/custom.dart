import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
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

Border rowBorderLineAll(){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return Border.all(
    color: Theme.of(context).colorScheme.onSecondary,
    width: 0.5,
  );
}

BorderSide rowBorderLine(){
  BuildContext context = GlobalContext.navigatorState.currentContext!;

  return BorderSide(
    color: Theme.of(context).colorScheme.onSecondary,
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
        boxShadow: [
          BoxShadow(
            color : Theme.of(context).colorScheme.shadow,
            offset: RowContainer.offset,
            blurRadius: RowContainer.blurRadius
          )
        ]
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
  final Widget? title;
  final Widget? content;
  final List<Widget>? bottomBtns;
  const CustomDialog({
    super.key,
    this.backgroundColor,
    this.title,
    this.content,
    this.bottomBtns
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
                  title!,
                  content!,
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
          iconColor??Theme.of(context).colorScheme.onSurface,
          BlendMode.srcIn),
      ),
    );
  }
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

Widget commonTextInput(
  BuildContext context,{
    String? placeholder,
    TextStyle? placeholderStyle,
    TextEditingController? controller,
    String? key,
    TextStyle? style,
    List<TextInputFormatter>? filter,
    Function? onChanged,
    int? maxLength,
    int? maxLines,
    TextInputType? keyboard,
    String? initialValue,
    bool? enabled,
    bool obscureText = false,
    double borderWidth = 0.5,
    Color? bColor,
    int minLength = 0,
    String? Function(String?)? validator
  }
){
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
  final Function? onClick;
  final Color? backgroundColor;
  final String? heroTag;
  const CustomFloatingButton({
    this.child,this.icon,this.onClick,this.backgroundColor,this.heroTag,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'comment',
      onPressed: ()=>onClick?.call(),
      backgroundColor: backgroundColor??Theme.of(context).colorScheme.onPrimaryFixed,
      child : SizedBox(
        width : 52,
        height : 52,
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
  const CustomModalFloatingButton({
    this.child,this.icon,this.backgroundColor,
    this.heroTag,
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
      child : SizedBox(
        width : 52,
        height : 52,
        child: icon
      )
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