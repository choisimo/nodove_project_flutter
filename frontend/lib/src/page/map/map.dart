import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

Widget mapPreview(BuildContext context) {
  late final NaverMapController controller;
  final Completer<NaverMapController> mapControllerCompleter = Completer();
  final maxWidth = MediaQuery.of(context).size.width;
  final currentMarker = NMarker(id: "currentPos", position: const NLatLng(37.5666805, 126.9784147));

  return SizedBox(
    width : maxWidth,
    height : maxWidth,
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