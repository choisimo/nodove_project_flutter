import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/state/url.dart';

void CopyLink(int page) async{
  await Clipboard.setData(ClipboardData(text: "${Url.serverUrl}${Url.clientList}?page=$page"));
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  print(data?.text??"복사 실패");
}