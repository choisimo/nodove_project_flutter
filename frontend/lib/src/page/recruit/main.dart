import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/media/carousel.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/other/mainlist.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
import 'package:nodove_flutter/src/page/recruit/list.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
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
  RecruitListModel con = Get.put(RecruitListModel());
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
    return CustomScrollView(
      slivers : [
        SliverAppBar(
          centerTitle: false,
          title : const NavbarTitle("채용",),
          actions : [
            NavbarCommonBtn(
              "navbar/search.svg",
              onClick : (){},
            ),
          ],
          expandedHeight: 56
        ),
        const SliverToBoxAdapter(
        child: SizedBox(
          height : 240,
          child: BannerCarousel(
              imageLinks: [
                "assets/images/background.jpg",
                "assets/images/background2.jpg"
              ],
            ),
        )
        ),
        const SliverPadding(
          padding: EdgeInsets.all(4),
            sliver: SliverToBoxAdapter(
            child : RecruitShortcutMenu()
          ),
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
          child : 
          PartContainer(
            children: [
              TitleRow(
                title : "내 위치",
                onTap : ()=>Get.to(()=>const MapPage()),
              ),
              mapPreview(context)
            ],
          )
        ),
        SliverToBoxAdapter(
          child : Column(
            children: [
              TitleRow(
                title : "채용 진행중",
                onTap : ()=>Get.to(()=>const RecruitListPage()),
              ),
              SizedBox(
                height : 360,
                child: Obx((){
                  if (con.isFetching.isTrue){
                    return const CircularProgressIndicator(
                      strokeWidth: 2.0,

                    );
                  } else if (con.recruitlist.isEmpty){
                    return const Center(
                      child : Text("현재 진행중인 채용이 없어요")
                    );
                  } else {
                    return CustomRefreshIndicator(
                      onRefresh: ()=>con.getRecruitmentFirst(0, size),
                      child: RecruitListView(
                        feed : con.recruitlist
                      ),
                    );
                  }
                }),
              )
            ]
          )
        ),
      ]
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
          onClick: ()=>Get.to(()=>const RecruitListPage()),
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
        buttons(
          context,
          iconSrc: "/common/setting.svg",
          title : "설정" , iconWidth: 16 , iconHeight: 16
        )
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