import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/Slider/zoom.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:lottie/lottie.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> imageLinks;
  final int page;

  const Carousel({super.key,required this.imageLinks,required this.page});

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
            return SizedBox(
              width : MediaQuery.of(context).size.width,
              child : GestureDetector(
                onScaleStart: (detail){
                  if (!error){
                    Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context,
                      Animation<double> animation1,
                      Animation<double> animation2){
                        return ImgZoomView(page : page , imageLinks: imageLinks, index: i.key);
                      },
                    ));
                  }
                },
                onTap: (){
                  if (!error){
                    Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context,
                      Animation<double> animation1,
                      Animation<double> animation2){
                        return ImgZoomView(page : page , imageLinks: imageLinks, index: i.key);
                      },
                    ));
                  }
                },
                child : Container(
                  child: Hero(
                    tag : "$page-${imageLinks[i.key]}",
                    child: Image.network(
                      imageLinks[i.key],
                      fit : BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null){
                          return child;
                        }
                        return LottieBuilder.asset(
                          "assets/icons/common/loading.json",
                          width : 64 , height : 64,
                        );
                      },
                      errorBuilder: (context, error, stackTrace){
                        return LottieBuilder.asset(
                          "assets/icons/common/loading.json",
                          width : 64 , height : 64
                        );
                      },
                    ),
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
            height : size,
            decoration: const BoxDecoration(
              color: LightStyle.blackAlpha,
              borderRadius: BorderRadius.all(Radius.circular(size)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: imageLinks.length,
              itemBuilder: (context, index) {
                return TextButton(
                  onPressed: () => _controller.animateToPage(
                    index,
                    curve : Curves.ease
                  ),
                  child : (imageLinks[index].contains("/sub/read"))?
                  SvgPicture.asset(
                    "assets/icons/post/video.svg",
                    width : size , height : size,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                  :
                  SvgPicture.asset(
                    "assets/icons/post/picture.svg",
                    width : size , height : size,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
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