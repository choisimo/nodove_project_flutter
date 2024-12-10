import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/painter.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/page/post/share.dart';
import 'package:nodove_flutter/src/page/setting/setting.dart';
import 'package:nodove_flutter/src/page/user/member/activity.dart';
import 'package:nodove_flutter/src/page/user/new/main.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:nodove_flutter/state/user.dart';
import 'package:shimmer/shimmer.dart';

class UserPage extends StatelessWidget {
  final String? id;
  const UserPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: UserInfo(id: id));
  }
}

class UserInfo extends StatefulWidget {
  final String? id;
  const UserInfo({super.key, this.id});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo>
    with SingleTickerProviderStateMixin {
  final FeedListModel con = Get.put(FeedListModel());
  final UserInfoModel _con = Get.put(UserInfoModel());
  late Future<User> userInfo;
  final UserState userState = Get.find();
  ScrollController scrollController = ScrollController();
  late TabController tabController = TabController(
    length: 4,
    vsync: this,
    initialIndex: 0,
  );
  int size = 15;
  int pageKey = 0;
  List<Widget> tabList = const [
    Tab(text: "홈"),
    Tab(text: "피드"),
    Tab(text: "구독"),
    Tab(text: "활동"),
  ];

  @override
  void initState() {
    refreshState();
    super.initState();
  }

  Future<void> refreshState() async {
    String? widgetId = widget.id;
    String myid = userState.id.value;
    _con.getUserInfo(widgetId ?? myid);
    initLoad();
  }

  void initLoad() async {
    String url = "${Url.apiUrl}${Url.userFeed}/${_con.userInfo.value.userId}";
    String opt = "pageSize=$size";
    pageKey = 0;
    con.getFeedFirst(url, opt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Obx(() {
        final user = _con.userInfo.value;
        List<Widget> sliverList;
        print("${_con.isFetching}${user.userId.isNotEmpty}");
        if (_con.isFetching.isFalse && user.userId.isNotEmpty) {
          sliverList = [
            CustomUserSliverAppbar(userId : user.userId, id : widget.id),
            SliverToBoxAdapter(child: UserInfoWithProfile(info : user)),
            SliverToBoxAdapter(child: UserButtons(info : user)),
            SliverPersistentHeader(
              delegate: SliverTabBarDelegate(
                TabBar(
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Theme.of(context).colorScheme.onPrimaryFixed,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  dividerColor: Theme.of(context).colorScheme.onSecondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tabController,
                  labelColor: Theme.of(context).colorScheme.onPrimaryFixed,
                  indicatorWeight: 0.5,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onSecondary,
                  tabs: tabList,
                ),
              ),
              pinned: true,
            ),
          ];
        } else {
          sliverList = [
            const CustomUserSliverAppbar(userId : "", id : null),
            const SliverToBoxAdapter(
              child: UserInfoWithProfileSkel(),
            ),
            SliverPersistentHeader(
              delegate: SliverTabBarDelegate(
                TabBar(
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  indicatorColor: Theme.of(context).colorScheme.onPrimaryFixed,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  dividerColor: Theme.of(context).colorScheme.onSecondary,
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tabController,
                  labelColor: Theme.of(context).colorScheme.onPrimaryFixed,
                  indicatorWeight: 0.5,
                  unselectedLabelColor:
                      Theme.of(context).colorScheme.onSecondary,
                  tabs: tabList,
                ),
              ),
              pinned: true,
            ),
          ];
        }
        return CustomRefreshIndicator(
          edgeOffset: 54,
          displacement: 40,
          onRefresh: () {},
          child: NestedScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              headerSliverBuilder: (context, innerBoxIsScrolled) => sliverList,
              body: (user.userId.isNotEmpty)
                  ? TabBarView(
                      controller: tabController,
                      children: [
                        UserInfoColumn(
                          children: [
                            const UserInfoTitle("채용"),
                            CollectedVList(
                                  feed: con.feedList),
                            const UserInfoTitle("내가 쓴 글"),
                            CollectedVList(
                                  feed: con.feedList),
                            const UserInfoTitle("구독"),
                            CollectedVList(
                                  feed: con.feedList),
                          ]
                        ),
                        CustomScrollView(slivers: [
                          FeedList(collected: true, feed: con.feedList),
                          const SliverPadding(
                              padding: EdgeInsets.all(RowContainer.paddingSize))
                        ]),
                        const Text("tab3"),
                        const UserActivityView(),
                      ],
                    )
                  : const SizedBox.shrink()),
        );
      }),
    );
  }
}

