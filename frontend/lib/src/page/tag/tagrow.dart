import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/page/list/other/taglist.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';

class TagRow extends StatefulWidget {
  final List<dynamic>? hashtags;
  final Function? callback;
  const TagRow({
    super.key,
    required this.hashtags,
    this.callback,
  });

  @override
  State<TagRow> createState() => _TagRowState();
}

class _TagRowState extends State<TagRow> {
  final TagListModel tagModel = Get.put(TagListModel());

  @override
  void initState() {
    final List<String> tags = List<String>.from(widget.hashtags as List);
    tagModel.addTagList(tags);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> hashtags = tagModel.tagList;
    final maxwidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width : maxwidth,
      child : Obx(()=>Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        spacing : 8,
        children: List.generate(hashtags.length, (index){
           return TextButton(
            onPressed: ()=>widget.callback?.call(hashtags[index],index),
            style : TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "#${hashtags[index]}",
              style: TextStyle(
                fontSize : 16,
                color : Theme.of(context).colorScheme.onPrimaryFixed,
              ),
            ),
          );
        }) 
      ))
    );
  }
}