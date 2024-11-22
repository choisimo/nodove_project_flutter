import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

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

