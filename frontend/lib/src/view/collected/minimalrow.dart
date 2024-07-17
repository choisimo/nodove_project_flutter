import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';

class MinimalRow extends StatelessWidget {
  final Feed props;

  const MinimalRow({Key? key, required this.props}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return LayoutBuilder(builder: (context,constraints){
      return Container(
        alignment: Alignment.center,
        padding : EdgeInsets.all(4),
        constraints: BoxConstraints(
          maxWidth : constraints.maxWidth * 0.9,
          maxHeight: constraints.maxHeight * 0.4,
        ),
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
          boxShadow: const [
            RowContainer.shadow
          ],
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
                    props.writer,
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
                    style: TextStyle(
                      fontSize : 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width : cons.maxWidth,
                    padding : EdgeInsets.all(4),
                    height : 28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width : cons.maxWidth * 0.45,
                          child : Row(
                            children: [
                              SvgPicture.asset("assets/icons/post/star.svg",
                              width : 20, height : 20,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              const SizedBox(width : 4),
                              Text(
                                "${props.likeCount}",
                                style : const TextStyle(
                                  fontSize : 16,
                                  fontWeight: FontWeight.bold,
                                )
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          width : cons.maxWidth * 0.5,
                          child : Row(
                            children: [
                              SvgPicture.asset("assets/icons/navbar/msg.svg",
                              width : 20, height : 20,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              SizedBox(width : 4),
                              Text(
                                "${props.commentCount}",
                                style : const TextStyle(
                                  fontSize : 16,
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