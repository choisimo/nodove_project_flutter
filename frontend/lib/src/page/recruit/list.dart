

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/tag/tagrow.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:shimmer/shimmer.dart';


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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Obx(()=>
        CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers : [
            SliverAppBar(
              title : const NavbarTitle("채용중",),
              actions : [
                NavbarCommonBtn(
                  "navbar/search.svg",
                  onClick : (){},
                ),
              ]
            ),
            SliverPersistentHeader(
              delegate: SliverCustomBarDelegate(
                widget: RecruitBottomSheet(
                  onClick:(index){},
                )
              ),
            ),
            RecruitListView(
              isLoading: con.isFetching.value,
              feed : con.recruitlist
            ),
          ]
        )
      )
    );
  }
}

class RecruitBottomSheet extends StatelessWidget {
  final Function(int index) onClick;
  const RecruitBottomSheet({super.key,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return MinimalVList(
      list: const ["채용중","완료"],
      onClick: (int index)=>onClick.call(index),
    );
  }
}

class RecruitListView extends StatelessWidget {
  final List<RecruitFeed> feed;
  final bool isLoading;
  const RecruitListView({
    super.key,
    required this.feed,
    this.isLoading = true
  });

   @override
  Widget build(BuildContext context) {
    if (isLoading){
      return const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      );
    } else if (feed.isEmpty){
      return const SliverToBoxAdapter(
        child: Center(
          child : Text("현재 진행중인 채용이 없어요")
        ),
      );
    } else {
      return SliverList.builder(
        itemBuilder: (context, index) => FeedRow(feed : feed[index]),
        itemCount: feed.length,
      );
    }
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
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color : Theme.of(context).colorScheme.onPrimary,
        border: Border.symmetric(horizontal: rowBorderLine())
      ),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                feed.title,
                style : RowTextStyle.title
              ),
              const SizedBox(width : 4),
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
              color: Theme.of(context).colorScheme.onSecondary
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

class RecruitVPage extends StatefulWidget {
  final String title;
  const RecruitVPage({super.key,this.title = ""});

  @override
  State<RecruitVPage> createState() => _RecruitVPageState();
}

class _RecruitVPageState extends State<RecruitVPage> {
  int maxContent = 7;
  RecruitListModel con = Get.put(RecruitListModel());

  void _initLoad() async{
    int pageKey = 0;
    con.getRecruitmentFirst(pageKey, maxContent);
  }

  @override
  void initState() {
    _initLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (widget.title != "")?Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style : TextStyle(
              fontSize : 16,
              color: Theme.of(context).colorScheme.onPrimaryFixed
            )
          )
        ):const SizedBox.shrink(),
        Obx((){
          if(con.isFetching.isTrue){
            return SizedBox(
              height : 240,
              child: ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context,index){
                  return Shimmer.fromColors(
                    baseColor: Theme.of(context).colorScheme.surface,
                    highlightColor: Theme.of(context).colorScheme.onPrimary,
                    child: Container(
                      width : 298,
                      height : 240,
                      decoration: const BoxDecoration(
                        color : CommonStyle.first
                      ),
                      child : const SizedBox.shrink(),
                      
                    )
                  );
                }
              ),
            );
          } else if(con.recruitlist.isEmpty){
            return const SizedBox(
              height : 240,
              child : Center(child: Text("피드가 없어요..."))
            );
          }
          else{
            return RecruitVList(feeds: con.recruitlist);
          }
        })
      ],
    );
  }
}

class RecruitVList extends StatelessWidget {
  final List<RecruitFeed> feeds;
  const RecruitVList({super.key , required this.feeds});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height : 180,
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: feeds.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context,index){
          return RecruitCollectedRow(feed: feeds[index]);
        }
      ),
    );
  }
}

class RecruitCollectedRow extends StatelessWidget {
  final RecruitFeed feed;
  final double size;
  const RecruitCollectedRow({
    super.key,required this.feed,
    this.size = 180
  });

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    String? profile = feed.user.profile;
    return GestureDetector(
      onTap:() => {},
      child: Container(
        width : size,
        height : size,
        margin : const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(8.0),
        child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
              aspectRatio: 16/9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: RowContainer.radius,
                  image: DecorationImage(
                    fit : BoxFit.cover,
                    image: 
                    customImgProvider(
                      (feed.images.isNotEmpty)?feed.images[0]:"",
                    )
                  )
                ),
              ),
            ),
          Text(
            feed.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "${feed.user.name} | @${feed.user.userId}",
            style: const TextStyle(
              fontSize : 12,
            ),
          ),
          TagRow(
            hashtags: feed.hashtags,
            fontSize: 12,
          ),
        ]),
      ),
    );
  }
}