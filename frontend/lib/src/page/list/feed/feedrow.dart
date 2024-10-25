import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/post/share.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/component/menu/submenu.dart';
import 'package:nodove_flutter/src/component/media/carousel.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:nodove_flutter/src/page/tag/tagrow.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';
import "dart:math" as math;

class FeedRow extends StatelessWidget {
  final Feed props;

  const FeedRow({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return GestureDetector(
      onTap: ()=>Get.to(()=>FeedPage(page : props.id)),
      child: Container(
        width : maxwidth,
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
          border: Border(
            bottom: rowBorderLine()
          ),
        ),
        child: Column(
          children: [
            Column(
              children:[
                FeedTop(title : props.title, hashtags : props.hashtags),
                Carousel(imageLinks : props.imageLinks,page : props.id),
                Container(
                  margin : const EdgeInsets.only(top : 8.0),
                  width : maxwidth,
                  child : LayoutBuilder(
                    builder: (ctx,constraints) {
                      return Row(
                        children : <Widget>[
                          Profile(
                          profile: props.writerProfile,
                          width: 40,
                          height: 40
                          ),
                          Column(
                            children : [
                              SizedBox(
                                width : constraints.minWidth * 0.5,
                                child : Text(
                                  props.writerNick,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ),
                              SizedBox(
                                width : constraints.minWidth * 0.5,
                                child : Text(
                                  getDateDiff(props.createdAt),
                                  style: TextStyle(
                                    fontSize : 12,
                                    color : Theme.of(context).colorScheme.secondary,
                                  ),
                                )
                              ),
                            ]
                          )
                        ]
                      );
                    }
                  )
                ),
                FeedRowBottom(
                  userId: props.writerUserId,
                  likeCount: props.likeCount,
                  etcOpt: true,
                  postId : props.id,
                ),
                commentButton(context,id : props.id,count : props.commentCount)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
Widget commentButton (BuildContext context,{int id = 1,int count = 0}){
  return ButtonBar(
    alignment: MainAxisAlignment.center,
    children : [
      OutlinedButton.icon(
        style : OutlinedButton.styleFrom(
          fixedSize: const Size(320, 24),
          side: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.onPrimaryFixed),
        ),
        onPressed: (){
          showModalBottomSheet(
            enableDrag: true,
            useRootNavigator: true,
            isScrollControlled: true,
            context: context,
            showDragHandle: true,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            builder :(BuildContext context) {
              return Padding(
                padding : EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                child: commentList(page : id)
              );
            },
          );
        },
        icon : SvgPicture.asset(
          'assets/icons/navbar/noBorderAdd.svg',
          width : 12,
          height : 12,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
        ),
        label: Text(
          "댓글 $count개",
          style : TextStyle(
            fontSize : 18,
            color : Theme.of(context).colorScheme.onPrimaryFixed
          )
        )
      )
    ]
  );
}
class FeedRowBottom extends StatelessWidget {
  final String userId;
  final int likeCount;
  final bool etcOpt;
  final int postId;
  const FeedRowBottom({
    super.key,
    required this.userId ,
    this.likeCount = 0 ,
    this.etcOpt = false,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children : <Widget>[
        TextButton(
          onPressed: (){},
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/post/star-empty.svg',
                width : 20,
                height : 20,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
              const SizedBox(width:4),
              Text(
                "$likeCount",
                style : TextStyle(
                  fontSize : 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface
                )
              ),
            ]
          )
        ),
        IconButton(
          onPressed: (){},
          icon: SvgPicture.asset(
            'assets/icons/common/bookmark-empty.svg',
            width : 20,
            height : 20,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          )
        ),
        IconButton(
          onPressed: (){
            showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              builder: (BuildContext context){
                return ShareModal(id : postId);
            });
          },
          icon: SvgPicture.asset(
            'assets/icons/post/share.svg',
            width : 20,
            height : 20,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
          )
        ),
        if (etcOpt)
        SizedBox(
          width : 42,
          height : 42,
          child: TextButton(
            style : TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onSurface
            ),
            onPressed: (){
              showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                builder: (BuildContext context){
                  return FeedModal(context,userId,postId);
              });
            },
            child: Text(
              '•••',
              softWrap: false,
              overflow: TextOverflow.visible,
              style : TextStyle(
                fontSize : 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface
              )
            ),
          ),
        ),
      ]
    );
  }
}

Widget FeedModal (
  BuildContext context,
  String userId,
  int postId
) {
  final myid = UserState.page.id;
  return Modal(
    widget : [
      const MenuTitle(title : '이 작성자' , key : Key("작성자 제목")),
      ModalMenu(
        cb : (){},
        iconSrc : "assets/icons/navbar/certification.svg",
        title : "신고",
      ),
      ModalMenu(
        cb : (){
          Get.to(()=>UserPage(id : userId));
        },
        iconSrc : "assets/icons/navbar/user.svg",
        title : "정보",
      ),
      (myid == userId.obs)?
      Column(
        children: [
          const MenuTitle(title : '내 피드' , key : Key("내가 쓴 피드 제목")),
          ModalMenu(
            cb : (){},
            iconSrc : "assets/icons/post/edit.svg",
            title : "수정",
          ),
          ModalMenu(
            cb : (){
              Get.back();
              feedDeleteConfirm(context, postId);
            },
            iconSrc : "assets/icons/post/delete.svg",
            title : "삭제",
          )
        ],
      ):const SizedBox.shrink(),
    ]
  );
}

class Profile extends StatelessWidget {
  final String profile;
  final double width;
  final double height;
  final double? borderRadius;
  const Profile({
    super.key ,
    required this.profile ,
    this.width = 32,
    this.height = 32,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width :  width,
      height : height,
      margin : const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image : DecorationImage(
          image : customImgProvider(
            profile,
            fit : BoxFit.cover
          ),
          fit: BoxFit.cover
        ),
        borderRadius: BorderRadius.all(Radius.circular(math.min(width / 3,RowContainer.radiusV))),
        border : Border.all(
          color : Theme.of(context).colorScheme.onPrimaryFixed,
          width : borderRadius??1.0
        )
      ),
    );
  }
}
class ProfileSkel extends StatelessWidget {
  final double width;
  final double height;
  const ProfileSkel({
    super.key ,
    required this.width ,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width :  width,
      height : height,
      margin : const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color : Theme.of(context).colorScheme.onPrimaryFixed
      ),
    );
  }
}

class FeedTop extends StatelessWidget {
  final String title;
  final List<dynamic> hashtags;

