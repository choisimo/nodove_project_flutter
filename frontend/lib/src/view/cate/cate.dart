import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:provider/provider.dart';

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
    bool PopupOpen = false;
    int page = widget.page;
    final String arg = Get.arguments?["backName"]??'';

    void setPopup (bool bool) => setState(()=>PopupOpen=bool);

    NavbarContent navbarOpt = NavbarContent(
      title : (arg.isNotEmpty)?
      navbarTitle(context, arg, 20)
      :PopupMenuButton(
        onOpened: () => setState((){PopupOpen=true;}),
        onCanceled: () => setState((){PopupOpen=false;}),
        shape : TooltipShape(125,Theme.of(context).colorScheme.onSurface),
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
              angle : (PopupOpen)?270:90,
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
        searchBtn(context),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: plusButton(),
      appBar: navbarTop(context,navbarOpt,false),
      body : ChangeNotifierProvider<CateListModel>(
        create : (context) => CateListModel(page),
        child : const CateList()
      ),
    );
  }
  Widget plusButton(){
    return FloatingActionButton(
      onPressed: (){},
      backgroundColor: CommonStyle.first,
      child : SvgPicture.asset(
        'assets/icons/navbar/noBorderAdd.svg',
        width : 24,
        height : 24,
        colorFilter: ColorFilter.mode(Colors.white,BlendMode.srcIn),
      )
    );
  }
}

class CateList extends StatefulWidget {
  const CateList({super.key});

  @override
  State<CateList> createState() => _CateListState();
}

class _CateListState extends State<CateList> {
  late List<Categories> list;

  Future<void> refresh() async{
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()=>refresh(),
      child: Consumer<CateListModel>(
        builder: (context, value, child){
          list = value.cate;
          if (list.isNotEmpty){
            return ListView.builder(
              itemCount: list.length,
              itemBuilder :(context, index) {
                return CateRow(props: list[index],key : Key("${list[index].categoryId}"));
              },
            );
          }else{
            return const Center(
              child: SizedBox(
                width : 40,
                height : 40,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            );
          }
        }
      ),
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
  @override
  Widget build(BuildContext context) {
    Categories props = widget.props;

    return GestureDetector(
      onTap : ()=>Get.toNamed(
        "/list/${props.categoryId}",

      ),
      child : Container(
      height : 96,
      margin : const EdgeInsets.symmetric(vertical: 8),
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
              PopupMenuButton(
                constraints: const BoxConstraints(
                  minWidth : 120
                ),
                shape : TooltipShape(92,Theme.of(context).colorScheme.onSurface),
                offset : const Offset(0,40),
                icon : Text(
                  '•••',
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  style : TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface
                  )
                ),
                itemBuilder: (BuildContext context) { 
                  return [
                  PopupMenuItem(
                    child: Row(
                      children :[
                        SizedBox(
                          width : 24,
                          child: SvgPicture.asset(
                            "assets/icons/navbar/noBorderAdd.svg",
                            width : 12 , height : 12,
                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                          ),
                        ),
                        navbarTitle(context,"구독",20)
                      ]
                    ),
                    onTap: () {
                      print('구독 선택');
                    },
                  ),
                  PopupMenuItem(
                    child: Row(
                      children :[
                        SizedBox(
                          width : 24,
                          child: SvgPicture.asset(
                            "assets/icons/navbar/certification.svg",
                            width : 12 , height : 12,
                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.error, BlendMode.srcIn),
                          ),
                        ),
                        navbarTitle(context,"신고",20)
                      ]
                    ),
                    onTap: () {
                      print('카테고리 신고 선택');
                    }
                  ),
                  ];
                },
              ),
              const Profile(
                profile: "https://www.jbnu.ac.kr/kor/images/227_10.jpg",
                width: 56,
                height: 56
              ),
              Container(
                width : constraint.maxWidth * 0.5,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      props.categoryName,
                      maxLines: 1,
                      style : const TextStyle(
                        fontSize : 18,
                        color : CommonStyle.first,
                      )
                    ),
                    Text(
                      '"${props.categoryDescription}"',
                      maxLines: 2,
                      style : TextStyle(
                        fontSize : 14,
                        color : Theme.of(context).colorScheme.primary,
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(
                width : constraint.minWidth * 0.15,
                height : constraint.maxHeight, 
                child: 
                (props.children.isNotEmpty)?
                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      )
                    )
                  ),
                  icon: SvgPicture.asset(
                    "assets/icons/common/right.svg",
                    width : 16 , height : 16,
                    colorFilter: ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                  ),
                  onPressed: ()=>Get.to(
                    ()=>CatePage(page : props.categoryId),
                    arguments: {
                      "backName" : props.categoryName
                    },
                    preventDuplicates: false,
                  ),
                ):SizedBox.shrink(),
              ),
            ],
          );
        }
      )
    ),
    );
  }
}