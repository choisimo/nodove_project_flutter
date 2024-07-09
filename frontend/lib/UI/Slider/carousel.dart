import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  final List<dynamic> imageLinks;

  const Carousel({super.key,required this.imageLinks});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
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

    return CarouselSlider(
      carouselController: _controller,
      items: imageLinks.map((imageLink){
        return Builder(
          builder: (BuildContext context) {
            return SizedBox(
              width : MediaQuery.of(context).size.width,
              child : Image.network(
                imageLink,
                fit : BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
                },
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
    );
  }
  Widget carouselIndicator(){
    List<dynamic> imageLinks = widget.imageLinks;

    return Container(
      height : 420,
      child: Align(
        alignment: Alignment.bottomCenter,
        child : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children : imageLinks.asMap().entries.map((entry){
            return Container(
                width : 24,
                height : 24,
                margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color : Colors.white,
                ),
                child: IconButton(
                  onPressed: () => _controller.animateToPage(entry.key),
                  icon: Image.network(
                    imageLinks[entry.key],
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                      return Image.asset("assets/images/logo.png",width: MediaQuery.of(context).size.width,);
                    },
                  )
                ),
              );
          }).toList()
        )
      ),
    );
  }
}

/*
      
*/