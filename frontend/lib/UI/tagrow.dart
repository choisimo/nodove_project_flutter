import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nodove_flutter/state/color.dart';

class TagRow extends StatelessWidget {
  final List<dynamic>? hashtags;
  const TagRow({super.key,required this.hashtags});
  
  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;

    return Container(
      width : maxwidth,
      child : Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing : 8,
        children: [
        for(int i = 0;i < hashtags!.length;i++)
          TextButton(
            onPressed: (){},
            child: Text(
              "#${hashtags![i]}",
              style: TextStyle(
                fontSize : 16,
                color : CommonStyle.first,
              ),
            ),
          ),
        ],
      )
    );
  }
}