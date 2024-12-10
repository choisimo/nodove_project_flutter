import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/list/feed/normal/feedsetting.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';

class NavbarContent {
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

  const NavbarTop(this.content,
      {super.key,
      this.centerTitle = false,
      this.color,
      this.shadowColor = Colors.transparent,
      this.elevation = 0.0});

  @override
  State<NavbarTop> createState() => _NavbarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(RowContainer.paddingSize);
}

class _NavbarTopState extends State<NavbarTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: false,
      backgroundColor:
          widget.color ?? Theme.of(context).colorScheme.onPrimary,
      leading: widget.content.leading,
      title: widget.content.title ?? const SizedBox.shrink(),
      actions: widget.content.actions ?? [const SizedBox.shrink()],
      shadowColor: widget.shadowColor,
      elevation: widget.elevation,
      iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimaryFixed),
    );
  }
}

class SliverNavbarTop extends StatefulWidget implements PreferredSizeWidget {
  final NavbarContent content;
  final bool centerTitle;
  final Color? color;
  final Color shadowColor;
  final double elevation;

  const SliverNavbarTop(this.content,
      {super.key,
      this.centerTitle = true,
      this.color,
      this.shadowColor = Colors.transparent,
      this.elevation = 0.0});

  @override
  State<SliverNavbarTop> createState() => _SliverNavbarTopState();

  @override
  Size get preferredSize => const Size.fromHeight(54);
}

class _SliverNavbarTopState extends State<SliverNavbarTop> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: widget.centerTitle,
      automaticallyImplyLeading: false,
      backgroundColor:
          widget.color ?? Theme.of(context).colorScheme.onPrimary,
      leading: widget.content.leading,
      title: widget.content.title,
      actions: widget.content.actions,
      shadowColor: widget.shadowColor,
      elevation: widget.elevation,
      iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimaryFixed),
    );
  }
}

class BottomNavbar extends GetView<PageState> {
  const BottomNavbar({super.key});

  @override
  Widget build(context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(RowContainer.bottomBarRadius),
          topRight: Radius.circular(RowContainer.bottomBarRadius)),
      child: Obx(
        () => BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          currentIndex: controller.index.value,
          onTap: controller.setIndex,
          unselectedLabelStyle: TextStyle(
              fontSize: 12, color: Theme.of(context).colorScheme.primary),
          selectedLabelStyle: TextStyle(
              fontSize: 12, color: Theme.of(context).colorScheme.primary),
          items: [
            BottomNavigationBarItem(
              label: "홈",
              icon: CustomSvg('navbar/home.svg',
                  width: 18,
                  height: 18,
                  iconColor: Theme.of(context).colorScheme.secondary),
              activeIcon: const CustomSvg(
                'navbar/home.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '메신저',
              icon: CustomSvg('navbar/msg.svg',
                  width: 18,
                  height: 18,
                  iconColor: Theme.of(context).colorScheme.secondary),
              activeIcon: const CustomSvg(
                'navbar/msg.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '블록',
              icon: CustomSvg('navbar/summarize.svg',
                  width: 18,
                  height: 18,
                  iconColor: Theme.of(context).colorScheme.secondary),
              activeIcon: const CustomSvg(
                'navbar/summarize.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '채용',
              icon: CustomSvg('user/company.svg',
                  width: 18,
                  height: 18,
                  iconColor: Theme.of(context).colorScheme.secondary),
              activeIcon: const CustomSvg(
                'user/company.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '유저',
              icon: CustomSvg(
                'navbar/user.svg',
                width: 24,
                height: 18,
                iconColor: Theme.of(context).colorScheme.secondary,
              ),
              activeIcon: const CustomSvg(
                'navbar/user.svg',
                width: 24,
                height: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeedBottomNavbar extends StatelessWidget {
  final Categories cate;
  const FeedBottomNavbar({super.key, required this.cate});

  void onTap(BuildContext context, int index) {
    print(index);
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatePage(page: cate.categoryId),
                settings: RouteSettings(
                  arguments: {"backName": cate.categoryName},
                )));
        break;
      case 2:
        break;
      case 3:
        Get.to(() => const FeedSettingPage());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(RowContainer.bottomBarRadius),
            topRight: Radius.circular(RowContainer.bottomBarRadius)),
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) => onTap(context, index),
          items: const [
            BottomNavigationBarItem(
              label: '구독',
              icon: CustomSvg(
                'common/subscribe.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '카테고리',
              icon: CustomSvg(
                'navbar/summarize.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '해시태그',
              icon: CustomSvg(
                'navbar/hashtag.svg',
                width: 18,
                height: 18,
              ),
            ),
            BottomNavigationBarItem(
              label: '설정',
              icon: CustomSvg(
                'common/setting.svg',
                width: 18,
                height: 18,
              ),
            ),
          ],
        ));
  }
}
