import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/state/color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: const SearchView()
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with SingleTickerProviderStateMixin {
  TempFeed fcon = Get.find();
  List<Widget> tabList = const [
    Tab(text : "피드"),
    Tab(text : "블록")
  ];
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 56,
            flexibleSpace: SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 42,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: const BorderRadius.all(Radius.circular(100))),
                  child: Row(
                      children: [
                        SizedBox(width : 56,child: BackBtn(onPressed: ()=>Navigator.of(context).pop(),)),
                        Expanded(child: CommonTextInput(
                                fillColor: Colors.transparent,
                                placeholder: "검색어를 입력해주세요",
                                placeholderStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary))),
                        NavbarCommonBtn(
                          "navbar/search.svg",
                          onClick: () {},
                        ),
                      ],
                    ),
                ),
              ),
            ),
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
          FeedList(collected: true, feed: fcon.feedList)
        ],
      ),
    );
  }
}

class SearchPreview extends StatelessWidget {
  final Function()? onPressed;
  const SearchPreview({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 42,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: const BorderRadius.all(Radius.circular(100))),
          child: LayoutBuilder(builder: (context, layout) {
            return Row(
              children: [
                SizedBox(
                    width: layout.maxWidth - 54,
                    child: CommonTextInput(
                        enabled: false,
                        fillColor: Colors.transparent,
                        placeholder: "검색어를 입력해주세요",
                        placeholderStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary))),
                NavbarCommonBtn(
                  "navbar/search.svg",
                  onClick: () {},
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}