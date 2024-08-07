import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';

class NavbarContent{
  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;

  NavbarContent({
    this.title,
    this.leading,
    this.actions
  });
}

PreferredSizeWidget navbarTop(context,NavbarContent content,bool centerTitle){
  return 
  (centerTitle)?
  AppBar(
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      leading: content.leading??const SizedBox.shrink(),
      title : content.title??const SizedBox.shrink(),
      actions : content.actions??[const SizedBox.shrink()],
      shape : Border(
        bottom: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary)
      ),
  )
  :
  AppBar(
      centerTitle: centerTitle,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      title : content.title??const SizedBox.shrink(),
      actions : content.actions??[const SizedBox.shrink()],
      shape : Border(
        bottom: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary)
      ),
  );
}

class BottomNavbar extends GetView<PageState>{
  const BottomNavbar({super.key});

  @override
  Widget build(context){
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary))
      ),
      width : double.infinity,
      child: Obx(()=>
        BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:Theme.of(context).colorScheme.onSurface,
          currentIndex: controller.index.value,
          onTap : controller.setIndex,
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          selectedLabelStyle: const TextStyle(fontSize: 14),
          items: [
            BottomNavigationBarItem(
              label: "홈",
              icon: SvgPicture.asset(
                'assets/icons/navbar/home.svg',
                width : 21,
                height : 21,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/home.svg',
                width : 21,
                height : 21,
                colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '메신저',
              icon: SvgPicture.asset(
                'assets/icons/navbar/msg.svg',
                width : 21,
                height : 21,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/msg.svg',
                width : 21,
                height : 21,
                colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '피드',
              icon: SvgPicture.asset(
                'assets/icons/navbar/menu.svg',
                width : 18,
                height : 18,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/menu.svg',
                width : 18,
                height : 18,
                colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '알림',
              icon: SvgPicture.asset(
                'assets/icons/navbar/alert.svg',
                width : 24,
                height :21,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/alert.svg',
                width : 24,
                height : 21,
                colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '유저',
              icon: SvgPicture.asset(
                'assets/icons/navbar/user.svg',
                width : 24,
                height : 21,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn)
              ),
              activeIcon: SvgPicture.asset(
                  'assets/icons/navbar/user.svg',
                  width : 24,
                  height : 21,
                  colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      )
    );
  }
}

