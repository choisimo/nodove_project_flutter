import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/src/component/menu/submenu.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(callback : ()=>Navigator.of(context).pop()),
      title : const NavbarTitle("내 위치"),
      actions: [
        IconButton(
          onPressed: (){
            
          },
          icon: SvgPicture.asset(
            "assets/icons/navbar/menu.svg",
            width : 16 , height : 16,
            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          )
        )
      ]
    );
    return Scaffold(
      key : key,
      appBar: NavbarTop(navbarOpt, centerTitle : false),
      body : const MapView(),
      bottomSheet: const MapViewBottom(),
    );
  }
}

class MapView extends StatefulWidget {
  const MapView({
    super.key,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final NaverMapController controller;
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  @override
  Widget build(BuildContext context){
    late final NaverMapController controller;
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  final maxHeight = MediaQuery.of(context).size.height;
  final currentMarker = NMarker(id: "currentPos", position: const NLatLng(37.5666805, 126.9784147));

  return SizedBox(
    height : maxHeight,
    child: NaverMap(
      options : const NaverMapViewOptions(
          mapType: NMapType.basic,
          initialCameraPosition: NCameraPosition(
            target : NLatLng(37.5666805, 126.9784147),
            zoom: 13
          ),
          indoorEnable: true,
          locationButtonEnable: false,
          consumeSymbolTapEvents: false,
        ),
        onMapReady :(c) async{
          controller = c;
          mapControllerCompleter.complete(controller);
          await controller.addOverlay(currentMarker);
        },
    ),
  );
  }
}

class MapViewBottom extends StatefulWidget {
  const MapViewBottom({super.key});

  @override
  State<MapViewBottom> createState() => _MapViewBottomState();
}

class _MapViewBottomState extends State<MapViewBottom> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    late TabController tabController =
    TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    final maxHeight = MediaQuery.of(context).size.height;
    return BottomSheet(
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      builder:(context) => 
      SizedBox(
        width : double.infinity,
        height : MediaQuery.of(context).size.height * 0.3,
        child : Column(
          mainAxisSize: MainAxisSize.min,
          children: [

          ],
        )
      ),
      onClosing: () {},
    );
  }
}

Widget mapPreview(BuildContext context) {
  late final NaverMapController controller;
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  final maxSize = MediaQuery.of(context).size.width;
  final currentMarker = NMarker(id: "currentPos", position: const NLatLng(37.5666805, 126.9784147));
  return SizedBox(
    width : maxSize,
    height : maxSize,
    child: NaverMap(
      options : const NaverMapViewOptions(
          mapType: NMapType.basic,
          initialCameraPosition: NCameraPosition(
            target : NLatLng(37.5666805, 126.9784147),
            zoom: 13
          ),
          indoorEnable: true,
          locationButtonEnable: false,
          consumeSymbolTapEvents: false,
        ),
        onMapReady :(c) async{
          controller = c;
          mapControllerCompleter.complete(controller);
          await controller.addOverlay(currentMarker);
        },
    ),
  );
}