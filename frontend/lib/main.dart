import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_share/kakao_flutter_sdk_share.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/community/commulist.dart';
import 'package:nodove_flutter/src/page/list/other/mainlist.dart';
import 'package:nodove_flutter/src/page/messenger/room/room.dart';
import 'package:nodove_flutter/src/page/recruit/main.dart';
import 'package:nodove_flutter/src/page/setting/setting.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/user/new/main.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/vmodel/binding.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/user.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initialize();
  
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<void> _initialize() async{
  await NaverMapSdk.instance.initialize(
    clientId: "g69k6e2jkr",
    onAuthFailed: (ex) => print("네이버 로그인 실패$ex"),
  );
  KakaoSdk.init(
      nativeAppKey: '05ac89039fc5530d6aecefd15965ffab',
      javaScriptAppKey: '6ca98145dce6e237061047f91555b459',
  );
  final Pos pos = await locationPermission();
  UserState().setPos(pos);
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context){

    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('ko',"KO")
      ],
      home : const LoginMainPage(),
      theme : Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      navigatorKey: GlobalContext.navigatorState,
      initialRoute: '/',
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => child!,
            )
          ],
        );
      },
      getPages: [
        GetPage(name: "/", page: ()=>const MainPage()),
        GetPage(name : "/view/:page" , page : ()=>const FeedPage()),
        GetPage(name : "/setting/:page" , page : ()=>const SettingPage())
      ],
      initialBinding: InitViewModel(),
    );
  }
}


class MyHome extends StatefulWidget{
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}
List<Widget> pages = [
  const MainPage(key : Key("mainPage")),
  const RoomPage(key : Key('messengerPage')),
  const CommuListPage(),
  const RecruitMainPage(key : Key("RecruitMainPage")),
  const UserPage(key : Key('userPage')),
];
class _MyHomeState extends State<MyHome>{
  late List<GlobalKey<NavigatorState>> navigatorKeyList;
  int selectedIndex = 0;

  @override
  void initState() {
    navigatorKeyList =
        List.generate(pages.length, (index) => GlobalKey<NavigatorState>());
    super.initState();
  }

  void systemBackButtonPressed(bool didPop,_) {
    if (navigatorKeyList[PageState.page.index.value].currentState!.canPop()) {
      navigatorKeyList[PageState.page.index.value]
          .currentState!
          .pop(navigatorKeyList[PageState.page.index.value].currentContext);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }


  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    return Scaffold(
      key: navigatorKeyList[PageState.page.index.value],
      bottomNavigationBar: const BottomNavbar(),
      extendBody: true,
      body : 
      Obx((){
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: systemBackButtonPressed,
          child: IndexedStack(
            index: PageState.page.index.value,
            children: pages.map((page){
              return Navigator(
                onGenerateRoute: (_){
                  return MaterialPageRoute(
                    builder: (builder){
                      return page;
                    },
                  );
                },
              );
            }).toList(),
          ),
        );
      }),
    );
  }
}