import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:photo_view/photo_view.dart';
import 'package:lottie/lottie.dart';

class ImgZoomView extends StatefulWidget {
  final List<dynamic> imageLinks;
  final int index;
  final int page;

  const ImgZoomView({super.key,required this.page, required this.imageLinks,required this.index});

  @override
  State<ImgZoomView> createState() => _ImgZoomViewState();
}

class _ImgZoomViewState extends State<ImgZoomView> {
  late PageController _controller;
  @override
  Widget build(BuildContext context) {
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
                  imageProvider: Image.network(
                    widget.imageLinks[index],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace){
                      return LottieBuilder.asset(
                        "assets/icons/common/loading.json",
                        width : 64 , height : 64
                      );
                    },
                  ).image,
                  onScaleEnd: (context,details,value)=> Get.back(),
                  heroAttributes: PhotoViewHeroAttributes(tag: "${widget.page}-${widget.imageLinks[widget.index]}"),
                  loadingBuilder:(context, event) => const Center(
                    child : SizedBox(
                      width : 32,
                      height : 32,
                      child : CircularProgressIndicator(
                        strokeWidth: 2,
                        color: CommonStyle.first,
                      )
                    )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width : 32,
                  height : 32,
                  decoration: const BoxDecoration(
                    color : Color.fromRGBO(56, 56, 56, 0.5),
                    borderRadius: RowContainer.radius,
                  ),
                  margin : const EdgeInsets.only(top: 56,right: 32),
                  child : IconButton(
                    onPressed: () => Get.back(),
                    icon : SvgPicture.asset(
                      "assets/icons/common/close.svg",
                      width : 12,
                      height : 12,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    )
                  )
                )
              )
            ],
          );
        },
      )
    );
  }
}