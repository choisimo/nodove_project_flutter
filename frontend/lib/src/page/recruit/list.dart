

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/tag/tagrow.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';


class RecruitListPage extends StatefulWidget {
  const RecruitListPage({super.key});

  @override
  State<RecruitListPage> createState() => _RecruitListPageState();
}

class _RecruitListPageState extends State<RecruitListPage> {
  RecruitListModel con = Get.put(RecruitListModel());
  final ScrollController _scrollController = ScrollController();
  int pageKey = 0;
  int size = 15;

  void fetchPage() async {
    if (!con.isFetching.value && 
    !con.isFragFetching.value &&
    con.isLastAppend.isFalse&&
    _scrollController.position.extentAfter < 100){
      try {
        pageKey += 1;
        final newData = await con.getRecruitmentList(pageKey,size);
        final isLastPage = newData.isEmpty;
        if (!mounted) return;
        if (isLastPage) {
          con.appendLastPage(newData);
        } else {
          con.appendPage(newData);
        }
      } catch (error) {
        print(error);
      }
    }
  }

  void _initLoad() async{
    pageKey = 0;
    con.getRecruitmentFirst(pageKey, size);
    print(con.recruitlist);
  }

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(
        context,"채용",20,
      ),
      actions : [
        navbarCommonBtn(
          context,
          "assets/icons/navbar/search.svg",
          cb : (){},
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false),
      body: Obx((){
        if (con.isFetching.isTrue){
          return const CircularProgressIndicator(
            strokeWidth: 2.0,

          );
        } else if (con.recruitlist.isEmpty){
          return const Center(
            child : Text("현재 진행중인 채용이 없어요")
          );
        } else {
          return customRefreshIndicator(context,
            onRefresh: ()=>con.getRecruitmentFirst(0, size),
            child: RecruitListView(
              feed : con.recruitlist
            ),
          );
        }
      })
      
    );
  }
}

class RecruitBottomSheet extends StatefulWidget {
  const RecruitBottomSheet({super.key});

  @override
  State<RecruitBottomSheet> createState() => _RecruitBottomSheetState();
}

class _RecruitBottomSheetState extends State<RecruitBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width : double.infinity,
      constraints: const BoxConstraints(minHeight: 42),
      child : Row(
        children: [
          TextButton(
            style : TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              padding: EdgeInsets.all(0)
            ),
            onPressed: (){},
            child: Text("야발"),
          )
        ],
      )
    );
  }
}

class RecruitListView extends StatefulWidget {
  final List<RecruitFeed> feed;
  const RecruitListView({
    super.key,
    required this.feed,
  });

  @override
  State<RecruitListView> createState() => _RecruitListViewState();
}

class _RecruitListViewState extends State<RecruitListView> {
  @override
  Widget build(BuildContext context) {
    final List<RecruitFeed> feed = widget.feed;
    return CustomScrollView(
      primary: false,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers : [
        const SliverToBoxAdapter(
          child : RecruitBottomSheet()
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => FeedRow(feed : feed[index]),
            childCount: feed.length
          )
        ),
      ]
    );
  }
}

class FeedRow extends StatelessWidget {
  final RecruitFeed feed;
  const FeedRow({
    super.key,
    required this.feed
  });

  @override
  Widget build(BuildContext context) {
    TextStyle idStyle = TextStyle(
      fontSize: 14,
      color: Theme.of(context).colorScheme.secondary
    );
    return Container(
      width : double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color : Theme.of(context).colorScheme.shadow,
            offset: RowContainer.offset,
            blurRadius: RowContainer.blurRadius
          )
        ],
      ),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
             Text(
                feed.title,
                style : RowTextStyle.title
              ),
              Text(
                "${feed.region.first.split(" ")[0]}${(feed.region.length>1)?
                " 외 ${feed.region.length - 1}곳"
                :""}",
                style : idStyle
              ),
            ],
          ),
          TagRow(
            hashtags: feed.hashtags,
          ),
          SizedBox(
            child :Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      feed.user.name,
                      style : RowTextStyle.userId
                    ),
                    const SizedBox(width : 4),
                    Text(
                      "@${feed.user.userId}",
                      style : idStyle
                    ),
                  ],
                ),
              ],
            )
          ),
          Container(
            height : 32,
            decoration: BoxDecoration(
              borderRadius: RowContainer.radius,
              border: Border.all(width: 1,color : Theme.of(context).colorScheme.onPrimaryFixed)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${getFutureDiff(feed.to)} 까지",
                  style : RowTextStyle.subContent
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}