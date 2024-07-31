import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget customImage(
  String src,
  {
    BoxFit? fit,
    double? width,
    double? height,
    Widget? loading,
    Widget? alt
  }
){
  return 
    (src.isNotEmpty)?
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
    ):const SizedBox.shrink();
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
  return Image.network(
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
    ).image;
}