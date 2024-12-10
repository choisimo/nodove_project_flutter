import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedsetting.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/page/search/search.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/view/comment.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class CommuListPage extends StatefulWidget {
  final int? page;
  const CommuListPage({super.key, this.page});

  @override
  State<CommuListPage> createState() => _CommuListPageState();
}

final List<String> categories = ["공기업", "사기업", "대외활동"];

class _CommuListPageState extends State<CommuListPage> {
  final storage = const FlutterSecureStorage();
  PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
  late bool collected = false;
  int size = 10;
  bool search = false;
  FeedListModel con = Get.put(FeedListModel());
  CateListModel ccon = Get.put(CateListModel());
  final int cateid = 2;

  int pageKey = 0;

  @override
  void initState() {
    _checksettings();
    refresh();
    super.initState();
  }

  void refresh() {
    final int cateid = widget.page ?? int.parse(Get.parameters['page'] ?? '0');
    ccon.getCate(
      page: cateid,
      url: "/api/categories/getAllCategoriesByParentId/",
      opt: cateid.toString(),
    );
    ccon.getCateOne(
      url: "/api/categories/getAllCategoriesByParentId/",
      opt: cateid.toString(),
    );

    String url = "${Url.apiUrl}${Url.feedList}";
    String opt = "pageSize=$size&categoryId=$cateid";
    PageState.page.setView(url, opt);
    pageKey = 0;
    con.getFeedFirst(url, opt);
  }

  void _checksettings() async {
    String? c = await storage.read(key: 'collectedView');
    String? s = await storage.read(key: 'ContentSize');
    setState(() {
      collected = ((c == null) || (c == 'false')) ? false : true;
      size = (s != null) ? int.parse(s) : 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int cateid = widget.page ?? int.parse(Get.parameters['page'] ?? '0');
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt =
        NavbarContent(title: const NavbarTitle("블록"), actions: [
      NavbarCommonBtn(
        "post/edit.svg",
        onClick: () => Get.to(() => const WritePage(),
            fullscreenDialog: true,
            arguments: {'postCategory': cateid, 'community': true}),
      ),
      NavbarCommonBtn(
        "navbar/search.svg",
        onClick: ()=>Navigator.of(context).push(MaterialPageRoute(builder : (_)=>const SearchPage())),
      ),
      NavbarCommonBtn(
        "common/setting.svg",
        iconColor: Theme.of(context).colorScheme.onPrimaryFixed,
        onClick: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const FeedSettingPage())),
      ),
    ]);

    return PopScope(
      child: Scaffold(
        key: key,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: CustomRefreshIndicator(
          edgeOffset: 54,
          displacement: 54,
          onRefresh: () => refresh(),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: navbarOpt.leading,
                title: navbarOpt.title,
                actions: navbarOpt.actions,
                pinned: true,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                shadowColor: Colors.transparent,
                elevation: 0.0,
                scrolledUnderElevation: 0.0,
                flexibleSpace: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const FlexibleSpaceBar(
                      centerTitle: true,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverCustomBarDelegate(
                    widget: MinimalVList(
                        list: categories,
                        onClick: (index) {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOutCubic);
                        })),
              ),
              SliverFillRemaining(
                child: PageView(controller: pageController, children: [
                  CustomScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    slivers: [
                      FeedList(
                        collected: collected,
                        feed: con.feedList,
                        shortContent: false,
                        onFeedClick: (id) => showCustomModal(
                            context,
                            CommentListModal(
                                page: id,
                                feed: con.feedList.singleWhere(
                                    (el) => el.id == id,
                                    orElse: () => Feed.defaultState()))),
                      ),
                      const SliverPadding(
                          padding: EdgeInsets.all(RowContainer.paddingSize))
                    ],
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
