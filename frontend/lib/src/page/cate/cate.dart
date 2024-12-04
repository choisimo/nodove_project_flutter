import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/page/cate/writecate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vfeed.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:shimmer/shimmer.dart';
import "dart:math" as math;

class CatePage extends StatefulWidget {
  final int page;
  const CatePage({super.key,required this.page});

  @override
  State<CatePage> createState() => _CatePageState();
}

class _CatePageState extends State<CatePage> with SingleTickerProviderStateMixin {
  late TabController tabController =
  TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );
  final ScrollController _scrollController = ScrollController();
  CateListModel con = Get.put(CateListModel());
  Future<void> refresh() async{
    con.getCate(
      page : widget.page,
    );
  }
  @override
  Widget build(BuildContext context) {
    Get.put(PageState());
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final arg = arguments['backName'];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: CustomFloatingButton(
        onClick: ()=>Get.to(()=>const WriteCatePage(),fullscreenDialog: true),
        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
        child : SvgPicture.asset(
          'assets/icons/post/edit.svg',
          width : 24,
          height : 24,
          colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
        )
      ),
      body : CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: false,
            leading : BackBtn(onPressed: ()=>Navigator.of(context).pop()),
            title : (arg !=null )?
            NavbarTitle(arg)
            :const NavbarTitle("카테고리"),
            actions : [
              NavbarCommonBtn(
                "navbar/search.svg",
                onClick : (){},
              ),
            ]
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: [
                CustomRefreshIndicator(
                  onRefresh: ()=>refresh(),
                  child: CateList(
                    page : widget.page,
                    scroll: false,
                  ),
                ),
                const Text("빈 텍스트")
              ],
            )
          )
        ],
      )
    );
  }
}

class CateList extends StatefulWidget {
  final int page;
  final String? url;
  final String? opt;
  final int? selection;
  final bool scroll;
  final bool collected;
  const CateList({
    super.key,
    required this.page,
    this.url,
    this.opt,
    this.selection,
    this.scroll = true,
    this.collected = false
  });

  @override
  State<CateList> createState() => _CateListState();
}

class _CateListState extends State<CateList> {
  late List<Categories> list;
  CateListModel con = Get.put(CateListModel());

  @override
  void initState(){
    refresh();
    super.initState();
  }
  Future<void> refresh() async{
    con.getCate(
      page : widget.page,
      url : widget.url,
      opt : widget.opt
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      list = con.catelist;
      if (widget.collected){
        return const SizedBox.shrink();
      } else {
        if (con.isFetching.isTrue){
          return ListView.builder(
            shrinkWrap: (widget.selection != null),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 7,
            itemBuilder: (context,index){
              return const CateRowSkel();
            }
          );
        } else if (list.isEmpty){
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: (widget.selection != null),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context,index){
              return const Text("카테고리가 없어요");
            }
          );
        } else{
          return ListView.builder(
            padding: const EdgeInsets.all(0),
            shrinkWrap: (widget.selection != null),
            physics: (widget.selection != null||!widget.scroll)?const NeverScrollableScrollPhysics():const AlwaysScrollableScrollPhysics(),
            itemCount: math.min(widget.selection??list.length,list.length),
            itemBuilder :(context, index) {
              return CateRow(cate: list[index],key : Key("${list[index].categoryId}"));
            },
          );
        }
      }
    }
  );
  }
}

class CateRow extends StatefulWidget {
  final Categories cate;
  const CateRow({super.key,required this.cate});

  @override
  State<CateRow> createState() => _CateRowState();
}

class _CateRowState extends State<CateRow> {
  TempFeed con = Get.put(TempFeed());
  @override
  Widget build(BuildContext context) {
    Categories cate = widget.cate;
      /* ()=>Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=>FeedListPage(cate : cate.categoryId),
        
      )
    ),*/
    return GestureDetector(
      onTap : ()=>Navigator.of(context).push(MaterialPageRoute(
        builder: (_)=>
        FeedListPage(page : cate.categoryId)
      )),
      child : Container(
      height : 64,
      decoration: BoxDecoration(
        border: Border(
          bottom: rowBorderLine()
        ),
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Profile(
                profile: cate.categoryImage??"",
                width: 42,
                height: 42
              ),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        cate.categoryName,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style : const TextStyle(
                          fontSize : 16,
                        )
                      ),
                      Text(
                        '"${cate.categoryDescription}"',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style : TextStyle(
                          fontSize : 12,
                          color : Theme.of(context).colorScheme.secondary,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width : constraint.minWidth * 0.15,
                height : 32,
                child : /*(false)?
                TextButton(
                  onPressed: (){},
                  style : TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    shape : const RoundedRectangleBorder(
                      borderRadius: RowContainer.radius,
                    )
                  ),
                  child: const Text(
                    "구독",
                    style: TextStyle(
                      
                    ),
                  ),
                )
                :*/TextButton(
                  onPressed: (){},
                  style : TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Theme.of(context).colorScheme.onSecondary,
                    shape : const RoundedRectangleBorder(
                      borderRadius: RowContainer.radius,
                    )
                  ),
                  child: Text(
                    "구독",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryFixed
                    ),
                  ),
                ),
              ),
              SizedBox(
                width : constraint.minWidth * 0.1,
                height : 42,
                child: 
                IconButton(
                  style : IconButton.styleFrom(
                    shape : const RoundedRectangleBorder(
                      borderRadius: RowContainer.radius
                    )
                  ),
                  icon: const CustomSvg(
                    "common/right.svg",
                    width : 12 , height : 12,
                  ),
                  onPressed: ()=>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => CatePage(page : cate.categoryId),
                      settings: RouteSettings(
                        arguments: {
                          "backName" : cate.categoryName
                        },
                      )
                    )
                  ),
                )
              ),
            ],
          );
        }
      )
    ),
    );
  }
}

class MinimalCateRow extends StatelessWidget {
  final Categories cate;
  const MinimalCateRow({super.key,required this.cate});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : ()=>Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FeedListPage(page : cate.categoryId))),
      child : SizedBox(
      child : Column(
        children: [
          const Profile(
            profile: "https://top.jbnu.ac.kr/sites/archinst/atchmnfl/bbs/5131/thumbnail/temp_1707368024381100.png",
            width: 42,
            height: 42
          ),
          Text(
            cate.categoryName,
            maxLines: 1,
            textAlign: TextAlign.start,
            style : const TextStyle(
              fontSize : 16,
            )
          ),
        ],
      ))
    );
  }
}

class CateRowSkel extends StatelessWidget {
  const CateRowSkel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height : 96,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color : Theme.of(context).colorScheme.shadow,
            offset: RowContainer.offset,
            blurRadius: RowContainer.blurRadius
          )
        ],
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.surface,
        highlightColor: Theme.of(context).colorScheme.onPrimary,
        child: LayoutBuilder(
          builder : (context,constraint){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const ProfileSkel(
                  width: 56,
                  height: 56
                ),
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: RowContainer.radius,
                            color: Theme.of(context).colorScheme.onPrimaryFixed
                          ),
                          height : 18,
                          width : constraint.maxWidth * 0.3,
                        ),
                        const SizedBox(height : 4),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: RowContainer.radius,
                            color: Theme.of(context).colorScheme.onPrimaryFixed
                          ),
                          height : 18,
                          width : constraint.maxWidth * 0.5,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width : constraint.minWidth * 0.3,
                  height : constraint.maxHeight, 
                ),
              ],
            );
          }
        ),
      )
    );
  }
}
