import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/messenger/room/addroom.dart';
import 'package:nodove_flutter/src/page/messenger/message/message.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';

class RoomPage extends StatelessWidget {
  const RoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("메신저"),
      actions: [
        NavbarCommonBtn(
        "assets/icons/user/normalusr.svg",
        onClick : (){}
        ),
        PopupMenuButton(
          color : Theme.of(context).colorScheme.onPrimary,
          shadowColor: Colors.transparent,
          shape : TooltipShape(
            vertical : 12,
            borderColor : Theme.of(context).colorScheme.shadow
          ),
          offset : const Offset(32,46),
          itemBuilder: (BuildContext context) {
            return [
              popupMenu(
                context,
                title: const NavbarTitle("대화하기",fontSize : 16),
                onClick : ()=>Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_)=>const AddRoomPage(),
                    fullscreenDialog: true
                  )
                )
              ), 
              popupMenu(
                context,
                title: const NavbarTitle("혼잣말..",fontSize : 16),
                onClick : ()=> {}
              ), 
            ];
          },
          icon: SvgPicture.asset(
            "assets/icons/navbar/noBorderAdd.svg",
            width : 18, height : 18,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.primary, BlendMode.srcIn),
          ),
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(navbarOpt,centerTitle : false,),
      body : const RoomList(),
    );
  }
}

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  RoomListModel con = Get.put(RoomListModel());

  @override
  void initState() {
    con.getRoomList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Obx(()=>
    CustomRefreshIndicator(
      onRefresh: ()=>Future.sync(()=>con.getRoomList()),
      child : roomList(context)
    ));
  }
  Widget roomList(BuildContext context){
    final list = con.roomlist;
    if(con.isFetching.isTrue){
      return CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: 5,
            itemBuilder : (BuildContext context,int index){
              return const RoomRowSkel();
            }
          )
        ],
        physics: const NeverScrollableScrollPhysics()
      );
    } else if (list.isEmpty){
      return const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child : Align(
              alignment: Alignment.topCenter,
              child : Text("대화중인 곳이 없어요")
            )
          )
        ],
        physics: AlwaysScrollableScrollPhysics(),
      );
    } else{
      return CustomScrollView(
        slivers: [
          SliverList.builder(
            itemCount: list.length,
            itemBuilder : (BuildContext context,int index){
              return RoomRow(room : list[index]);
            }
          )
        ],
        physics: const AlwaysScrollableScrollPhysics(),
      );
    }
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
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Profile(
                      profile : room.profile,
                      width : 64,height : 64,
                      borderRadius: 2,
                    ),
                    Profile(
                      profile : room.user.profile,
                      width : 32,height : 32,
                      borderRadius: 1,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              room.roomName.split("_")[0],
                              overflow: TextOverflow.ellipsis,
                              style : TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary
                              )
                            ),
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

class RoomRowSkel extends StatelessWidget {
  const RoomRowSkel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child : Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.onPrimary,
        child: LayoutBuilder(
          builder: (BuildContext context,BoxConstraints constraints) {
            return Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    ProfileSkel(
                      width : 64,height : 64,
                    ),
                    ProfileSkel(
                      width : 32,height : 32,
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              decoration: const BoxDecoration(
                                color : Colors.white,
                                borderRadius: RowContainer.radius
                              ),
                              width : constraints.maxWidth * 0.5,
                              height : 18,
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height : 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color : Colors.white,
                              borderRadius: RowContainer.radius
                            ),
                            width : constraints.maxWidth * 0.5,
                            height : 14,
                          )
                        ],
                      ),
                      const SizedBox(height : 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              color : Colors.white,
                              borderRadius: RowContainer.radius
                            ),
                            width : constraints.maxWidth * 0.25,
                            height : 14,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      )
    );
  }
}