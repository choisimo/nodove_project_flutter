import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class CustomImage extends StatelessWidget {
  final String src;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? loading;
  final Widget? alt;
  const CustomImage(
    this.src,{
    super.key,
    this.fit,
    this.width,
    this.height,
    this.loading,
    this.alt
  });

  @override
  Widget build(BuildContext context) {
    return 
    (src.contains("http"))?
    Image.network(
      src,
      fit: fit??BoxFit.contain,
      width : width,
      height : height,
      loadingBuilder: 
      (context, child, loadingProgress) {
        if (loadingProgress == null){
          return child;
        }
        return loading??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64,
        );
      },
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    ):Image.asset(
      src,
      fit: fit??BoxFit.contain,
      width : width,
      height : height,
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    );
  }
}

ImageProvider customImgProvider(
  String src,
  {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? loading,
    Widget? alt
  }){
  return (src.contains("http"))?
  Image.network(
      src,
      fit: fit??BoxFit.contain,
      width : width??200,
      height : height??200,
      loadingBuilder: 
      (context, child, loadingProgress) {
        if (loadingProgress == null){
          return child;
        }
        return loading??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64,
        );
      },
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    ).image:
    Image.asset(
      "assets/images/logo.png",
      fit: fit??BoxFit.contain,
      width : width,
      height : height,
      errorBuilder: 
      (context, error, stackTrace){
        return alt??LottieBuilder.asset(
          "assets/icons/common/loading.json",
          width : 64 , height : 64
        );
      },
    ).image;
}

class CustomSvg extends StatelessWidget {
  final String src;
  final double width;
  final double height;
  final Color? iconColor;
  const CustomSvg(this.src,{
    super.key, 
    this.width = 16,
    this.height = 16,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$src",
      width: width,
      height : height,
      colorFilter: 
      (iconColor != null)?
      ColorFilter.mode(
        iconColor!,
        BlendMode.srcIn
      ):const ColorFilter.mode(Colors.transparent, BlendMode.color),
    );
  }
}
