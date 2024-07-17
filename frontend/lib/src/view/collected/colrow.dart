import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/view/collected/minimalrow.dart';

class CollectedRow extends StatelessWidget {
  final Feed props;

  const CollectedRow({Key? key, required this.props}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
    final List<dynamic> imageLinks = props.imageLinks;
  
    return GestureDetector(
      onTap:() => Get.toNamed("/view/${props.id}"),
      child: Stack(
        alignment: AlignmentDirectional.center,
        fit : StackFit.loose,
        children: [
          SizedBox(
            width : maxwidth,
            height : maxwidth,
            child: 
            (imageLinks.isNotEmpty)?
            Image.network(
              props.imageLinks[0]??"",
              fit : BoxFit.cover,
              errorBuilder :(context, error, stackTrace){
                return Image.asset("assets/images/logo.png",fit : BoxFit.cover);
              },
            ):const SizedBox.shrink(),
          ),
          MinimalRow(props : props)
        ],
      ),
    );
  }
}