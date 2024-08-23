import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/collected/minimalrow.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';

class CollectedRow extends StatelessWidget {
  final Feed props;

  const CollectedRow({super.key, required this.props});

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

class CollectedVRow extends StatelessWidget {
  final Feed props;

  const CollectedVRow({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imageLinks = props.imageLinks;
    double size = 280;
  
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:() => Get.toNamed("/view/${props.id}"),
      child: Container(
        decoration: const BoxDecoration(
          color : Colors.transparent
        ),
        width : size,
        height : size,
        margin: const EdgeInsets.all(4),
        padding : const EdgeInsets.all(8),
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit : StackFit.loose,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                image: DecorationImage(
                  fit : BoxFit.cover,
                  image: 
                  customImgProvider(
                    (props.imageLinks.isNotEmpty)?props.imageLinks[0]:"",
                  )
                )
              ),
            ),
            MinimalRow(props : props)
          ],
        ),
      )
    );
  }
}

class CollectedVRowSkel extends StatelessWidget {
  const CollectedVRowSkel({super.key});

  @override
  Widget build(BuildContext context) {
    double size = 280;
    return Container(
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimaryFixed,
        borderRadius: RowContainer.radius
      ),
      width : size,
      height : size,
      margin: const EdgeInsets.all(4),
      padding : const EdgeInsets.all(8),
    );
  }
}