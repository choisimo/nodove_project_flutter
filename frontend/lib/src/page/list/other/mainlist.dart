import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/state/url.dart';

class FeedMainPage extends StatefulWidget {
  const FeedMainPage({super.key});

  @override
  State<FeedMainPage> createState() => _FeedMainPageState();
}

class _FeedMainPageState extends State<FeedMainPage> {
  late ScrollController scrollController;
  bool exposed = true;

  @override
  void initState(){
    scrollController = ScrollController()..addListener(scrollRef);
    super.initState();
  }

  void scrollRef(){
    try{
      if (scrollController.position.pixels < 16){
        if (exposed == false){
          setState((){
            exposed = true;
          });
        }
      } else {
        if (exposed == true){
          setState((){
            exposed = false;
          });
        }
      }
    } catch(_){

    }
  }

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("피드"),
      actions : [
        NavbarCommonBtn(
          "navbar/search.svg",
          onClick : (){
            if (exposed == true){
              setState((){
                exposed = false;
              });
            }
          }
        )
      ]
    );
    PreferredSize appbar = PreferredSize(
      preferredSize: const Size.fromHeight(54),
      child: AnimatedCrossFade(
        firstChild: NavbarTop(navbarOpt, centerTitle : false),
        secondChild: const SearchPart(),
        crossFadeState: (exposed)?CrossFadeState.showFirst:CrossFadeState.showSecond,
        duration: const Duration(milliseconds: 300),
      ),
    );
    return Scaffold(
      appBar: appbar,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: FeedMainList(
        scrollController: scrollController,
      ),
    );
  }
}

class FeedMainList extends StatelessWidget {
  final ScrollController? scrollController;
  const FeedMainList({
    super.key,
    this.scrollController
  });

  @override
  Widget build(BuildContext context) {
    List<String> tagList = [
      '게시글 테스트',
      '여행',
      "태그"
    ];
    int pageSize = 3;
    int tagSize = 3;
    return CustomScrollView(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
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
          child : PartContainer(
            children: [
              TitleRow(
                title : "추천하는 #해시태그에요",
                onTap : ()=>Get.to(()=>const CatePage(page: 0))
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  border: Border(
                    bottom: rowBorderLine()
                  ),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: tagSize,
                  itemBuilder: (context,index){
                    return CollectedVList(
                      url: "${Url.apiUrl}/getPostListByTag/${Uri.encodeComponent(tagList[index])}",
                      opt: "pageSize=3",
                      title: "#${tagList[index]}",
                    );
                  }
                ),
              )
            ]
          )
        ),
      ]
    );
  }
}

class PartContainer extends StatelessWidget {
  final List<Widget>? children;
  const PartContainer({super.key , this.children});

  @override
  Widget build(BuildContext context) {
    BoxDecoration boxDecoration = BoxDecoration(
      border: Border(
        bottom: rowBorderLine()
      ),
      color : Theme.of(context).colorScheme.onPrimary,
    );
    return Container(
      //decoration : boxDecoration,
      child : SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: children!,
        ),
      )
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
          top : 16.0
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
   return SafeArea(
      child: Center(
        child: Container(
          width : MediaQuery.of(context).size.width * 0.9,
          height : 42,
          margin:const EdgeInsets.only(top : 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border : Border.all(
              color : Theme.of(context).colorScheme.onPrimaryFixed
            ),
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
                      placeholder: "피드를 검색해주세요",
                      placeholderStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary
                      )
                    )
                  ),
                  NavbarCommonBtn(
                    "navbar/search.svg",
                    onClick : (){},
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}