import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/page/cate/writecate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
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
  ScrollController _scrollController = ScrollController();
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
      floatingActionButton: plusButton(),
      body : CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            centerTitle: false,
            title : (arg !=null )?
            NavbarTitle(arg)
            :const NavbarTitle("카테고리"),
            actions : [
              NavbarCommonBtn(
                "assets/icons/navbar/search.svg",
                onClick : (){},
              ),
            ]
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                TextButton(
                  style : TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary
                  ),
                  onPressed: ()=>setState(()=>tabController.index = 0),
                  child : const Text("최신")
                ),
                const SizedBox(width : 4,),
                TextButton(
                  style : TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary
                  ),
                  onPressed: ()=>setState(()=>tabController.index = 1),
                  child : const Text("구독")
                )
              ]
            ,),
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
  Widget plusButton(){
    return FloatingActionButton(
      onPressed: ()=>Get.to(()=>const WriteCatePage(),fullscreenDialog: true),
      backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
      child : SvgPicture.asset(
        'assets/icons/navbar/noBorderAdd.svg',
        width : 24,
        height : 24,
        colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
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
  const CateList({
    super.key,
    required this.page,
    this.url,
    this.opt,
    this.selection,
    this.scroll = true
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
            return CateRow(props: list[index],key : Key("${list[index].categoryId}"));
          },
        );
      }
    }
  );
  }
}
class CateRow extends StatefulWidget {
  final Categories props;
  const CateRow({super.key,required this.props});

  @override
  State<CateRow> createState() => _CateRowState();
}

class _CateRowState extends State<CateRow> {
  CateListModel con = Get.put(CateListModel());
  @override
  Widget build(BuildContext context) {
    Categories props = widget.props;
      /* ()=>Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context)=>FeedListPage(cate : props.categoryId),
        
      )
    ),*/
    return GestureDetector(
      onTap : ()=>Navigator.push(
        context,
        MaterialPageRoute(builder: (_)=>FeedListPage(page : props.categoryId))
      ),
      child : Container(
      height : 64,
      decoration: BoxDecoration(
        boxShadow: rowBorderShadow(),
        color : Theme.of(context).colorScheme.onPrimary,
      ),
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Profile(
                profile: "https://top.jbnu.ac.kr/sites/archinst/atchmnfl/bbs/5131/thumbnail/temp_1707368024381100.png",
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
                        props.categoryName,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style : TextStyle(
                          fontSize : 16,
                          color : Theme.of(context).colorScheme.onPrimaryFixed,
                        )
                      ),
                      Text(
                        '"${props.categoryDescription}"',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style : TextStyle(
                          fontSize : 12,
                          color : Theme.of(context).colorScheme.primary,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width : constraint.minWidth * 0.15,
                height : 32,
                child : (true)?
                TextButton(
                  onPressed: (){
                    
                  },
                  style : TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    shape : const RoundedRectangleBorder(
                      borderRadius: RowContainer.radius,
                    )
                  ),
                  child: const Text(
                    "구독됨",
                    style : TextStyle(
                      color: Colors.white,
                      fontSize : 16,
                    )
                  ),
                )
                :OutlinedButton(
                  onPressed: (){},
                  style : OutlinedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    shape : RoundedRectangleBorder(
                      borderRadius: RowContainer.radius,
                      side : BorderSide(
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    )
                  ),
                  child: Text(
                    "구독",
                    style : TextStyle(
                      color: Theme.of(context).colorScheme.onSurface
                    )
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
                  icon: SvgPicture.asset(
                    "assets/icons/common/right.svg",
                    width : 16 , height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  ),
                  onPressed: ()=>Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:(context) => CatePage(page : props.categoryId),
                      settings: RouteSettings(
                        arguments: {
                          "backName" : props.categoryName
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

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
    _SliverAppBarDelegate(this._tabBar);

    final TabBar _tabBar;

    @override
    double get minExtent => _tabBar.preferredSize.height;
    @override
    double get maxExtent => _tabBar.preferredSize.height;

    @override
    Widget build(
        BuildContext context, double shrinkOffset, bool overlapsContent) {
      return Container(
        color : Theme.of(context).colorScheme.onPrimary,
        child: _tabBar,
      );
    }

    @override
    bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
      return false;
    }
  }