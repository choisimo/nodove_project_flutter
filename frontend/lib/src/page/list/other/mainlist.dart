import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/community/commulist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/page/notification/noti.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/state/color.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: const FeedMainList(),
    );
  }
}

class FeedMainList extends StatefulWidget {
  const FeedMainList({super.key});

  @override
  State<FeedMainList> createState() => _FeedMainListState();
}

class _FeedMainListState extends State<FeedMainList> {
  List<String> tagList = [
    '토목공학',
    '건설사',
  ];
  int pageSize = 3;
  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("홈"),
      actions : [
        NavbarCommonBtn(
          "navbar/alert-empty.svg",
          onClick: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const NotiPage())),
        )
      ]
    );
        
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverNavbarTop(
          navbarOpt,
        ),
        const SliverToBoxAdapter(
          child: SearchPart(),
        ),
        const SliverToBoxAdapter(
          child: MainCommList(),
        ),
        SliverToBoxAdapter(
          child : PartContainer(
            children: [
              TitleRow(
                title : "카테고리",
                onTap : ()=>Get.to(()=>const CatePage(page: 0)),
              ),
              CateList(
                page : 0,
                selection : pageSize,
              )
            ]
          )
        ),
        SliverToBoxAdapter(
          child : MainTagList(tagList: tagList)
        ),
        const SliverPadding(padding: EdgeInsets.all(RowContainer.paddingSize))
      ]
    );
  }
}

class MainCommList extends StatefulWidget {
  const MainCommList({super.key});

  @override
  State<MainCommList> createState() => _MainCommListState();
}

class _MainCommListState extends State<MainCommList> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0
  );
  TempFeed con = Get.find();

  @override
  Widget build(BuildContext context) {
    return  PartContainer(
      children: [
        TitleRow(
          title : "커리어블록 커뮤니티",
          onTap : ()=>Get.to(()=>const CatePage(page: 0))
        ),
        SizedBox(
          height : 52,
          child:  MinimalVList(
            list : categories,
            onClick: (index)=>pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOutCubic)
          ),
        ),
        Container(
          height : 200,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border: Border(
              bottom: rowBorderLine()
            ),
          ),
          child: PageView(
            controller: pageController,
            children: con.comm.map((e) => 
              FeedContent(feed: e[0])).toList(),
            )
        )
      ]
    );
  }
}

class MainTagList extends StatefulWidget {
  final List<String> tagList;
  const MainTagList({super.key,required this.tagList});

  @override
  State<MainTagList> createState() => _MainTagListState();
}

class _MainTagListState extends State<MainTagList> {
  TempFeed con = Get.find();
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
    viewportFraction: 1.0
  );

  void _initLoad() async{
    /*String url = "${Url.apiUrl}/getPostListByTag/${Uri.encodeComponent(widget.tagList[index])}";
    String opt = "pageSize=3";
    con.getFeedFirst(url,opt);*/
  }
  
  @override
  void initState(){
    _initLoad();
    super.initState();
  }
  
  int pageSize = 3;
  @override
  Widget build(BuildContext context) {
    return  PartContainer(
      children: [
        TitleRow(
          title : "추천하는 #해시태그에요",
          onTap : ()=>Get.to(()=>const CatePage(page: 0))
        ),
        SizedBox(
          height : 52,
          child:  MinimalVList(
            list : widget.tagList,
            onClick: (index)=>pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOutCubic)
          ),
        ),
        Container(
          height : 210,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border: Border(
              bottom: rowBorderLine()
            ),
          ),
          child: PageView.builder(
            controller: pageController,
            itemCount: con.tagList.length,
            itemBuilder: (context,index){
              return CollectedVList(
                feed : con.tagList[widget.tagList[index]]!, 
                onFeedClick: (id)=>Get.to(()=>FeedPage(feed: con.tagList[widget.tagList[index]]!.singleWhere((el)=>el.id == id))),
              );
            }
          ),
        )
      ]
    );
  }
}

class PartContainer extends StatelessWidget {
  final List<Widget>? children;
  const PartContainer({super.key , this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child : Column(
        children: children!,
      ),
    );
  }
}

class TitleRow extends StatelessWidget {
  final String? title;
  final double? fontSize;
  final Function()? onTap;
  const TitleRow({
    super.key,
    this.title,
    this.fontSize = 18,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width : double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.only(
          bottom: 8.0,
          top : 8.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                (title != null)?
                Text(
                  title.toString(),
                  style: TextStyle(
                    fontSize : fontSize,
                    fontWeight: FontWeight.w900,
                    color : Theme.of(context).colorScheme.primary
                  ),
                ):const SizedBox.shrink(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPart extends StatelessWidget {
  const SearchPart({super.key});

  @override
  Widget build(BuildContext context) {
   return Center(
     child: Container(
      width : MediaQuery.of(context).size.width * 0.9,
      height : 42,
      margin:const EdgeInsets.only(top : 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: const BorderRadius.all(Radius.circular(100))
      ),
      child : LayoutBuilder(
        builder: (context,layout) {
          return Row(
            children: [
              SizedBox(
                width : layout.maxWidth - 54,
                child: CommonTextInput(
                  bColor: Colors.transparent,
                  placeholder: "검색어를 입력해주세요",
                  placeholderStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary
                  )
                )
              ),
              NavbarCommonBtn(
                "navbar/search.svg",
                onClick : (){},
                iconColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          );
        }
      ),
       ),
   );
  }
}