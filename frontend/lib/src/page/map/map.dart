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
      showBottomSheet(
        context: context,
        builder:(context) => const MapViewBottom(),
        enableDrag: false,
        showDragHandle : true
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
    NavbarContent navbarOpt = NavbarContent(
      leading : BackBtn(onPressed : (){
        Get.back();
        Navigator.of(context).pop();
      }),
      title : const NavbarTitle("매칭"),
    );
    return Scaffold(
      key : key,
      appBar: NavbarTop(navbarOpt, centerTitle : true),
      body : MapView(
        region : widget.feed?.region,
      ),
    );
  }
}

class MapView extends StatefulWidget {
  final List<Pos>? region;
  const MapView({
    super.key,
    this.region
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

  return SizedBox(
    height : maxHeight,
    child: NaverMap(
      options : NaverMapViewOptions(
          mapType: NMapType.basic,
          initialCameraPosition: NCameraPosition(
            target : NLatLng(
              UserState.page.position.value.lat,
              UserState.page.position.value.lon
            ),
            zoom: 17
          ),
          indoorEnable: true,
          locationButtonEnable: true,
          consumeSymbolTapEvents: false,
          rotationGesturesEnable : false,
          scrollGesturesEnable : true,
          tiltGesturesEnable : false,
          zoomGesturesEnable : true,
          stopGesturesEnable : false,
        ),
        onSymbolTapped: (symbolInfo) {
          
        },
        onMapReady :(c) async{
          controller = c;
          mapControllerCompleter.complete(controller);
          Set<NMarker>? markers = widget.region?.map((Pos pos)=>
          NMarker(id: pos.name, position: NLatLng(pos.lat, pos.lon))).toSet();
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
      height : MediaQuery.of(context).size.height * 0.3,
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
  final Pos? position;
  final Function(NPoint, NLatLng)? onClick;
  const MapPreview({super.key,
    this.position,
    this.onClick
  });

  @override
  State<MapPreview> createState() => _MapPreviewState();
}

class _MapPreviewState extends State<MapPreview> {
  late final NaverMapController controller;
  
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
            rotationGesturesEnable : false,
            scrollGesturesEnable : false,
            tiltGesturesEnable : false,
            zoomGesturesEnable : false,
            stopGesturesEnable : false,
          ),
          onMapTapped : widget.onClick,
          onMapReady :(c) async{
            controller = c;
            final NMarker currentMarker = NMarker(
            id: "currentPos", position: NLatLng(
              widget.position?.lat??UserState().position.value.lat,
              widget.position?.lon??UserState().position.value.lon
            ));
            await controller.addOverlay(currentMarker);
          },
        ),
    );
  }
}