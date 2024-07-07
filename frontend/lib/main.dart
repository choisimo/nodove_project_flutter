import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home : MyHome()
    );
  }
}

class MyHome extends StatefulWidget{
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>{
  var feedList = [{"id":75,"title":"대 슨 황","writer":"Mr L","writerId":6,"caption":"TEMP","content":"\u003Cp\u003E대슨황께서 오븐에서 서버를 꺼내는 모습이다\u003C/p\u003E","status":"draft","createdAt":"2024-07-06T14:17:10","updatedAt":"2024-07-06T14:17:10","likeCount":0,"commentCount":2,"hashtags":["젠슨황","엔비디아"],"imageLinks":["https://file.gcp.nodove.com/attach/images/f0bfa9e5-3b9a-42c4-b545-66e6fd0ed9e7_IMG_9508.jpeg"],"private":false},{"id":70,"title":"새벽 5시","writer":"Mr L","writerId":6,"caption":"TEMP","content":"\u003Cp\u003E\u003Cbr\u003E\u003C/p\u003E","status":"published","createdAt":"2024-06-19T05:24:49","updatedAt":"2024-06-19T05:24:49","likeCount":0,"commentCount":11,"hashtags":["새벽"],"imageLinks":["https://file.gcp.nodove.com/attach/images/637024dd-c3b9-45b5-81ab-02c7dc9e66ac_IMG_9480.jpeg"],"private":false},{"id":59,"title":"글쓰기 테스트중입니다","writer":"Mr L","writerId":6,"caption":"TEMP","content":"\u003Cp\u003E글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다글쓰기 테스트중입니다\u003C/p\u003E","status":"published","createdAt":"2024-06-03T20:13:59","updatedAt":"2024-06-16T00:13:49","likeCount":0,"commentCount":1,"hashtags":["글쓰기 테스트"],"imageLinks":[],"private":false},{"id":58,"title":"i5-7200u 7zip benchmark","writer":"관리자","writerId":9,"caption":"TEMP","content":"\u003Cp\u003Esudo apt-get install wget\u003C/p\u003E\u003Cp\u003Ewget https://www.7-zip.org/a/7z2406-linux-x64.tar.xz\u003C/p\u003E\u003Cp\u003Etar -xf 7z2406-linux-x64.tar.xz\u003C/p\u003E\u003Cp\u003Esudo +x 7zzs\u003C/p\u003E\u003Cp\u003E./7zzs b\u003C/p\u003E\u003Cp\u003E\u003Cbr\u003E\u003C/p\u003E","status":"draft","createdAt":"2024-06-02T17:37:28","updatedAt":"2024-06-02T17:37:28","likeCount":0,"commentCount":2,"hashtags":["리눅스","벤치마크","7zip"],"imageLinks":["https://file.gcp.nodove.com/attach/images/917beefa-963e-40db-887f-a9c1682a4007_스크린샷 2024-06-02 17-30-26.png"],"private":false},{"id":56,"title":"nn","writer":"관리자","writerId":9,"caption":"TEMP","content":"\u003Cp\u003Ennnnnn\u003C/p\u003E","status":"draft","createdAt":"2024-05-28T22:51:15","updatedAt":"2024-05-28T22:51:15","likeCount":0,"commentCount":1,"hashtags":["huh","huh cat","cat of huh"],"imageLinks":["https://file.gcp.nodove.com/attach/images/ed215dab-0c15-41c8-aae6-58c65eb8157f__91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg"],"private":false}];
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text("야발"),
        backgroundColor: Colors.blue,
      ),
      body : ListView.builder(
        itemCount : feedList.length,
        itemBuilder: (BuildContext con,int index) {
          return feedrow(
            title : feedList[index]['title'] as String,
          );
        },
      )
    );
  }
  Widget feedrow({String title = ""}){
    final maxwidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width : maxwidth,
          height :300,
          child: Column(
            children: [
              SizedBox(
                width : maxwidth,
                height : 150 ,
                child : Text("제목 : $title"))
            ],
          ),
        ),
      ],
    );
  }
}