import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/src/component/menu/submenu.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/notification.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/notification/notisetting.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';

class NotiPage extends StatelessWidget {
  const NotiPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("알림"),
      actions: [
        NavbarCommonBtn(
          "post/delete.svg",
          onClick : (){},
        ),
        NavbarCommonBtn(
          "common/setting.svg",
          onClick : ()=>Navigator.push(
            context,
            MaterialPageRoute(builder: (_)=>const NotiSettingPage())
          ),
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(navbarOpt,centerTitle : false,),
      body: const NotiList()
    );
  }
}

class NotiList extends StatefulWidget {
  const NotiList({super.key});

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  final NotiListModel con = Get.put(NotiListModel());

  @override
  void initState(){
    initLoad();
    super.initState();
  }

  void initLoad() async{
    await con.getNofification();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: ()=>initLoad(),
      child: SizedBox(
        height : MediaQuery.of(context).size.height,
        child : Obx((){
          if (con.isFetching.isTrue){
            return ListView.builder(
              itemCount: 5,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surface,
                  highlightColor: Theme.of(context).colorScheme.onPrimary,
                  child: Container(
                    height : 96,
                    margin : const EdgeInsets.symmetric(vertical: 8.0),
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
                  )
                );
              }
            );
          } else if (con.notilist.isEmpty){
            return const Center(child: Text("알림이 없어요"));
          } else {
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: con.notilist.length,
              itemBuilder:(BuildContext context,int index){
                return Dismissible(
                  background: Container(
                    color: Theme.of(context).colorScheme.error,
                    child : Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "삭제",
                          style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.onPrimary
                          ),
                        ),
                      ),
                    )
                  ),
                  direction: DismissDirection.endToStart,
                  key : Key(con.notilist[index].toString()),
                  onDismissed: (direction){
                    /*if (direction == DismissDirection.endToStart){
                      con.deleteNotification(index);
                    }*/
                  },
                  child: NotiRow(
                    notification: con.notilist[index],
                    index : index
                  )
                );
              }
            );
          }
        }),
      )
    );
  }
}
class NotiRow extends StatelessWidget {
  final Noti notification;
  final int index;
  const NotiRow({
    super.key,
    required this.notification,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final NotiListModel con = Get.put(NotiListModel());
    return GestureDetector(
      onTap: ()=>Get.to(()=>FeedPage(page: notification.postId,)),
      onLongPress: (){
        showModalBottomSheet(
          useRootNavigator : true,
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          builder:(context){
            return Modal(
              widget : [
                const MenuTitle(title: "이 피드"),
                ModalMenu(
                  iconSrc: "navbar/certification.svg",
                  title: "보기",
                  cb: (){
                    Get.back();
                    Get.toNamed("/view/${notification.postId}");
                  },
                ),
                ModalMenu(
                  iconSrc: "navbar/user.svg",
                  title: "유저 보기",
                  cb: (){
                    Get.back();
                    //Get.toNamed(()=>UserPage(id : notification.));
                  },
                ),
                const MenuTitle(title: "이 알림"),
                ModalMenu(
                  iconSrc: "post/delete.svg",
                  title: "삭제",
                  cb: (){
                    con.deleteNotification(index);
                    Get.back();
                  },
                ),
              ]
            );
          }
        );
      },
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        notification.senderNickname,
                        style : TextStyle(
                          fontSize: 18,
                          color : Theme.of(context).colorScheme.onPrimaryFixed,
                          fontWeight: FontWeight.bold,
                        )
                      ),
                      Text(
                        "님이 내 피드에 댓글을 남기셨어요",
                        style : TextStyle(
                          fontSize: 16,
                          color : Theme.of(context).colorScheme.primary,
                        )
                      )
                    ],
                  ),
                  Text(
                    getDateDiff(notification.alarmDate),
                    textAlign: TextAlign.start,
                    style : TextStyle(
                      fontSize : 14,
                      color : Theme.of(context).colorScheme.secondary,
                    )
                  ),
                ],
              ),
              Text(
                notification.postTitle,
                textAlign: TextAlign.start,
                style : TextStyle(
                  fontSize : 14,
                  color : Theme.of(context).colorScheme.secondary,
                )
              ),
              Text(
                notification.commentContent,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style : TextStyle(
                  fontSize : 14,
                  color : Theme.of(context).colorScheme.primary,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}