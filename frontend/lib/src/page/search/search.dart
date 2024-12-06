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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: const SearchView()
    );
  }
}

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TempFeed fcon = Get.find();

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed: ()=>Navigator.of(context).pop(),),
      actions: [

      ]
    );
    return CustomRefreshIndicator(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: navbarOpt.leading,
            actions : navbarOpt.actions
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: SliverCustomBarDelegate(
              widget: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 42,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: const BorderRadius.all(Radius.circular(100))),
                  child: Row(
                      children: [
                        Expanded(child: CommonTextInput(
                                fillColor: Colors.transparent,
                                placeholder: "검색어를 입력해주세요",
                                placeholderStyle: TextStyle(
                                    color: Theme.of(context).colorScheme.secondary))),
                        NavbarCommonBtn(
                          "navbar/search.svg",
                          onClick: () {},
                          iconColor: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                ),
              )
            )
          ),
          
          //FeedList(collected: true, feed: fcon.feedList)
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
                  iconColor: Theme.of(context).colorScheme.primary,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}