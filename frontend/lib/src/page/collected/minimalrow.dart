import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';

class MinimalRow extends StatelessWidget {
  final Feed props;

  const MinimalRow({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      return Container(
        alignment: Alignment.center,
        padding : const EdgeInsets.all(4),
        constraints: BoxConstraints(
          maxWidth : constraints.maxWidth * 0.9,
          maxHeight: constraints.maxHeight * 0.4,
        ),
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
          boxShadow: rowBorderShadow(),
          borderRadius: RowContainer.radius
        ),
        child : LayoutBuilder(
          builder :(cont, cons) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    props.writerNick,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    props.title,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex : 0,
                  child: Container(
                    width : cons.maxWidth,
                    padding : const EdgeInsets.all(4),
                    height : 28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width : cons.maxWidth * 0.45,
                          child : Row(
                            children: [
                              SvgPicture.asset("assets/icons/post/star.svg",
                              width : 16, height : 16,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              const SizedBox(width : 4),
                              Text(
                                "${props.likeCount??0}",
                                style : const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          width : cons.maxWidth * 0.45,
                          child : Row(
                            children: [
                              SvgPicture.asset("assets/icons/navbar/msg.svg",
                              width : 16, height : 16,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              const SizedBox(width : 4),
                              Text(
                                "${props.commentCount??0}",
                                style : const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        )
      );
    });
  }
}