import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/other/mainlist.dart';
import 'package:nodove_flutter/src/page/recruit/list.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';

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
              "assets/icons/navbar/search.svg",
              onClick : (){},
            ),
          ],
          expandedHeight: MediaQuery.of(context).size.height * 0.3,
          flexibleSpace: const SizedBox(
            child : customImage(
              "assets/images/background2.jpg",
              width : double.infinity,
              height : double.infinity,
              fit : BoxFit.cover
            )
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              TitleRow(
                title : "추천 채용",
                iconSrc: "assets/icons/navbar/menu.svg",
                iconWidth: 14,
                iconHeight: 14,
              ),
              RecruitVPage()
            ]
          )
        ),
        SliverToBoxAdapter(
          child : Column(
            children: [
              TitleRow(
                title : "채용 진행중",
                iconSrc: "assets/icons/navbar/menu.svg",
                onTap : ()=>Get.to(()=>const RecruitListPage()),
                iconWidth: 14,
                iconHeight: 14,
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