class CustomUserSliverAppbar extends StatelessWidget {
  final String userId;
  final String? id;
  const CustomUserSliverAppbar({super.key,required this.userId,this.id});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt =
      NavbarContent(title: NavbarTitle("@$userId"), actions: [
    (id == null)
        ? NavbarCommonBtn(
            "common/setting.svg",
            iconColor: Theme.of(context).colorScheme.onPrimaryFixed,
            onClick: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_)=>const SettingPage())
            ),
          )
        : const SizedBox.shrink(),
    NavbarCommonBtn(
      "post/share.svg",
      onClick: () => showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          builder: (BuildContext context) {
            return ShareModal(url: "${Url.clientUser}?user=$userId");
          }),
    )
  ]);
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
    centerTitle: false,
    automaticallyImplyLeading: true,
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    title: navbarOpt.title ?? const SizedBox.shrink(),
    actions: navbarOpt.actions ?? [const SizedBox.shrink()],
  );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).colorScheme.onPrimary,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }
}

class SliverCustomBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double maxHeight;
  final double minHeight;

  SliverCustomBarDelegate(
      {required this.widget, this.maxHeight = 54, this.minHeight = 54});

  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverCustomBarDelegate oldDelegate) {
    return false;
  }
}

class UserInfoWithProfile extends StatelessWidget {
  final User info;
  const UserInfoWithProfile({super.key,required this.info});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Profile(
            profile: info.profile,
            width: 84,
            height: 84,
            borderRadius: 1.0,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(info.nickname,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            Text(
              ((info.groups.isNotEmpty) ? info.groups.toString() : "소속 없음"),
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "2024년 7월 가입",
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserButtons extends StatelessWidget {
  final User info;
  const UserButtons({super.key,required this.info});

  @override
  Widget build(BuildContext context) {
    final myid = UserState.page.id;
    return Obx(() {
      if (info.userId.obs == myid) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    shape: const RoundedRectangleBorder(
                        borderRadius: RowContainer.radius),
                  ),
                  onPressed: () {},
                  child: Text("활동 관리",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimaryFixed))),
            ),
            const SizedBox(width: 16),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: TextButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    shape: const RoundedRectangleBorder(
                        borderRadius: RowContainer.radius),
                  ),
                  onPressed: () {},
                  child: Text("팔로우",
                      style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary))),
            ),
            const SizedBox(width: 16),
          ],
        );
      }
    });
  }
}

void showUserDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: const DialogStrTitle("로그아웃할까요?"),
          content: const DialogStrContent("다시 로그인 전까지 자동 로그인을 사용 할 수 없어요"),
          bottomBtns: [
            DialogBottomBtn(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                onPressed: () async {
                  const storage = FlutterSecureStorage();
                  await storage.delete(key: 'userToken');
                  await storage.delete(key: 'cookie');
                  showToast("로그아웃 되었어요");
                  await Get.offAll(() => const LoginMainPage());
                },
                title: "로그아웃"),
          ],
        );
      });
}

class CustomUserSliverAppbarSkel extends StatelessWidget {
  final String? id;
  const CustomUserSliverAppbarSkel({super.key,this.id});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: (id != null)
          ? BackButton(onPressed: () => Get.back())
          : const SizedBox.shrink(),
      floating: true,
      pinned: true,
      snap: true,
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );
  }
}

class UserInfoWithProfileSkel extends StatelessWidget {
  const UserInfoWithProfileSkel({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) => Column(
        children: [
          const SizedBox(height: 4),
          ClipPath(
            clipper: const CustomClip(vertical: 72),
            child: Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height: 42,
                width: constraints.maxWidth * 0.8,
                padding:
                    const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 4),
                decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    color: Theme.of(context).colorScheme.onPrimaryFixed),
              ),
            ),
          ),
          Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.surface,
            highlightColor: Theme.of(context).colorScheme.onPrimary,
            child: const ProfileSkel(
              width: 104,
              height: 104,
            ),
          ),
          const SizedBox(height: 4),
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height: 16,
                width: constraints.maxWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    color: Theme.of(context).colorScheme.onPrimaryFixed),
              )),
          const SizedBox(height: 4),
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height: 16,
                width: constraints.maxWidth * 0.5,
                decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    color: Theme.of(context).colorScheme.onPrimaryFixed),
              )),
          const SizedBox(height: 4),
          Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.surface,
              highlightColor: Theme.of(context).colorScheme.onPrimary,
              child: Container(
                height: 16,
                width: constraints.maxWidth * 0.3,
                decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    color: Theme.of(context).colorScheme.onPrimaryFixed),
              ))
        ],
      )
    );
  }
}

class UserInfoTitle extends StatelessWidget {
  final String? title;
  const UserInfoTitle(this.title,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
      title ?? "",
      style: const TextStyle(
          fontSize: 16
      )),
    );
  }
}

class UserInfoColumn extends StatelessWidget {
  final List<Widget> children;
  const UserInfoColumn({super.key,required this.children});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: children.map((el)=>
        SliverToBoxAdapter(
          child : el
        )
      ).toList(),
    );
  }
}