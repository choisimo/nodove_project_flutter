import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/menu/submenu.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/media/carousel.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:shimmer/shimmer.dart';

class FeedPage extends StatefulWidget{
  final int? page;
  final String url = "${Url.apiUrl}${Url.feedPage}";
  FeedPage({
    super.key,
    this.page,
  });

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{
  final FeedListModel vpage = Get.put(FeedListModel());
  final CommentPageModel con = Get.put(CommentPageModel());

  @override
  Widget build(BuildContext context){
    int page = widget.page??int.parse(Get.parameters['page']??'3');
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context,callback: ()=>Navigator.of(context).pop()),
      actions : <Widget>[
        etcBtn(
          cb : (id){
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            builder: (BuildContext context){
              return Obx(()=>FeedModal(context,vpage.content.value.writerUserId,id));
          });
        }, id : page),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,true),
      floatingActionButton: commentButton(),
      body : FeedView(
        page : page,
        url : widget.url,
      )
    );
  }
  Widget commentButton(){
    int page = widget.page??int.parse(Get.parameters['page']??'3');
    PageUrl url = ViewPageState.page.comment.value;
    return FloatingActionButton(
      heroTag: 'comment',
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
              child: commentList(page : page)
            );
          },
        );
      },
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      child : SvgPicture.asset(
        'assets/icons/navbar/msg.svg',
        width : 24,
        height : 24,
        colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn),
      )
    );
  }
}

class FeedView extends StatefulWidget {
  final int page;
  final String url;

  const FeedView({
    super.key ,
    required this.page,
    required this.url
  });
  
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final GlobalKey<FormState> commentTopKey = GlobalKey<FormState>();
  final FeedListModel vcon = Get.put(FeedListModel());
  final CommentPageModel con = Get.put(CommentPageModel());
  int maxPage = 5;
  int pageKey = 0;

  Future<void> refresh() async{
    PageUrl url = ViewPageState.page.comment.value;
    con.getCommentFirst(url.url,url.opt);
  }

  @override
  void initState() {
    ViewPageState.page.setView(widget.url,"/${widget.page}");
    vcon.getFeedPage(widget.page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration commonDecor = BoxDecoration(
      color : Theme.of(context).colorScheme.onPrimary,
      border : Border.symmetric(
        horizontal: BorderSide(
          width : 0.5,
          color : Theme.of(context).colorScheme.onSecondary,
        )
      ),
    );

    return Obx((){
        final feed = vcon.content.value;
        if (vcon.isFetching.isFalse){
          return customRefreshIndicator(
            context,
            onRefresh: ()=>refresh(),
            strokeColor : Theme.of(context).colorScheme.onSurface,
            backgroundColor : Theme.of(context).colorScheme.onPrimary,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height : 8),
                  Container(
                    decoration: commonDecor,
                    child:FeedTop(title: feed.title,hashtags: feed.hashtags)
                  ),
                  const SizedBox(height : 8),
                  Carousel(imageLinks: feed.imageLinks, page: feed.id),
                  const SizedBox(height : 8),
                  Container(
                    decoration: commonDecor,
                    constraints:BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.75
                    ),
                    child: Column(
                      children: [
                        pageUserInfo(
                          feed.writerUserId,
                          userProfile: feed.writerProfile,
                          userName: feed.writerNick,
                          createdAt: feed.createdAt,
                          updatedAt : feed.updatedAt
                        ),
                        Html(data: feed.content),
                        FeedRowBottom(
                          userId: feed.writerUserId,
                          likeCount: feed.likeCount,
                          etcOpt: false,
                          postId: feed.id,
                        ),
                        Container(
                          height : 64,
                          decoration: BoxDecoration(
                            border : Border.symmetric(horizontal: BorderSide(width: 0.5,color : Theme.of(context).colorScheme.onSecondary))
                          ),
                          child: commentButton(context,id : feed.id,count : feed.commentCount)
                        ),
                      ],
                    )
                  )
                ],
              ),
            ),
          );
        } else{
          return const FeedViewSkel();
        }
      }
    );
  }
  Widget pageUserInfo(
    String userId,
    {
      String userProfile = "", 
      String userName = "", String createdAt = "",
      String updatedAt = "", List<String>? group
    }
    
  ){
    return GestureDetector(
      onTap: ()=>Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_)=>UserPage(id : userId)
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Profile(
            profile: userProfile,
            width: 56,
            height: 56
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children : [
              Text(
                userName,
                style: const TextStyle(
                  height : 1.16,
                  fontSize : 18,
                  fontWeight: FontWeight.bold,
                )
              ),
              Text(
                group?.toString()??"소속 없음",
                style: TextStyle(
                  height : 1.125,
                  fontSize: 16,
                  color : Theme.of(context).colorScheme.secondary,
                ),
              ),
              Text(
                "${getDateFull(createdAt)} 작성됨",
                style: TextStyle(
                  height : 1.33,
                  fontSize: 12,
                  color : Theme.of(context).colorScheme.secondary,
                ),
              ),
              (createdAt != updatedAt)?
              Text(
                "${getDateFull(updatedAt)} 수정됨",
                style: TextStyle(
                  height : 1.33,
                  fontSize : 12,
                  color : Theme.of(context).colorScheme.secondary,
                ),
              ):const SizedBox.shrink(),
            ]
          )
        ],
      ),
    );
  }
}

