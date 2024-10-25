import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/media/zoom.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> imageLinks;
  final int page;

  const Carousel({
    super.key,
    required this.imageLinks,
    required this.page,
  });

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
  var error = false;
  final CarouselController _controller = CarouselController();
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : MediaQuery.of(context).size.width,
      child : Stack(
        children: [
          carouselWidget(),
          carouselIndicator()
        ],
      )
    );
  }

  Widget carouselWidget(){
    List<dynamic> imageLinks = widget.imageLinks;
    int page = widget.page;
    
    return 
    (imageLinks.isNotEmpty)?
    CarouselSlider(
      carouselController: _controller,
      items: imageLinks.asMap().entries.map((i){
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary
              ),
              width : MediaQuery.of(context).size.width,
              child : GestureDetector(
                onScaleStart: (detail){
                  if (!error){
                    Get.to(
                      ()=>ImgZoomView(page : page , imageLinks: imageLinks, index: i.key),
                      fullscreenDialog: true
                    );
                  }
                },
                onTap: (){
                  if (!error){
                    Get.to(
                      ()=>ImgZoomView(page : page , imageLinks: imageLinks, index: i.key),
                      fullscreenDialog: true
                    );
                  }
                },
                child : Hero(
                  tag : "$page-${imageLinks[i.key]}",
                  child: customImage(
                    imageLinks[i.key],
                    fit : BoxFit.contain,
                  ),
                )
              )
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height : 420,
        viewportFraction: 1.0,
        scrollPhysics : const AlwaysScrollableScrollPhysics(),
        clipBehavior : Clip.antiAlias,
        enableInfiniteScroll : false,
        autoPlay: false,
        onPageChanged: (index ,reason){
          setState(() {
            _current = index;
          });
        }
      )
    ):const SizedBox.shrink();
  }
  Widget carouselIndicator(){
    List<dynamic> imageLinks = widget.imageLinks;
    const double size = 32;

    return
    (imageLinks.isNotEmpty)?
      SizedBox(
        height : 420,
        child: Align(
          alignment: Alignment.bottomCenter,
          child : Container(
            clipBehavior: Clip.hardEdge,
            height : size,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: const BorderRadius.all(Radius.circular(size)),
              boxShadow: rowBorderShadow()
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: imageLinks.length,
              itemBuilder: (context, index) {
                return IconButton(
                  onPressed: () => _controller.animateToPage(
                    index,
                    curve : Curves.ease
                  ),
                  icon : (imageLinks[index].contains("/serve/attach"))?
                  SvgPicture.asset(
                    "assets/icons/post/video.svg",
                    width : size , height : size,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  )
                  :
                  SvgPicture.asset(
                    "assets/icons/post/picture.svg",
                    width : size , height : size,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
                  )
                );
              },
            ),
          )
        )
    ):const SizedBox.shrink();
  }
}

/*
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
                    },

*/