  const FeedTop({super.key,required this.title,required this.hashtags});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;

    return Container(
      padding : const EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style : const TextStyle(
              fontSize : 18,
              fontWeight: FontWeight.bold
            ),
          ),
          TagRow(
            hashtags: hashtags,
            callback: (tag,index){
              Get.toNamed("/tag/${Uri.encodeComponent(tag)}");
            },
          ),
        ],
      ),
    );
  }
}



class ModalMenu extends StatelessWidget {
  final String? iconSrc;
  final String title;
  final Function? cb;
  const ModalMenu({super.key,this.iconSrc , required this.title , this.cb});

  @override
  Widget build(BuildContext context) {
    return menuBtn(
      onClick : ()=>cb?.call(),
      iconSrc : iconSrc,
      title : title,
    );
  }
}

class Modal extends StatefulWidget {
  final List<Widget> widget;
  
  const Modal({super.key,required this.widget});

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = widget.widget;
    return Padding(
      padding : const EdgeInsets.symmetric(vertical: 32),
      child: SizedBox(
        width : MediaQuery.of(context).size.width,
      
        child: Wrap(
          alignment: WrapAlignment.center,
          children : widgets
        ),
      ),
    );
  }
}

void feedDeleteConfirm(BuildContext context,int postId){
  FeedListModel con = Get.put(FeedListModel());
  showDialog(
    context : context,
    builder: (context){
      return customDialog(
        title : Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DialogCloseBtn(
              onPressed: ()=>Get.back(),
            ),
          ],
        ),
        content : const Column(
          children: [
            DialogStrTitle("삭제할까요?"),
            DialogStrContent("삭제된 피드는 다시 복구 할 수 없어요"),
          ],
        ),
        bottomBtns: [
          dialogBottomBtn(
            context,
            backgroundColor: Theme.of(context).colorScheme.error,
            onPressed: (){
              con.deleteFeed(postId);
              con.feedList.refresh();
              Get.back();
            },
            child : const Text(
              "삭제",
              style: TextStyle(
                fontSize : 18,
              ),
            )
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      );
    }
  );
}

class SkelFeedRow extends StatelessWidget {
  const SkelFeedRow({super.key});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return Container(
      width : maxwidth,
      margin : const EdgeInsets.symmetric(vertical: 4),
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
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.onPrimary,
        child: Column(
          children: [
            Column(
              children:[
                Container(
                  width : maxwidth,
                  padding : const EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width : maxwidth * 0.3,
                        height : 18,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                          borderRadius: RowContainer.radius
                        ),
                      ),
                      const SizedBox(height : 4.0),
                      Container(
                        width : maxwidth * 0.5,
                        height : 16,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                          borderRadius: RowContainer.radius
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width : maxwidth,
                  height : 420,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
                ),
                Container(
                  margin : const EdgeInsets.only(top : 8.0),
                  width : maxwidth,
                  child : LayoutBuilder(
                    builder: (ctx,constraints) {
                      return Row(
                        children : <Widget>[
                          const ProfileSkel(
                            width: 40,
                            height: 40
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children : [
                              Container(
                                width : constraints.maxWidth * 0.3,
                                height : 16,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                  borderRadius: RowContainer.radius
                                ),
                              ),
                              const SizedBox(height : 4.0),
                              Container(
                                width : constraints.maxWidth * 0.5,
                                height : 16,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                  borderRadius: RowContainer.radius
                                ),
                              ),
                            ]
                          )
                        ]
                      );
                    }
                  )
                ),
                const SizedBox(height : 4),
                Container(
                  width: maxwidth,
                  height : 20,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                    borderRadius: RowContainer.radius
                  ),
                ),
                Container(
                  margin:const EdgeInsets.only(
                    top : 8,
                  ),
                  width : maxwidth,
                  height : 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                Container(
                  width: maxwidth * 0.5,
                  height : 32,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                    borderRadius: RowContainer.radius
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
}