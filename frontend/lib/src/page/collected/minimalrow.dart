import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/feed.dart';

class MinimalRow extends StatelessWidget {
  final Feed feed;

  const MinimalRow({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constraints){
      return Container(
        alignment: Alignment.center,
        padding : const EdgeInsets.all(4),
        child : LayoutBuilder(
          builder :(cont, cons) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          feed.title,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        EtcCommonBtn(
                          iconColor: Theme.of(context).colorScheme.primary
                        ),
                      ],
                    ),
                    Text(
                      "${feed.writerNick} | @${feed.writerUserId}",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize : 12,
                      ),
                    ),
                  ],
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
                              width : 14, height : 14,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              const SizedBox(width : 4),
                              Text(
                                "${feed.likeCount??0}",
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
                              width : 14, height : 14,
                              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                              ),
                              const SizedBox(width : 4),
                              Text(
                                "${feed.commentCount??0}",
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