import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/page/list/feedrow.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/dummy.dart';

class MessagePage extends StatelessWidget {
  final Room room;
  const MessagePage({
    required this.room,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(
        context,
        callback: ()=>Get.back()
      ),
      title : navbarTitle(context,room.roomName??room.user.nickname,16),
      actions: [
        etcBtn(id: room.roomId)
      ]
    );
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: navbarTop(context, navbarOpt, true),
          body : const MessageList(),
          bottomNavigationBar: const MessageBottomWrite(),
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    
    final list = Dump.chatLists;
    return CustomScrollView(
      primary: false,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      reverse: true,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Message(chat : list[index]),
            childCount: list.length,
          ),
        )
      ],
    );
  }
}

class MessageBottomWrite extends StatefulWidget {
  const MessageBottomWrite({super.key});

  @override
  State<MessageBottomWrite> createState() => _MessageBottomWriteState();
}

class _MessageBottomWriteState extends State<MessageBottomWrite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(4),
        child: CustomWrite(
          focus: false,
          callback: (content){
        
          },
        ),
      ),
    );
  }
}

class Message extends StatelessWidget {
  final Chat chat;
  const Message({
    super.key,
    required this.chat
  });

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      width : maxwidth,
      child : Row(
        children: [
          Profile(
            profile: chat.user.profile,
            width: 52,
            height: 52,
            borderRadius: 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                chat.user.nickname,
                style : TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary
                )
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: 24,
                  maxWidth: maxwidth * 0.8,
                ),
                decoration: BoxDecoration(
                  borderRadius: RowContainer.radius,
                  color: Theme.of(context).colorScheme.onPrimary
                ),
                child : Html(
                  data : """<p>${chat.content.content}</p>""",
                  style : {
                    "*" : Style(
                      display: Display.inlineBlock
                    ),
                    "p" : Style(
                      whiteSpace: WhiteSpace.pre,
                      color : Theme.of(context).colorScheme.primary,
                      margin: Margins.all(4),
                      fontSize:FontSize(16),
                    ), 
                  }
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    getDateDiff(chat.content.createdAt),
                    maxLines: 1,
                    textAlign: TextAlign.left,
                    style : TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary
                    )
                  ),
                ],
              )
            ],
          )
        ],
      )
    );
  }
}