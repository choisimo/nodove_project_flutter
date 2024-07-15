import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class CatePage extends StatelessWidget {
  const CatePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PageState());
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context),
      actions : [
        searchBtn(context),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,true),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButton: plusButton(),
      body : ChangeNotifierProvider<CateListModel>(
        create : (context) => CateListModel(),
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
  final CateListModel cate = CateListModel();

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

class CateRow extends StatelessWidget {
  final Categories props;
  const CateRow({super.key,required this.props});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap : ()=>Get.toNamed("/list/${props.categoryId}"),
      child : Container(
      height : 96,
      margin : const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        boxShadow: [RowContainer.shadow],
        color : RowContainer.background,
      ),
      child : LayoutBuilder(
        builder : (context,constraint){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              etcBtn(
                context,
                (int id){},
                props.categoryId
              ),
              const Profile(
                profile: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRNAWPmYQgACzkRRUDTwBDzONjC3rlmMCfxw&s",
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
                  onPressed: ()=>Get.toNamed("/cate/${props.categoryId}"),
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