import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/feed.dart';

class MinimalRow extends StatelessWidget {
  final Feed feed;

  const MinimalRow({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    TextStyle nicknameStyle = TextStyle(
      fontSize : 12,
    );
    return Container(
      child : Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  feed.title,
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize : 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              EtcCommonBtn(
                iconColor: Theme.of(context).colorScheme.primary
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child : Text(
                  feed.writerNick,
                  overflow: TextOverflow.ellipsis,
                  style : nicknameStyle
                ),
              ),
              Text(
                " | ",
                overflow: TextOverflow.ellipsis,
                style : nicknameStyle
              ),
              Flexible(
                child: Text(
                  "@${feed.writerUserId}",
                  overflow: TextOverflow.ellipsis,
                  style : nicknameStyle
                ),
              )
            ],
          ),
          Text(
            "좋아요 ${feed.likeCount??0} | 댓글 ${feed.commentCount??0}",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 12
            ),
          ),
        ],
      )
    );
  }
}