import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/graphic/painter.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/user/member/editpage.dart';
import 'package:nodove_flutter/src/page/user/new/login.dart';
import 'package:nodove_flutter/func/share.dart';
import 'package:nodove_flutter/src/page/user/new/main.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:shimmer/shimmer.dart';

class UserPage extends StatelessWidget {
  final String? id;
  const UserPage({super.key , this.id});

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
  ScrollController scrollController = ScrollController();
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

  Future<void> refreshState() async{
    final userState = Get.put(UserState());
    String? widgetId = widget.id;
    String myid = userState.id.value;
    _con.getUserInfo(widgetId??myid);
  }

  @override
  Widget build(BuildContext context) {
    int size = 15;
    List<Widget> tabList = const [
      Tab(text: "홈"),
      Tab(text: "피드"),
      Tab(text: "구독"),
      Tab(text: "활동"),
    ];
    return Container(
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : Obx((){
          final user = _con.userInfo.value;
          List<Widget> sliverList;
          print("${_con.isFetching}${user.userId.isNotEmpty}");
          if (_con.isFetching.isFalse&&user.userId.isNotEmpty){
            sliverList = [
              customSliverAppbar(context,user.userId,widget.id),
              SliverToBoxAdapter(
                child : userInfoWithProfile(context,user)
              ),
              SliverToBoxAdapter(
                child : userButtons(context,user)
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  TabBar(
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    labelColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    indicatorWeight: 0.5,
                    unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                    tabs: tabList,
                  ),
                ),
                pinned: true,
              ),
            ];
          } else {
            sliverList = [
              customSliverAppbar(context,"",null),
              SliverToBoxAdapter(
                child : userInfoWithProfileSkel(context),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  TabBar(
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    indicatorColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    controller: tabController,
                    labelColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    indicatorWeight: 0.5,
                    unselectedLabelColor: Theme.of(context).colorScheme.onSurface,
                    tabs: tabList,
                  ),
                ),
                pinned: true,
              ),
              SliverFillRemaining(
                child : (user.userId.isNotEmpty)?
                TabBarView(
                  controller: tabController,
                  children: [
                    const Text("tab1"),
                    FeedList(
                      collected: true,
                      url : "${Url.apiUrl}${Url.userFeed}/${user.userId}",
                      opt : "pageSize=$size",
                      scrollEnabled: false,
                    ),
                    const Text("tab3"),
                    const Text("tab4"),
                  ],
                ):const SizedBox.shrink()
              )
            ];
          }
          return CustomRefreshIndicator(
            onRefresh: (){},
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers : sliverList,
            ),
          );
        }
      ),
    );
  }
}

Widget customSliverAppbar(BuildContext context ,String userId,String? id){
  NavbarContent navbarOpt = NavbarContent(
    leading: (id!= null)?BackButton(onPressed: ()=>Get.back()):const SizedBox.shrink(),
    title : NavbarTitle("@$userId"),
    actions : [
      PopupMenuButton(
      color : Theme.of(context).colorScheme.onPrimary,
      shadowColor: Colors.transparent,
      shape : TooltipShape(
        vertical : 12,
        borderColor : Theme.of(context).colorScheme.shadow
      ),
      offset : const Offset(0,46),
      itemBuilder: (BuildContext context) {
        return [
          popupMenu(
            context,
            title: const NavbarTitle("복사", fontSize : 16),
            onClick : () => copyLink(
              "${Url.serverUrl}${Url.clientUser}?user=$userId",
            )
          ), 
          popupMenu(
            context,
            title: const NavbarTitle("로그아웃", fontSize : 16),
            onClick : ()=> showUserDialog(context)
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
      background: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    leading: navbarOpt.leading??const SizedBox.shrink(),
    title : navbarOpt.title??const SizedBox.shrink(),
    actions : navbarOpt.actions??[const SizedBox.shrink()],
  );
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    SliverAppBarDelegate(this._tabBar);

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
    bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
      return false;
    }
  }

Widget userInfoWithProfile(BuildContext context, User info){
  return Column(
    children: [
      ClipPath(
        clipper: const CustomClip(
          vertical: 72
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimaryFixed
          ),
          child : Text(
            "나에 대한 한마디를 추가해보세요",
            style : TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            )
          ),
        ),
      ),
      const SizedBox(height : 4),
      Profile(
        profile: info.profile,
        width: 104, height: 104,
        borderRadius: 2.0,
      ),
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

Widget userButtons(BuildContext context,User info){
  final myid = UserState.page.id;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Obx((){
        return (info.userId.obs == myid)?
        OutlinedButton(
          onPressed: ()=>Get.to(
            ()=>const EditUserPage(),
            fullscreenDialog: true
          ),
          child: Text(
            "정보 수정",
            style : TextStyle(
              color : Theme.of(context).colorScheme.onSurface
            )
          )
        ):const SizedBox.shrink();
      }),
      const SizedBox(
        width : 8
      ),
      OutlinedButton(
        onPressed: (){},
        child: Text(
          "#해쉬태그",
          style : TextStyle(
            color : Theme.of(context).colorScheme.onSurface
          )
        )
      ),
    ],
  );
}

void showUserDialog (BuildContext context){
  showDialog(
    context: context, 
    builder:(context){
      return customDialog(
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
            DialogStrTitle("로그아웃할까요?"),
            DialogStrContent("다시 로그인 전까지 자동 로그인을 사용 할 수 없어요"),
          ],
        ),
        bottomBtns: [
          dialogBottomBtn(
            context,
            onPressed: () async{
              const storage = FlutterSecureStorage();
              await storage.delete(key: 'userToken');
              await storage.delete(key: 'cookie');
              showToast("로그아웃 되었어요");
              await Get.off(()=>const LoginMainPage());
            },
            child : const Text(
              "로그아웃",
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

Widget customSliverAppbarSkel(BuildContext context,String? id){
  return SliverAppBar(
    leading: (id!= null)?BackButton(onPressed: ()=>Get.back()):const SizedBox.shrink(),
    floating: true,
    pinned: true,
    snap: true,
    centerTitle: true,
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
  );
}

Widget userInfoWithProfileSkel(BuildContext context){
  return LayoutBuilder(
    builder: (context,constraints) {
      return Column(
        children: [
          const SizedBox(height : 4),
          ClipPath(
            clipper: const CustomClip(
              vertical: 72
            ),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height : 42,
                width : constraints.maxWidth * 0.8,
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 4),
                decoration: BoxDecoration(
                  borderRadius: RowContainer.radius,
                  color: Theme.of(context).colorScheme.onPrimaryFixed
                ),
              ),
            ),
          ),
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: const ProfileSkel(
                width: 104, height: 104,
              ),
          ),
          const SizedBox(height : 4),
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height : 16,
                width : constraints.maxWidth * 0.3,
                decoration: BoxDecoration(
                  borderRadius: RowContainer.radius,
                  color: Theme.of(context).colorScheme.onPrimaryFixed
                ),
              )
          ),
          const SizedBox(height : 4),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onPrimary,
            child: Container(
              height : 16,
              width : constraints.maxWidth * 0.5,
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                color: Theme.of(context).colorScheme.onPrimaryFixed
              ),
            )
          ),
          const SizedBox(height : 4),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onPrimary,
            child: Container(
              height : 16,
              width : constraints.maxWidth * 0.3,
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                color: Theme.of(context).colorScheme.onPrimaryFixed
              ),
            )
          )
        ],
      );
    }
  );
}