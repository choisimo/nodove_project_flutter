import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/post/share.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/component/menu/submenu.dart';
import 'package:nodove_flutter/src/component/media/carousel.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:nodove_flutter/src/page/tag/tagrow.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';
/*
TextButton(
style : TextButton.styleFrom(
  foregroundColor: Theme.of(context).colorScheme.onSurface
),
onPressed: (){
  
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
)

 */
class FeedRow extends StatelessWidget {
  final Feed feed;

  const FeedRow({super.key, required this.feed});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return GestureDetector(
      onTap: ()=>
        showCustomModal(context,CommentListModal(page : feed.id)),
      child: Container(
      width : maxwidth * 0.9,
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimary,
        border: Border(
          bottom: rowBorderLine()
        ),
      ),
      child: Column(
        children:[
          Carousel(imageLinks : feed.imageLinks,page : feed.id),
          FeedContent(feed: feed,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FeedRowBottom(feed : feed),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "좋아요 ${feed.likeCount} | 댓글 ${feed.commentCount}",
                  style : TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                  )
                ),
              ),
            ],
          ),
          Container(
            width : double.infinity,
            height : 0.5,
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary
            ),
          )
        ],
      ),
    ));
  }
}

/*Text(
          "댓글 $count",
          style : TextStyle(
            fontSize : 18,
            color : Theme.of(context).colorScheme.onPrimaryFixed
          )
        ) */

class FeedRowBottom extends StatelessWidget {
  final Feed feed;
  final double iconSize;
  const FeedRowBottom({
    super.key,
    required this.feed,
    this.iconSize = 16,
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
              CustomSvg(
                'post/star-empty.svg',
                width : iconSize,
                height : iconSize,
              ),
              const SizedBox(width:4),
              Text(
                "${feed.likeCount}",
                style : TextStyle(
                  fontSize : 16,
                  color: Theme.of(context).colorScheme.onSurface
                )
              ),
            ]
          )
        ),
        IconButton(
          onPressed: (){},
          icon: CustomSvg(
            'post/bookmark-empty.svg',
            height : iconSize + 2,
          )
        ),
        IconButton(
          onPressed: (){
            showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              builder: (BuildContext context){
                return ShareModal(url : "${Url.clientList}?page=$feed.id");
            });
          },
          icon: CustomSvg(
            'post/share.svg',
            width : iconSize,
            height : iconSize,
          )
        ),
      ]
    );
  }
}

class FeedModal extends StatelessWidget {
  final String userId;
  final int postId;
  const FeedModal({
    super.key,
    required this.userId,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    String myid = UserState.page.id.value;
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
        borderRadius: BorderRadius.all(Radius.circular(width)),
        border : Border.all(
          color : Theme.of(context).colorScheme.onSecondary,
          width : borderRadius??1.0
        )
      ),
    );
  }
}

class FeedContent extends StatelessWidget {
  final Feed feed;
  const FeedContent({super.key,required this.feed});

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
      Container(
        margin : const EdgeInsets.only(top : 8.0),
        width : maxwidth,
        child : LayoutBuilder(
          builder: (ctx,constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children : <Widget>[
                    Profile(
                      profile: feed.writerProfile,
                      width: 40,
                      height: 40
                    ),
                    Column(
                      children : [
                        SizedBox(
                          width : constraints.minWidth * 0.5,
                          child : Text(
                            feed.writerNick,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ),
                        SizedBox(
                          width : constraints.minWidth * 0.5,
                          child : Text(
                            "소속 없음 | ${getDateDiff(feed.createdAt)}",
                            style: TextStyle(
                              fontSize : 12,
                              color : Theme.of(context).colorScheme.secondary,
                            ),
                          )
                        ),
                      ]
                    )
                  ]
                ),
                EtcCommonBtn(
                  iconSize: 32,
                  onClick: ()=>showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    builder: (BuildContext context){
                      return FeedModal(userId : feed.writerUserId,postId : feed.id);
                  }),
                ),
              ],
            );
          }
        )
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
        child: TagRow(
          hashtags: feed.hashtags,
          callback: (tag,index){
            Get.toNamed("/tag/${Uri.encodeComponent(tag)}");
          },
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Html(data: feed.content),
      ),
      ],
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
    return Container(
      width: double.infinity,
      padding : const EdgeInsets.all(4),
      child: Text(
        title,
        style : const TextStyle(
          fontSize : 18,
          fontWeight: FontWeight.bold
        ),
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
      padding : const EdgeInsets.only(top : 16 , bottom: 32),
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
      return CustomDialog(
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
          DialogBottomBtn(
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
        baseColor: Theme.of(context).colorScheme.onSecondary,
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