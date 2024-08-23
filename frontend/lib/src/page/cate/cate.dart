import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/page/cate/writecate.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feedlist.dart';
import 'package:nodove_flutter/src/page/list/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:shimmer/shimmer.dart';

class CatePage extends StatefulWidget {
  final int page;
  const CatePage({super.key,required this.page});

  @override
  State<CatePage> createState() => _CatePageState();
}

class _CatePageState extends State<CatePage> {

  @override
  Widget build(BuildContext context) {
    Get.put(PageState());
    bool popupOpen = false;
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    final arg = arguments['backName'];

    NavbarContent navbarOpt = NavbarContent(
      title : (arg !=null )?
      navbarTitle(context, arg, 20)
      :PopupMenuButton(
        color : Theme.of(context).colorScheme.onPrimary,
        shadowColor: Colors.transparent,
        onOpened: () => setState((){popupOpen=true;}),
        onCanceled: () => setState((){popupOpen=false;}),
        shape : TooltipShape(
          vertical : 125,
          borderColor : Theme.of(context).colorScheme.shadow
        ),
        offset : const Offset(0,36),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              child: Row(
                children : [
                  SizedBox(
                    width : 24,
                    child: SvgPicture.asset(
                      "assets/icons/navbar/menu.svg",
                      width : 10 , height : 10,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                    ),
                  ),
                  navbarTitle(context,"카테고리",20)
                ]
              ),
              onTap: () {
                print('카테고리 선택');
              },
            ),
            PopupMenuItem(
              child: Row(
                children :[
                  SizedBox(
                    width : 24,
                    child: SvgPicture.asset(
                      "assets/icons/navbar/hashtag.svg",
                      width : 12 , height : 12,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                    ),
                  ),
                  navbarTitle(context,"태그",20)
                ]
              ),
              onTap: () {
                print('태그 선택');
              }
            ),
            PopupMenuItem(
              child: Row(
                children :[
                  SizedBox(
                    width : 24,
                    child: SvgPicture.asset(
                      "assets/icons/navbar/navi.svg",
                      width : 12 , height : 12,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                    ),
                  ),
                  navbarTitle(context,"내 위치",20)
                ]
              ),
              onTap: () {
                print('위치 선택');
              }
            ),
          ];
        },
        child: Row(
          children : [
            navbarTitle(context,"카테고리",20),
            Rotate(
              angle : (popupOpen)?270:90,
              child: SizedBox(
                width : 20,
                child: SvgPicture.asset(
                  "assets/icons/common/right.svg",
                  width : 12 , height : 12,
                   colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                ),
              ),
            ),
          ]
        )
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
      floatingActionButton: plusButton(),
      appBar: navbarTop(context,navbarOpt,false),
      body : CateList(
        page : widget.page,
      ),
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
  const CateList({
    super.key,
    required this.page,
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
    con.getCate(widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return customRefreshIndicator(
      context,
      onRefresh: ()=>refresh(),
      child: Obx((){
          list = con.catelist;
          if (con.isFetching.isTrue){
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context,index){
                return const CateRowSkel();
              }
            );
          } else if (list.isEmpty){
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context,index){
                return const Text("카테고리가 없어요");
              }
            );
          } else{
            return ListView.builder(
              itemCount: list.length,
              itemBuilder :(context, index) {
                return CateRow(props: list[index],key : Key("${list[index].categoryId}"));
              },
            );
          }
        }
      )
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
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Profile(
                profile: "https://www.jbnu.ac.kr/kor/images/227_10.jpg",
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
                      Text(
                        props.categoryName,
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        style : TextStyle(
                          fontSize : 18,
                          color : Theme.of(context).colorScheme.onPrimaryFixed,
                        )
                      ),
                      Text(
                        '"${props.categoryDescription}"',
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style : TextStyle(
                          fontSize : 14,
                          color : Theme.of(context).colorScheme.primary,
                        )
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width : constraint.minWidth * 0.15,
                height : 42,
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
                      color: Colors.white
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
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
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