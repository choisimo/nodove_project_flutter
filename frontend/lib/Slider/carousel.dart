import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nodove_flutter/Slider/zoom.dart';

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
  
  void _onError () {
    setState(()=>error = true);
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
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
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

    return
    (imageLinks.isNotEmpty)?
    SizedBox(
      height : 420,
      child: Align(
        alignment: Alignment.bottomCenter,
        child : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children : imageLinks.asMap().entries.map((entry){
            return TextButton(
              onPressed: () => _controller.animateToPage(entry.key),
              child : Container(
                width : 24,
                height : 24,
                margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color : Colors.white,
                  image : DecorationImage(
                    image : Image.network(
                      imageLinks[entry.key],
                      errorBuilder: (context, error, stackTrace){
                        return Image.asset("assets/image/logo.png");
                      },
                    ).image,
                    fit: BoxFit.cover
                  ),
                ),
              )
            );
          }).toList()
        )
      ),
    ):const SizedBox.shrink();
  }
}

/*
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
                    },

*/