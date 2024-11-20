import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/func/share.dart';
import 'package:nodove_flutter/state/url.dart';

class ShareModal extends StatelessWidget {
  final String url;
  const ShareModal({
    super.key,
    required this.url
  });

  @override
  Widget build(BuildContext context) {
    return  Modal(
      widget : [
        ModalMenu(
          cb : () => copyLink(
            "${Url.serverUrl}$url",
            callback : ()=>Get.back()
          ),
          title : "링크 복사하기",
        ),
        shareSNS(context)
      ]
    );
  }
  Widget shareSNS(BuildContext context,){
    return Container(
      height : 64,
      padding: const EdgeInsets.all(4.0),
      child : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child : Row(
          children: [
            const SizedBox(width : 32,),
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/icons/user/Kakao.png",
                width : 64,height : 64,
              ),
            ),
            const SizedBox(width : 32,),
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/icons/user/Naver.png",
                width : 64,height : 64,
              ),
            ),
            const SizedBox(width : 32,),
            GestureDetector(
              onTap: (){},
              child: Image.asset(
                "assets/icons/user/Facebook.png",
                width : 64,height : 64,
              ),
            ),
            const SizedBox(width : 32,),
            GestureDetector(
              onTap: (){},
              child: SvgPicture.asset(
                "assets/icons/user/X.svg",
                width : 64,height : 64,
              ),
            ),
            const SizedBox(width : 32,),
            GestureDetector(
              onTap: (){},
              child: SvgPicture.asset(
                "assets/icons/user/Telegram.svg",
                width : 64,height : 64,
              ),
            ),
            const SizedBox(width : 32,),
          ],
        )
      )
    );
  }
}