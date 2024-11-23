import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/post/share.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';
import 'package:photo_view/photo_view.dart';
import 'package:lottie/lottie.dart';

class ImgZoomView extends StatefulWidget {
  final List<dynamic> imageLinks;
  final int index;
  final int page;
  final String? mode;

  const ImgZoomView({super.key,required this.page, required this.imageLinks,required this.index,this.mode = "view"});

  @override
  State<ImgZoomView> createState() => _ImgZoomViewState();
}

class _ImgZoomViewState extends State<ImgZoomView> {
  late PageController _controller;
 
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.width;
    _controller = PageController(initialPage: widget.index);
    return Scaffold(
      body : PageView.builder(
        controller: _controller,
        itemCount: widget.imageLinks.length,
        itemBuilder: (context,index){
          return Stack(
            children: [
              PhotoViewGestureDetectorScope(
                axis : Axis.vertical,
                child: PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  imageProvider: customImgProvider(
                    widget.imageLinks[index],
                    fit: BoxFit.contain,
                    loading: LottieBuilder.asset(
                      "assets/icons/common/loading.json",
                      width : 64 , height : 64
                    )
                  ),
                  onScaleEnd: (BuildContext context,ScaleEndDetails details,PhotoViewControllerValue value){
                    if (value.scale! < 0.2){
                      Get.back();
                    }
                  },
                  heroAttributes: PhotoViewHeroAttributes(tag: "${widget.page}-${widget.mode}-${widget.imageLinks[widget.index]}"),
                  loadingBuilder:(context, event) => Center(
                    child : SizedBox(
                      width : 32,
                      height : 32,
                      child : CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimaryFixed
                      )
                    )
                  ),
                  backgroundDecoration: BoxDecoration(
                    color : Theme.of(context).colorScheme.onPrimary
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width : 32,
                  height : 32,
                  decoration: BoxDecoration(
                    color : Theme.of(context).colorScheme.onPrimary,
                    border : rowBorderLineAll(),
                    borderRadius: RowContainer.radius,
                  ),
                  margin : EdgeInsets.symmetric(
                    vertical: width * 0.1,
                    horizontal: height * 0.1
                  ),
                  child : IconButton(
                    onPressed: () => Get.back(),
                    icon : SvgPicture.asset(
                      "assets/icons/common/close.svg",
                      width : 16,
                      height : 16,
                    )
                  )
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child : imgZoomBottom(context,pageId : widget.page),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget imgZoomBottom(BuildContext context,{
  int? pageId
}){
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.width;
  return (pageId != null)?Container(
    margin : EdgeInsets.symmetric(
      vertical: width * 0.1,
      horizontal: height * 0.1
    ),
    decoration: BoxDecoration(
      color : Theme.of(context).colorScheme.onPrimary,
      border : rowBorderLineAll(),
      borderRadius: RowContainer.radius
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width : 36,
          height : 36,
          child: IconButton(
            onPressed: (){},
            icon : SvgPicture.asset(
              "assets/icons/post/star-empty.svg",
              width : 32 , height : 32,
              fit: BoxFit.cover,
            )
          ),
        ),
        const SizedBox(width : 32),
        SizedBox(
         width : 36,
          height : 36,
          child: IconButton(
            onPressed: ()=>showModalBottomSheet(
              useRootNavigator: true,
              context: context,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              builder: (BuildContext context){
                return ShareModal(url : "${Url.clientList}?page=$pageId");
            }),
            icon : SvgPicture.asset(
              "assets/icons/post/share.svg",
              width : 32 , height : 32,
              fit: BoxFit.cover,
            )
          ),
        ),
      ],
    ),
  ):const SizedBox.shrink();
}