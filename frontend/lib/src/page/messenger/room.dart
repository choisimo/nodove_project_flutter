import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feedrow.dart';
import 'package:nodove_flutter/src/page/messenger/message.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/dummy.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(context,"메신저",20),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false,),
      body : const RoomList()
    );
  }
}

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  @override
  Widget build(BuildContext context) {
    final list = Dump.friendLists;
    return customRefreshIndicator(
      context,
      onRefresh: ()=>Future.sync(()=>setState((){})),
      child : CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: list.length,
            itemBuilder : (BuildContext context,int index){
              return RoomRow(room : list[index]);
            }
          )
        ],
        physics: const AlwaysScrollableScrollPhysics(),
      )
    );
  }
}

class RoomRow extends StatelessWidget {
  final Room room;
  const RoomRow({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(()=>MessagePage(room : room)),
      child: Container(
        height : 96,
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color : Theme.of(context).colorScheme.shadow,
              offset: RowContainer.offset,
              blurRadius: RowContainer.blurRadius
            )
          ],
        ),
        child : LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Profile(
                  profile : room.user.profile,
                  width : 56,height : 56,
                  borderRadius: 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            room.user.username,
                            style : TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary
                            )
                          ),
                          const SizedBox(width : 4),
                          Text(
                            "@${room.user.userId}",
                            style : TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary
                            )
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              room.lastMsg.content,
                              maxLines: 2,
                              softWrap: true,
                              textAlign: TextAlign.left,
                              style : TextStyle(
                                fontSize: 14,
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).colorScheme.secondary
                              )
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            getDateDiff(room.lastMsg.createdAt),
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
                  ),
                ),
              ],
            );
          }
        )
      ),
    );
  }
}