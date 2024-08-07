import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/list/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:nodove_flutter/state/user.dart';

class UserPage extends StatelessWidget {
  final String id;
  const UserPage({super.key , required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body : UserInfo(id : id)
    );
  }
}

class UserInfo extends StatefulWidget {
  final String? id;
  const UserInfo({super.key,this.id});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> with SingleTickerProviderStateMixin {
  final UserInfoModel _con = Get.put(UserInfoModel());
  late Future<User> userInfo;
  late TabController tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 0,
  );

  @override
  void initState() {
    refreshState();
    super.initState();
  }

  void refreshState(){
    final userState = Get.put(UserState());
    String? widgetId = widget.id;
    String myid = userState.id.value;
    userInfo = _con.getUserInfo(widgetId??myid);
  }

  @override
  Widget build(BuildContext context) {
    int size = 15;
    return Container(
      margin : const EdgeInsets.symmetric(vertical: 8),
      padding : const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : FutureBuilder(
        future : userInfo,
        builder: (context , snapshot) {
          List<Widget> sliverList;
          if (snapshot.hasData){
            sliverList = [
              customSliverAppbar(context,snapshot),
              SliverToBoxAdapter(
                child : userInfoWithProfile(context,snapshot.data!)
              ),
              SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor: CommonStyle.first,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      controller: tabController,
                      labelColor: CommonStyle.first,
                      
                      unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                      tabs: const [
                        Tab(text: "홈"),
                        Tab(text: "피드"),
                        Tab(text: "활동"),
                        Tab(text: "정보"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
            ];
          } else {
            sliverList = [
              const SliverToBoxAdapter(
              child : CircularProgressIndicator(strokeWidth: 2,),
            )];
          }
          return NestedScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            headerSliverBuilder : (BuildContext context , bool isScrolled){
              return sliverList;
            },
            body : 
            (snapshot.hasData)?
            TabBarView(
              controller: tabController,
              children: [
                const Text("tab1"),
                FeedList(
                  collected: true,
                  url : "${Url.apiUrl}${Url.userPage}/${snapshot.data!.userId}",
                  opt : "pageSize=$size"
                ),
                const Text("tab3"),
                const Text("tab4"),
              ],
            ):const SizedBox.shrink()
          );
        }
      ),
    );
  }
}

Widget customSliverAppbar(BuildContext context ,snapshot){
  NavbarContent navbarOpt = NavbarContent(
    title : navbarTitle(context,"유저",20),
    actions : [
      PopupMenuButton(
      shape : TooltipShape(12,Theme.of(context).colorScheme.onSurface),
      offset : const Offset(0,46),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: Row(
              children : [
                SizedBox(
                  width : 24,
                  child: SvgPicture.asset(
                    "assets/icons/post/edit.svg",
                    width : 10 , height : 10,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  ),
                ),
                navbarTitle(context,"수정",20)
              ]
            ),
            onTap: () {
              print('수정 선택');
            },
          ),
        ];
      },
    ),
    ]
  );
  return SliverAppBar(
    floating: true,
    pinned: true,
    snap: true,
    flexibleSpace: FlexibleSpaceBar(
      background: Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
          ),
        ),
      ),
    ),
    centerTitle: false,
    automaticallyImplyLeading: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    leading: navbarOpt.leading??const SizedBox.shrink(),
    title : navbarOpt.title??const SizedBox.shrink(),
    actions : navbarOpt.actions??[const SizedBox.shrink()],
    shape : Border(
      bottom: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary)
    ),
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    _SliverAppBarDelegate(this._tabBar);

    final TabBar _tabBar;

    @override
    double get minExtent => _tabBar.preferredSize.height;
    @override
    double get maxExtent => _tabBar.preferredSize.height;

    @override
    Widget build(
        BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Container(
        color : Theme.of(context).colorScheme.onPrimary,
        child: _tabBar,
      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
      return false;
    }
  }

Widget userInfoWithProfile(BuildContext context, User info){
  return Column(
    children: [
      Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: RowContainer.radius
        ),
        child : Text(
          "나에 대한 한마디를 추가해보세요",
          style : TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          )
        ),
      ),
      Profile(profile: info.profile, width: 104, height: 104, borderRadius: 4.0,),
      Text(
        info.nickname,
        style: const TextStyle(
          height : 1.16,
          fontSize : 18,
          fontWeight: FontWeight.bold,
        )
      ),
      Text(
        ((info.groups.isNotEmpty)
        ?info.groups.toString()
        :"소속 없음"),
        style: TextStyle(
          height : 1.125,
          fontSize: 16,
          color : Theme.of(context).colorScheme.secondary,
        ),
      ),
      Text(
        "2024년 7월 21일 가입",
        style: TextStyle(
          height : 1.33,
          fontSize: 12,
          color : Theme.of(context).colorScheme.secondary,
        ),
      ),
    ],
  );
}