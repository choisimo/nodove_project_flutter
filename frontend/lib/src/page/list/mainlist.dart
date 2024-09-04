import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/list/feedlist.dart';
import 'package:nodove_flutter/src/page/map/map.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';

class FeedMainPage extends StatelessWidget {
  const FeedMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(context,"피드",20),
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
      body: const FeedMainList(),
    );
  }
}

class FeedMainList extends StatelessWidget {
  const FeedMainList({super.key});

  

  @override
  Widget build(BuildContext context) {
    List<String> tagList = [
      '게시글 테스트',
      '여행',
      "태그"
    ];
    BoxDecoration boxDecoration = BoxDecoration(
      boxShadow: [
        BoxShadow(
          color : Theme.of(context).colorScheme.shadow,
          offset: RowContainer.offset,
          blurRadius: RowContainer.blurRadius
        )
      ],
      color : Theme.of(context).colorScheme.onPrimary,
    );
    int pageSize = 5;
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child : GestureDetector(
            onTap: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (_)=>const CatePage(page: 0))
            ),
            child: Container(
              decoration : boxDecoration,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/navbar/navi.svg",
                        width : 16,height : 16,
                        colorFilter:
                        ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                      ),
                      const SizedBox(width : 4),
                      Text(
                        "내 위치",
                        style: TextStyle(
                          fontSize : 18,
                          fontWeight: FontWeight.bold,
                          color : Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/common/right.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  )
                ],
              ),
            ),
          ) 
        ),
        SliverToBoxAdapter(
          child: mapPreview(context),
        ),
        SliverToBoxAdapter(
          child : GestureDetector(
            onTap: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (_)=>const CatePage(page: 0))
            ),
            child: Container(
              decoration : boxDecoration,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/navbar/summarize.svg",
                        width : 16,height : 16,
                        colorFilter:
                        ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                      ),
                      const SizedBox(width : 4),
                      Text(
                        "카테고리",
                        style: TextStyle(
                          fontSize : 18,
                          fontWeight: FontWeight.bold,
                          color : Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/common/right.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  )
                ],
              ),
            ),
          ) 
        ),
        SliverToBoxAdapter(
          child : SizedBox(
            child: CateList(
              page : 0,
              selection : pageSize,
            )
          ),
        ),
        SliverToBoxAdapter(
          child : GestureDetector(
            onTap: ()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (_)=>const CatePage(page: 0))
            ),
            child: Container(
              decoration : boxDecoration,
              padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/navbar/hashtag.svg",
                        width : 16,height : 16,
                        colorFilter:
                        ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                      ),
                      const SizedBox(width : 4),
                      Text(
                        "태그",
                        style: TextStyle(
                          fontSize : 18,
                          fontWeight: FontWeight.bold,
                          color : Theme.of(context).colorScheme.onSurface
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    "assets/icons/common/right.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  )
                ],
              ),
            ),
          ) 
        ),
        SliverList.builder(
          itemCount: tagList.length,
          itemBuilder: (context,index){
            return CollectedVList(
              url: "${Url.apiUrl}/getPostListByTag/${Uri.encodeComponent(tagList[index])}",
              opt: "pageSize=5",
              title: "#${tagList[index]}",
            );
          }
        )
      ]
    );
  }
}