class FeedViewSkel extends StatelessWidget {
  const FeedViewSkel({super.key});

  @override
  Widget build(BuildContext context) {
    BoxDecoration commonDecor = BoxDecoration(
      color : Theme.of(context).colorScheme.onPrimary,
      border : Border.symmetric(
        horizontal: BorderSide(
          width : 0.5,
          color : Theme.of(context).colorScheme.onSecondary,
        )
      ),
    );
    final maxwidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: LayoutBuilder(
        builder: (context,constraints) {
          return Column(
            children: [
              const SizedBox(height : 8),
              Container(
                width : maxwidth,
                padding : const EdgeInsets.all(4),
                decoration: commonDecor,
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surface,
                  highlightColor: Theme.of(context).colorScheme.onPrimary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width : maxwidth * 0.3,
                        height : 18,
                        decoration:BoxDecoration(
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
              ),
              const SizedBox(height : 8),
              Shimmer.fromColors(
                baseColor: Theme.of(context).colorScheme.surface,
                highlightColor: Theme.of(context).colorScheme.onPrimary,
                child: Container(
                  width : maxwidth,
                  height : 420,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
                ),
              ),
              const SizedBox(height : 8),
              Container(
                decoration: commonDecor,
                constraints:BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.75
                ),
                child: Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.surface,
                  highlightColor: Theme.of(context).colorScheme.onPrimary,  
                  child: Column(
                    children: [
                      const SizedBox(height : 4),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const ProfileSkel(
                            width: 56,
                            height: 56
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              const SizedBox(height : 4),
                              Container(
                                width : constraints.maxWidth * 0.5,
                                height : 14,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                  borderRadius: RowContainer.radius
                                ),
                              ),
                              const SizedBox(height : 4),
                              Container(
                                width : constraints.maxWidth * 0.5,
                                height : 14,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                                  borderRadius: RowContainer.radius
                                ),
                              ),
                              const SizedBox(height : 4),
                            ]
                          )
                        ],
                      ),
                      const SizedBox(height : 4),
                      Container(
                        height : 120,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                      ),
                      const SizedBox(height : 4),
                      Container(
                        height : 20,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                      ),
                      const SizedBox(height : 4),
                      Container(
                        width : constraints.maxWidth * 0.5,
                        height : 32,
                        decoration: BoxDecoration(
                          borderRadius: RowContainer.radius,
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                      ),
                    ],
                  ),
                )
              )
            ],
          );
        }
      ),
    );
  }
}
//CollectedRow
/*
ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: FeedView.length,
              itemBuilder: (BuildContext cont,int index){
                return FeedRow(props : FeedView[index]);
              }
            );
*/