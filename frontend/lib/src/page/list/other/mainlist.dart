import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
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
          "assets/icons/navbar/search.svg",
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
      backgroundColor: Theme.of(context).colorScheme.surface,
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
          child : 
          partContainer(
            context,
            children: [
              titleRow(
                context,
                title : "내 위치",
                iconSrc: "assets/icons/navbar/navi.svg",
                link : const MapPage()
              ),
              mapPreview(context)
            ],
          )
        ),
        SliverToBoxAdapter(
          child : partContainer(
            context,
            children: [
              titleRow(
                context,
                title : "카테고리",
                iconSrc: "assets/icons/navbar/menu.svg",
                link : const CatePage(page: 0),
                iconWidth: 14,
                iconHeight: 14,
              ),
              CateList(
                page : 0,
                selection : pageSize,
              )
            ]
          )
        ),
        SliverToBoxAdapter(
          child : partContainer(
            context,
            children: [
              titleRow(
                context,
                title : "추천하는 #해시태그에요",
                link : const CatePage(page: 0)
              ),
              ListView.builder(
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
              )
            ]
          )
        ),
      ]
    );
  }
  Widget partContainer(
    BuildContext context,{
      List<Widget>? children
    }
  ){
    BoxDecoration boxDecoration = BoxDecoration(
      boxShadow: rowBorderShadow(),
      color : Theme.of(context).colorScheme.onPrimary,
    );
    return Container(
      decoration : boxDecoration,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child : Column(
        children: children!,
      )
    );
  }

  Widget titleRow(
    BuildContext context,{
      String? title,
      String? iconSrc,
      double? iconWidth = 16,
      double? iconHeight = 16,
      Widget? link
    }
  ){
     
    return GestureDetector(
      onTap: (){
        if (link != null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_)=>link)
          );
        }
      },
      child: Container(
        width : double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                (title != null)?
                Text(
                  title,
                  style: TextStyle(
                    fontSize : 18,
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
            color: Theme.of(context).colorScheme.onPrimary,
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
                    child: commonTextInput(
                      context,
                      bColor: Colors.transparent,
                      placeholder: "피드를 검색해주세요",
                      placeholderStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary
                      )
                    )
                  ),
                  NavbarCommonBtn(
                    "assets/icons/navbar/search.svg",
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