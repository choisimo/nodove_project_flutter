import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/state/color.dart';

PreferredSizeWidget navbarTop(context){
  return AppBar(
      centerTitle: true,
      shape: Border(
        bottom: BorderSide(color: Theme.of(context).colorScheme.secondary,width: 1)
      ),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,

      leading: IconButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        icon : SvgPicture.asset(
          'assets/icons/common/left.svg',
          width : 20,
          height : 20,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
        )
      ),
      title : Text(
        "피드",
        style : TextStyle(
          color : Theme.of(context).colorScheme.onBackground ,
          fontSize : 16
        )
      ),
      actions : <Widget>[
        IconButton(
          onPressed: (){},
          icon : SvgPicture.asset(
            'assets/icons/navbar/search.svg',
            width : 20,
            height : 20,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
          )
        ),
        IconButton(
        onPressed: (){},
        icon : SvgPicture.asset(
          'assets/icons/navbar/alert.svg',
          width : 20,
          height : 20,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
        )
      ),
    ]
  );
}

Widget navbarBottom(context){
  return Container(
    width : double.infinity,
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: Theme.of(context).colorScheme.secondary,width: 1))
    ),
    child: BottomNavigationBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor:Theme.of(context).colorScheme.onBackground,
      items: [
        BottomNavigationBarItem(
          label: "홈",
          icon: SizedBox(
            width : 24,
            height : 24,
            child : SvgPicture.asset(
              'assets/icons/navbar/home.svg',
              width : 24,
              height : 21,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
            ),
          ),
          activeIcon: SvgPicture.asset(
            'assets/icons/navbar/home.svg',
            width : 24,
            height : 21,
            colorFilter: ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '메신저',
          icon: SizedBox(
            width : 21,
            height : 21,
            child : SvgPicture.asset(
              'assets/icons/navbar/msg.svg',
              width : 21,
              height : 21,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
            ),
          ),
          activeIcon: SvgPicture.asset(
            'assets/icons/navbar/msg.svg',
            width : 24,
            height : 21,
            colorFilter: ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '피드',
          icon: SizedBox(
            width : 21,
            height : 21,
            child : SvgPicture.asset(
              'assets/icons/navbar/menu.svg',
              width : 18,
              height : 18,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn),
            ),
          ),
          activeIcon: SvgPicture.asset(
            'assets/icons/navbar/menu.svg',
            width : 18,
            height : 18,
            colorFilter: ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
          ),
        ),
        BottomNavigationBarItem(
          label: '유저',
          icon: SizedBox(
            width : 21,
            height : 21,
            child : SvgPicture.asset(
              'assets/icons/navbar/user.svg',
              width : 24,
              height : 21,
              colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onBackground,BlendMode.srcIn)
            ),
          ),
          activeIcon: SvgPicture.asset(
              'assets/icons/navbar/user.svg',
              width : 24,
              height : 21,
              colorFilter: ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
          ),
        ),
        const BottomNavigationBarItem(
          icon: Text(
            '•••',
            style : TextStyle(fontWeight: FontWeight.bold)
          ),
          label: '더보기',
          activeIcon: Text(
            '•••',
            style : TextStyle(fontWeight: FontWeight.bold,color: CommonStyle.first)
          ),
        ),
      ],
    ),
  );
}