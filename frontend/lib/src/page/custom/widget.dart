

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final bool enabled;
  final Function? onRefresh;
  final Widget? child;
  final Color? strokeColor;
  final Color? backgroundColor;
  final double displacement;
  final double edgeOffset;
  const CustomRefreshIndicator({
    super.key,
    this.enabled = true,
    this.onRefresh,
    this.child,
    this.strokeColor,
    this.backgroundColor,
    this.displacement = 54,
    this.edgeOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      edgeOffset: edgeOffset,
      displacement: displacement,
      notificationPredicate: (_)=>enabled,
      color : strokeColor??Theme.of(context).colorScheme.onPrimaryFixed,
      backgroundColor : backgroundColor??Theme.of(context).colorScheme.onPrimary,
      onRefresh: ()=>Future.sync(()=>onRefresh?.call()),
      child : child!
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
            horizontal: 2.0,
            vertical: 2.0,
          ),
          side: rowBorderLine(color : Theme.of(context).colorScheme.secondary),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
        ),
        onPressed: ()=>onClick?.call(),
        child: Text(title),
      ),
    );
  }
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

