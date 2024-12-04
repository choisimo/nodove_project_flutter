import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/src/component/media/carousel.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/vmodel/vrecruit.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class RecruitViewPage extends StatefulWidget{
  final String? page;
  final String url;
  const RecruitViewPage({
    super.key,
    this.page,
    this.url = "${Url.recruitServerUrl}/user",
  });

  @override
  State<RecruitViewPage> createState() => _RecruitViewPageState();
}

class _RecruitViewPageState extends State<RecruitViewPage>{
  final FeedListModel vpage = Get.put(FeedListModel());
  final RecruitModel con = Get.find();

  Future<void> refresh() async{
    //PageUrl url = ViewPageState.page.comment.value;
  }

  @override
  void initState() {
    PageState.page.setView(widget.url,"/${widget.page}");
    con.getRecruitmentPage(widget.page);
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    String page = widget.page.toString();
    double maxHeight = MediaQuery.of(context).size.height;
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Navigator.of(context).pop()),
      actions : <Widget>[
        etcBtn(
          cb : (id){
          
          },id : page
        ),
      ],
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body : CustomRefreshIndicator(
        onRefresh: ()=>refresh(),
        strokeColor : Theme.of(context).colorScheme.onSurface,
        backgroundColor : Theme.of(context).colorScheme.onPrimary,
        child: Obx((){
          final feed = con.content.value;
          if (con.isFetching.isTrue){
            return const Center(child: CircularProgressIndicator(strokeWidth: 2.0,));
          } else{
            return CustomScrollView(
              slivers: [
                (feed.imageLinks.isNotEmpty)?
                SliverAppBar(
                  leading: navbarOpt.leading,
                  title : navbarOpt.title,
                  actions : navbarOpt.actions,
                  expandedHeight: maxHeight * 0.5,
                  flexibleSpace : ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: BannerCarousel(
                        imageLinks: feed.imageLinks,
                      ),
                    )
                  )
                ):SliverAppBar(
                  leading: navbarOpt.leading,
                  title : navbarOpt.title,
                  actions : navbarOpt.actions,
                ),
                SliverToBoxAdapter(
                  child: Text(
                    con.content.value.title,
                    style : const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
                SliverToBoxAdapter(
                  child: Html(data: feed.content??""),
                ),
                SliverToBoxAdapter(
                  child: pageUserInfo(context, feed),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    width : double.infinity,
                    child: AspectRatio(
                      aspectRatio: 32/9,
                      child : MapPreview(
                        position: feed.user.pos,
                        onClick: (_,__)=>Navigator.of(context).push(
                          MaterialPageRoute(builder: (_)=>const MapPage())
                        ),
                      )
                    ),
                  )
                )
              ]
            );
          } 
        }
      )
    )
    );
  }

  Widget pageUserInfo(BuildContext context,RecruitFeed feed){
    return GestureDetector(
      onTap: ()=>Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_)=>UserPage(id : feed.user.id)
        )
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children : [
          Profile(
            profile : feed.user.profile??"",
            width : 64, height : 64
          ),
          Text(
            feed.user.name,
            style: const TextStyle(
              fontSize : 14,
              fontWeight: FontWeight.bold,
            )
          ),
          Text(
            "설립 : ${getYearOnly(feed.user.founded)}",
            style: TextStyle(
              fontSize: 12,
              color : Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            "소개 : ${feed.user.description}",
            style: TextStyle(
              fontSize: 12,
              color : Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            feed.user.pos.name,
            style: TextStyle(
              fontSize: 12,
              color : Theme.of(context).colorScheme.secondary,
            ),
          )
        ]
      ),
    );
  }
  Widget pageFeedInfo(BuildContext context,RecruitFeed feed){
    return const Column(
      children: [
        
      ],
    );
  }
}