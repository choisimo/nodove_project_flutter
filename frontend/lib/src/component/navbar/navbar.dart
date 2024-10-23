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
    this.actions,
  });
}

class NavbarTop extends StatefulWidget implements PreferredSizeWidget {
  final NavbarContent content;
  final bool centerTitle;
  final Color? color;
  final Color shadowColor;
  final double elevation;

  const NavbarTop(this.content,{
    super.key,
    this.centerTitle = false,
    this.color,
    this.shadowColor = Colors.transparent,
    this.elevation = 0.0
  });

  @override
  State<NavbarTop> createState() => _NavbarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(54);
}

class _NavbarTopState extends State<NavbarTop> {
  @override
  Widget build(BuildContext context) {
    return 
    (widget.centerTitle)?
    AppBar(
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: !widget.centerTitle,
      backgroundColor: widget.color??Theme.of(context).colorScheme.onPrimary,
      leading: widget.content.leading,
      title : widget.content.title??const SizedBox.shrink(),
      actions : widget.content.actions??[const SizedBox.shrink()],
      shadowColor : widget.shadowColor,
      elevation: widget.elevation,
    ):AppBar(
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: !widget.centerTitle,
      backgroundColor: widget.color??Theme.of(context).colorScheme.onPrimary,
      title : widget.content.title??const SizedBox.shrink(),
      actions : widget.content.actions??[const SizedBox.shrink()],
      shadowColor : widget.shadowColor,
      elevation: widget.elevation,
    );
  }
}

class BottomNavbar extends GetView<PageState>{
  const BottomNavbar({super.key});

  @override
  Widget build(context){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color : Theme.of(context).colorScheme.shadow,
            offset: RowContainer.offset,
            blurRadius: RowContainer.blurRadius
          )
        ],
      ),
      width : double.infinity,
      child: Obx(()=>
        BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor:Theme.of(context).colorScheme.onSurface,
          selectedItemColor: Theme.of(context).colorScheme.onPrimaryFixed,
          currentIndex: controller.index.value,
          onTap : controller.setIndex,
          unselectedLabelStyle: const TextStyle(fontSize: 14),
          selectedLabelStyle: const TextStyle(fontSize: 14),
          items: [
            BottomNavigationBarItem(
              label: "홈",
              icon: SvgPicture.asset(
                'assets/icons/navbar/home.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/home.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '메신저',
              icon: SvgPicture.asset(
                'assets/icons/navbar/msg.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/msg.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '피드',
              icon: SvgPicture.asset(
                'assets/icons/navbar/summarize.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/navbar/summarize.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '채용',
              icon: SvgPicture.asset(
                'assets/icons/user/company.svg',
                width : 16,
                height :16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/user/company.svg',
                width : 16,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
            ),
            BottomNavigationBarItem(
              label: '유저',
              icon: SvgPicture.asset(
                'assets/icons/navbar/user.svg',
                width : 24,
                height : 16,
                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn)
              ),
              activeIcon: SvgPicture.asset(
                  'assets/icons/navbar/user.svg',
                  width : 24,
                  height : 16,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      )
    );
  }
}

