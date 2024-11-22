import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/media/zoom.dart';

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
  int current = 0;
  var error = false;
  final CarouselSliderController _controller = CarouselSliderController();
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width : MediaQuery.of(context).size.width,
      child : Stack(
        alignment: Alignment.bottomCenter,
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
    double width = MediaQuery.of(context).size.width;
    
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
                  child: CustomImage(
                    imageLinks[i.key],
                    fit : BoxFit.cover,
                  ),
                )
              )
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height : width,
        viewportFraction: 1.0,
        scrollPhysics : const AlwaysScrollableScrollPhysics(),
        clipBehavior : Clip.antiAlias,
        enableInfiniteScroll : false,
        autoPlay: false,
        onPageChanged: (index ,reason){
          setState(() {
            current = index;
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
        height : size,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: imageLinks.length,
          itemBuilder: (context, index) {
            return Opacity(
              opacity: 0.5,
              child: SizedBox(
                width : size,
                height : size,
                child: IconButton(
                  onPressed: () => _controller.animateToPage(
                    index,
                    curve : Curves.ease
                  ),
                  icon : (imageLinks[index].contains("/serve/attach"))?
                  CustomSvg(
                    "post/video.svg",
                    width : size , height : size,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                  )
                  :
                  CustomSvg(
                    "post/picture.svg",
                    width : size , height : size,
                    iconColor: Theme.of(context).colorScheme.onPrimary,
                  )
                )
              ),
            );
          },
        ),
    ):const SizedBox.shrink();
  }
}

class BannerCarousel extends StatefulWidget {
  final List<dynamic> imageLinks;
  final Function(int index)? onPressed;
  const BannerCarousel({super.key,required this.imageLinks,this.onPressed});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final CarouselSliderController controller = CarouselSliderController();
  int current = 0;

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    return (widget.imageLinks.isNotEmpty)?
    CarouselSlider(
      carouselController: controller,
      items: widget.imageLinks.asMap().entries.map((i){
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary
              ),
              width : MediaQuery.of(context).size.width,
              child : GestureDetector(
                onScaleStart: (_)=>widget.onPressed?.call(i.key),
                onTap: ()=>widget.onPressed?.call(i.key),
                child : Hero(
                  tag : "Main-Banner-${widget.imageLinks[i.key]}",
                  child: CustomImage(
                    widget.imageLinks[i.key],
                    fit : BoxFit.cover,
                  ),
                )
              )
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height : maxHeight,
        viewportFraction: 1.0,
        scrollPhysics : const AlwaysScrollableScrollPhysics(),
        clipBehavior : Clip.antiAlias,
        enableInfiniteScroll : false,
        autoPlay: false,
        onPageChanged: (index ,reason){
          setState(() {
            current = index;
          });
        }
      )
    ):const SizedBox.shrink();
  }
}


/*
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
                    },

*/