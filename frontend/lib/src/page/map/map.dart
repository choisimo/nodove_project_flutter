import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/state/user.dart';

class MapPage extends StatefulWidget {
  final RecruitFeed? feed;
  final Widget? bottomWidget;
  const MapPage({
    super.key,
    this.feed,
    this.bottomWidget
  });

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.bottomSheet(
        const MapViewBottom(),
        isDismissible: false,
        barrierColor: Colors.transparent,

      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed : ()=>Navigator.of(context).pop()),
      title : const NavbarTitle("매칭"),
    );
    return Scaffold(
      key : key,
      appBar: NavbarTop(navbarOpt, centerTitle : true),
      body : MapView(
        feed : widget.feed,
      ),
    );
  }
}

class MapView extends StatefulWidget {
  final RecruitFeed? feed;
  const MapView({
    super.key,
    this.feed
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late final NaverMapController controller;
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  @override
  void initState(){
    super.initState();
  }

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
            target : NLatLng(
              37.5666805,
              126.9784147
            ),
            zoom: 17
          ),
          indoorEnable: true,
          locationButtonEnable: false,
          consumeSymbolTapEvents: false,
        ),
        onMapReady :(c) async{
          controller = c;
          mapControllerCompleter.complete(controller);
          await controller.addOverlay(currentMarker);
          Set<NMarker>? markers = widget.feed?.region.map((Pos pos)=>NMarker(id: pos.name, position: NLatLng(pos.lat, pos.lon))).toSet();
          if (markers != null) await controller.addOverlayAll(markers);
        },
    ),
  );
  }
}

class MapViewBottom extends StatefulWidget {
  final Widget? bottomWidget;
  const MapViewBottom({super.key,this.bottomWidget});

  @override
  State<MapViewBottom> createState() => _MapViewBottomState();
}

class _MapViewBottomState extends State<MapViewBottom> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Container(
      width : double.infinity,
      height : MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.bottomWidget??const SizedBox.shrink()
        ],
      )
    );
  }
}

class MapPreview extends StatefulWidget {
  const MapPreview({super.key});

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late final NaverMapController controller;
  final NMarker currentMarker = NMarker(id: "currentPos", position: NLatLng(UserState().position.value.lat, UserState().position.value.lon));

  @override
  Widget build(BuildContext context) {
    final maxSize = MediaQuery.of(context).size.width;
    return SizedBox(
      width : maxSize,
      height : maxSize,
      child: NaverMap(
        options : const NaverMapViewOptions(
          mapType: NMapType.basic,
          indoorEnable: true,
          locationButtonEnable: false,
          consumeSymbolTapEvents: false,
        ),
        onMapReady :(c) async{
          controller = c;
          await controller.addOverlay(currentMarker);
        },
      ),
    );
  }
}