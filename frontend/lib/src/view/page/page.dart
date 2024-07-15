import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/src/view/page/comment.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/Slider/carousel.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget{
  final int page = int.parse(Get.parameters['page']??'3');
  final String url = "${Url.apiUrl}${Url.feedPage}";
  FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{
  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context),
      actions : <Widget>[
        etcBtn(context, (id){
          showModalBottomSheet(
            context: context,
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            builder: (BuildContext context){
              return EtcModal(
                id : id
              );
          });
        }, widget.page),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: navbarTop(context,navbarOpt,true),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButton: commentButton(),
      body : ChangeNotifierProvider<PageViewModel>(
        create : (context) => PageViewModel(),
        child : FeedView(
          page : widget.page,
          url : widget.url,
        )
      ),
    );
  }
  Widget commentButton(){
    return FloatingActionButton(
      onPressed: (){},
      backgroundColor: CommonStyle.first,
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
  const FeedView({super.key ,
  required this.page,
  required this.url
  });
  
  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  late Feed feed;

  Future<void> refresh() async{
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration commonDecor = BoxDecoration(
      color : Theme.of(context).colorScheme.onPrimary,
      border : Border.symmetric(
        horizontal: BorderSide(
          width :1,
          color : Theme.of(context).colorScheme.onSecondary,
        )
      ),
    );
    return Consumer<PageViewModel>(
      builder : (con,prov,child){
        feed = prov.feed;
        return RefreshIndicator(
          onRefresh: ()=>refresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height : 8),
                Container(
                  decoration: commonDecor,
                  child:FeedTop(title: feed.title,hashtags: feed.hashtags)
                ),
                SizedBox(height : 8),
                Carousel(imageLinks: feed.imageLinks, page: feed.id),
                SizedBox(height : 8),
                Container(
                  decoration: commonDecor,
                  child: Column(
                    children: [
                      pageUserInfo(feed.writer, feed.createdAt, feed.updatedAt, []),
                      Html(data: feed.content),
                      FeedRowBottom(
                        id: feed.id,
                        likeCount: feed.likeCount,
                        etcOpt: false
                      ),
                      Container(
                        width : double.infinity,
                        height : 1 ,
                        decoration: BoxDecoration(
                          color : Theme.of(context).colorScheme.onSecondary),
                      ),
                      const CommentList(),
                    ],
                  )
                )
              ],
            ),
          ),
        );
      }
    );
  }
  Widget pageUserInfo(
    String userName , String createdAt , String updatedAt , List<String> group
  ){
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Profile(
          profile: "https://pbs.twimg.com/profile_images/1376539213215068162/EnA-bQS5_400x400.jpg",
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
              "소속 없음",
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
            Text(
              "${getDateFull(updatedAt)} 수정됨",
              style: TextStyle(
                height : 1.33,
                fontSize : 12,
                color : Theme.of(context).colorScheme.secondary,
              ),
            ),
          ]
        )
      ],
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