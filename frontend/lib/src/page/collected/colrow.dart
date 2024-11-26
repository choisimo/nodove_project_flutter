import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/collected/minimalrow.dart';
import 'package:nodove_flutter/state/color.dart';

class CollectedRow extends StatelessWidget {
  final Feed feed;

  const CollectedRow({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
    final List<dynamic> imageLinks = feed.imageLinks;
  
    return GestureDetector(
      onTap:() => Get.toNamed("/view/${feed.id}"),
      child: SizedBox(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface
                ),
                width : maxwidth,
                child: 
                (imageLinks.isNotEmpty)?
                CustomImage(
                  feed.imageLinks[0]??"",
                  fit : BoxFit.cover,
                ):const SizedBox.shrink(),
              ),
            ),
            MinimalRow(feed : feed)
          ],
        ),
      ),
    );
  }
}

class CollectedVRow extends StatelessWidget {
  final Feed feed;
  final Function(int page)? onFeedClick;

  const CollectedVRow({super.key, required this.feed,this.onFeedClick});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> imageLinks = feed.imageLinks;
    final int defaultIndex = feed.defaultIndex;
    double width = 200;
    double height = 240;
  
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: ()=>onFeedClick?.call(feed.id),
      child: Container(
        width : width,
        height : height,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            SizedBox(
              width: width * 0.9,
              child: AspectRatio(
                aspectRatio : 16/9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    image: DecorationImage(
                      fit : BoxFit.cover,
                      image: 
                      customImgProvider(
                        (imageLinks.isNotEmpty)?imageLinks[defaultIndex]:"",
                      )
                    )
                  ),
                ),
              ),
            ),
            MinimalRow(feed : feed),
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