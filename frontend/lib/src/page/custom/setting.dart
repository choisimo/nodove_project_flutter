import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';

class SettingRow extends StatelessWidget {
  final Widget? title;
  final Widget? leading;
  final Widget? actions;
  final void Function()? onClick;
  const SettingRow({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.onClick
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        height : 42,
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
        ),
        child : LayoutBuilder(
          builder : (context,constraint){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(child: leading),
                ),
                Expanded(
                  child: Center(child: title),
                ),
                Expanded(
                  child: Center(child: actions)
                )
              ],
            );
          }
        )
      ),
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
      margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8.0),
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
      width : double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border(
          bottom : rowBorderLine()
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
      trackColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)?
          Theme.of(context).colorScheme.onPrimaryFixed
          :Colors.transparent;
      }),
      trackOutlineWidth: const WidgetStatePropertyAll(1),
      trackOutlineColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)?
        Colors.transparent
        :Theme.of(context).colorScheme.secondary;
      }),
      thumbColor: WidgetStateProperty.resolveWith((state){
        return state.contains(WidgetState.selected)?
        Theme.of(context).colorScheme.onPrimary
        :Theme.of(context).colorScheme.secondary;
      }),
    );
  }
}

class SettingToggle extends StatelessWidget {
  final List<bool> isSelected;
  final void Function(int index)? onPressed;
  final List<Widget> children;
  const SettingToggle({
    super.key,
    required this.isSelected,
    required this.children,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      borderColor: Theme.of(context).colorScheme.onSecondary,
      selectedColor: Theme.of(context).colorScheme.onPrimaryFixed,
      splashColor: Colors.transparent,
      borderRadius: RowContainer.radius,
      isSelected: isSelected,
      onPressed: onPressed,
      children: children,
    );
  }
}