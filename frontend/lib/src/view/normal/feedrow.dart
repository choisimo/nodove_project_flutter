import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/view/normal/feedlist.dart';
import 'package:nodove_flutter/src/view/page/comment.dart';
import 'package:nodove_flutter/src/view/page/page.dart';
import 'package:nodove_flutter/menu/submenu.dart';
import 'package:nodove_flutter/Slider/carousel.dart';
import 'package:nodove_flutter/tag/tagrow.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';

class FeedRow extends StatelessWidget {
  final Feed props;

  const FeedRow({Key? key, required this.props}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return GestureDetector(
      onTap:() => Get.toNamed("/view/${props.id}"),
      child: Container(
        width : maxwidth,
        margin : const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color : Theme.of(context).colorScheme.onPrimary,
          border: Border(
            bottom : BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
              width : 1
            ),
            top : BorderSide(
              color: Theme.of(context).colorScheme.onSecondary,
              width : 1
            )
          ),
        ),
        child: Column(
          children: [
            Column(
              children:[
                FeedTop(title : props.title, hashtags : props.hashtags),
                Carousel(imageLinks : props.imageLinks,page : props.id),
                SizedBox(
                  width : maxwidth,
                  child : LayoutBuilder(
                    builder: (ctx,constraints) {
                      return Row(
                        children : <Widget>[
                          const Profile(
                          profile: "https://blog.kakaocdn.net/dn/XsNHt/btrb3m0cuQb/62QmvGg1bUVrI5uZfcWEi1/img.png",
                          width: 40,
                          height: 40
                          ),
                          Column(
                            children : [
                              SizedBox(
                                width : constraints.minWidth * 0.5,
                                child : Text(
                                  props.writer,
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
                  id: props.id,
                  likeCount: props.likeCount,
                  etcOpt: true
                ),
                Container(
                  margin:const EdgeInsets.only(
                    top : 8,
                    bottom : 8,
                  ),
                  width : maxwidth,
                  height : 1,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children : [
                    OutlinedButton.icon(
                      style : OutlinedButton.styleFrom(
                        fixedSize: const Size(320, 32),
                        side: BorderSide(width: 1.0, color: CommonStyle.first),
                      ),
                      onPressed: (){
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          showDragHandle: true,
                          backgroundColor: Theme.of(context).colorScheme.onPrimary,
                          builder :(BuildContext context) {
                            return Padding(
                              padding : EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom
                              ),
                              child: commentList(context , props.id)
                            );
                          },
                        );
                      },
                      icon : SvgPicture.asset(
                        'assets/icons/navbar/noBorderAdd.svg',
                        width : 12,
                        height : 12,
                        colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                      ),
                      label: Text(
                        "댓글 ${props.commentCount}개",
                        style : const TextStyle(
                          fontSize : 18,
                          color : CommonStyle.first
                        )
                      )
                    )
                  ]
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FeedRowBottom extends StatelessWidget {
  final int id;
  final int likeCount;
  final bool etcOpt;
  const FeedRowBottom({super.key,required this.id , required this.likeCount , required this.etcOpt});

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
                colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
              Text(
                "${likeCount}",
                style : TextStyle(
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
          onPressed: (){},
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
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                builder: (BuildContext context){
                  return EtcModal(
                    id : id
                  );
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

class Profile extends StatelessWidget {
  final String profile;
  final double width;
  final double height;
  const Profile({
    super.key ,
    required this.profile ,
    required this.width ,
    required this.height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width :  width,
      height : height,
      margin : const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        image : DecorationImage(
          image : Image.network(
            profile,
            errorBuilder: (context, error, stackTrace){
              return Image.asset("assets/image/logo.png");
            },
          ).image,
          fit: BoxFit.cover
        ),
        shape: BoxShape.circle,
        border : Border.all(
          color : CommonStyle.first,
          width : 1.0
        )
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
        children: [
          SizedBox(
            width : maxwidth,
            child : Text(
              title,
              style : const TextStyle(
                fontSize : 18,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          TagRow(hashtags: hashtags),
        ],
      ),
    );
  }
}

class EtcModal extends StatelessWidget {
  final int id;
  const EtcModal({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : MediaQuery.of(context).size.width,
      height : 320,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          const MenuTitle(title : '이 작성자' , key : Key("작성자 제목")),
          MenuBtn(
            context : context,
            cb : (){},
            iconSrc : "assets/icons/navbar/certification.svg",
            title : "신고",
            tcolor : Theme.of(context).colorScheme.onSurface
          ),
          MenuBtn(
            context : context,
            cb : (){},
            iconSrc : "assets/icons/navbar/user.svg",
            title : "정보",
            tcolor : Theme.of(context).colorScheme.onSurface
          ),
          const MenuTitle(title : '내가 쓴 글' , key : Key("내가 쓴 글 제목")),
          MenuBtn(
            context : context,
            cb : (){},
            iconSrc : "assets/icons/post/edit.svg",
            title : "수정",
            tcolor : Theme.of(context).colorScheme.onSurface
          ),
          MenuBtn(
            context : context,
            cb : (){},
            iconSrc : "assets/icons/post/delete.svg",
            title : "삭제",
            tcolor : Theme.of(context).colorScheme.error
          ),
        ]
      ),
    );
  }
}