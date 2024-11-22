import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/func/socket/socket.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/user.dart';


class MessagePage extends StatefulWidget {
  final Room room;
  const MessagePage({
    required this.room,
    super.key
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  SocketIO socket = SocketIO();
  int pageKey = 0;
  int size = 15;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Room room = widget.room;
      socket.loadingPrevious(room.roomId,pageKey,size);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Room room = widget.room;
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(
        onPressed: ()=>Get.back()
      ),
      title : NavbarTitle(
        room.roomName.split("_")[0]
      ),
      actions: [
        etcBtn(id: room.roomId)
        
      ]
    );
    return GestureDetector(
      onTap: ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: NavbarTop(navbarOpt, centerTitle : true),
          body : const MessageList(),
          bottomNavigationBar: MessageBottomWrite(
            socket : socket , room : room
          ),
        ),
      ),
    );
  }
}

class MessageList extends StatefulWidget {
  const MessageList({
    super.key,
  });

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList>{
  ScrollController scrollController = ScrollController();
  RoomListModel con = Get.put(RoomListModel());

  @override
  Widget build(BuildContext context) {
    final list = con.roomlist;
    return CustomScrollView(
      primary: false,
      physics: const AlwaysScrollableScrollPhysics(),
      controller: scrollController,
      reverse: true,
      slivers: const [
        /*SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Message(chat : list[index]),
            childCount: list.length,
          ),
        )*/
      ],
    );
  }
}

class MessageBottomWrite extends StatefulWidget {
  final Room room;
  final SocketIO socket;
  const MessageBottomWrite({
    super.key,
    required this.socket,
    required this.room
  });

  @override
  State<MessageBottomWrite> createState() => _MessageBottomWriteState();
}

class _MessageBottomWriteState extends State<MessageBottomWrite> {
  @override
  Widget build(BuildContext context) {
    SocketIO socket = widget.socket;
    final UserState userState = Get.find();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border(
          top: rowBorderLine()
        )
      ),
      child: SafeArea(
        minimum: const EdgeInsets.all(4),
        child: CustomWrite(
          focus: false,
          placeholder: "메세지를 남겨주세요",
          onPressed: (content){
            socket.sendMessage({
              "sender": userState.id.value,
              "content": content,
              "roomId": widget.room.roomId
            });
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