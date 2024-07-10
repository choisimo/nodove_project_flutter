import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/menu/button.dart';
import 'package:nodove_flutter/Slider/carousel.dart';
import 'package:nodove_flutter/tag/tagrow.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/Feed/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';

class FeedRow extends StatelessWidget {
  final Feed props;

  const FeedRow({Key? key, required this.props}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    final maxwidth = MediaQuery.of(context).size.width;
  
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width : maxwidth,
          margin : const EdgeInsets.only(bottom : 8),
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
                  Container(
                    padding : EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                    child: Column(
                      children: [
                        SizedBox(
                          width : maxwidth,
                          height : 22 ,
                          child : Text(
                            props.title,
                            style : const TextStyle(
                              fontSize : 18,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        TagRow(hashtags: props.hashtags),
                      ],
                    ),
                  ),
                  Carousel(imageLinks : props.imageLinks),
                  SizedBox(
                    width : maxwidth,
                    child : LayoutBuilder(
                      builder: (ctx,constraints) {
                        return Row(
                          children : <Widget>[
                            Container(
                              width : 40,
                              height : 40,
                              margin : const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image : const DecorationImage(
                                  image : NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjPUIml6Om23S7fyaRQtihfScn2SkZA97j_A&s'),
                                  fit: BoxFit.cover
                                ),
                                shape: BoxShape.circle,
                                border : Border.all(
                                  color : CommonStyle.first,
                                  width : 1.0
                                )
                              ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children : <Widget>[
                      Row(
                        children: [
                          IconButton(
                            onPressed: (){},
                            icon: SvgPicture.asset(
                              'assets/icons/post/star-empty.svg',
                              width : 20,
                              height : 20,
                              colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                            )
                          ),
                          Text(
                            "${props.likeCount}",
                            style : TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onBackground
                            )
                          ),
                        ],
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          
                        ),
                        onPressed: (){},
                        icon: SvgPicture.asset(
                          'assets/icons/common/bookmark-empty.svg',
                          width : 20,
                          height : 20,
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
                        )
                      ),
                      IconButton(
                        style: const ButtonStyle(
                          
                        ),
                        onPressed: (){},
                        icon: SvgPicture.asset(
                          'assets/icons/post/share.svg',
                          width : 20,
                          height : 20,
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
                        )
                      ),
                      TextButton(
                        style: IconButton.styleFrom(
                          
                        ),
                        onPressed: (){
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Theme.of(context).colorScheme.onPrimary,
                            builder: (BuildContext context){
                              return sharemodal(context);
                            });
                        },
                        child: Text(
                          '•••',
                          textDirection: TextDirection.ltr,
                          style : TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground

                          )
                        )
                      ),
                    ]
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
                        onPressed: (){},
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
      ],
    );
  }
  Widget sharemodal(context){
    return Container(
      width : MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          Text("이 작성자.."),
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
            iconSrc : "assets/icons/navbar/certification.svg",
            title : "삭제",
            tcolor : Theme.of(context).colorScheme.error
          ),
        ]
      ),
    );
  }
  
  
}