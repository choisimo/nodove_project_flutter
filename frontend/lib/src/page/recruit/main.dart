import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/media/carousel.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/other/mainlist.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
import 'package:nodove_flutter/src/page/recruit/list.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vrecruit.dart';
import 'package:nodove_flutter/state/color.dart';

class RecruitMainPage extends StatelessWidget {
  const RecruitMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body : const RecruitMainView()
    );
  }
}

class RecruitMainView extends StatefulWidget {
  const RecruitMainView({super.key});

  @override
  State<RecruitMainView> createState() => _RecruitMainViewState();
}

class _RecruitMainViewState extends State<RecruitMainView>{
  RecruitModel con = Get.find();
  int pageKey = 0;
  int size = 5;

  void _initLoad() async{
    pageKey = 0;
    con.getRecruitmentFirst(pageKey, size);
  }

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: ()=>_initLoad(),
      child: Obx(()=>
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers : [
            const SliverAppBar(
              centerTitle: false,
              title : NavbarTitle(
                "채용",
              ),
              shadowColor: Colors.transparent,
              elevation: 0.0,
              scrolledUnderElevation: 0.0,
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child : AspectRatio(
                aspectRatio: 32/9,
                child: BannerCarousel(
                  imageLinks: [
                    "assets/images/background.jpg",
                    "assets/images/background2.jpg"
                  ],
                ),
              )
            ),
            const SliverToBoxAdapter(
              child: Column(
                children: [
                  TitleRow(
                    title : "추천 채용",
                  ),
                  RecruitVPage()
                ]
              )
            ),
            SliverToBoxAdapter(
              child : Column(
                children: [
                  TitleRow(
                    title : "내 위치",
                    onTap : ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const MapPage()))
                  ),
                  const MapPreview()
                ],
              )
            ),
            SliverToBoxAdapter(
              child : Column(
                children: [
                  TitleRow(
                    title : "채용 진행중",
                    onTap : ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const RecruitListPage()))
                  ),
                ]
              )
            ),
            RecruitListView(
              feed : con.recruitlist,
              isLoading: con.isFetching.value,
              minimalView: true,
            ),
            const SliverPadding(padding: EdgeInsets.all(RowContainer.paddingSize))
          ]
        ),
      )
    );
  }
}

class RecruitShortcutMenu extends StatelessWidget {
  const RecruitShortcutMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buttons(
          context,
          onClick: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const RecruitListPage())),
          iconSrc: "/navbar/summarize.svg",
          title : "채용" , iconWidth: 16 , iconHeight: 16
        ),
        buttons(
          context,
          iconSrc: "/user/company.svg",
          title : "기업" , iconWidth: 16 , iconHeight: 16
        ),
        buttons(
          context,
          iconSrc: "/navbar/navi.svg",
          title : "지도" , iconWidth: 16 , iconHeight: 16
        ),
      ],
    );
  }

  Widget buttons(BuildContext context,{
    Widget? child, Function()? onClick,
    double? width = 72,double? height = 64,
    String? title,String? iconSrc,double iconWidth = 16,double iconHeight = 16,
  }){
    return SizedBox(
      width : width,
      height : height,
      child: OutlinedButton(
        onPressed: ()=>onClick?.call(),
        style : OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side : rowBorderLine(),
          shape : const RoundedRectangleBorder(
            borderRadius: RowContainer.radius,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomSvg(
              iconSrc.toString(),
              width : iconWidth , height : iconHeight
            ),
            Text(title.toString())
          ],
        )
      )
    );
  }
}