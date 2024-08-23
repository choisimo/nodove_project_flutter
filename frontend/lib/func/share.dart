import 'package:flutter/services.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

void copyLink(String link,{Function? callback}) async{
  await Clipboard.setData(ClipboardData(text: link));
  final data = await Clipboard.getData(Clipboard.kTextPlain);
  callback?.call();
  showToast((data?.text != null)?"복사되었습니다":"복사에 실패했습니다");
}