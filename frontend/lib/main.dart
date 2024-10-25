import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/page/list/other/mainlist.dart';
import 'package:nodove_flutter/src/page/list/other/taglist.dart';
import 'package:nodove_flutter/src/page/messenger/room/room.dart';
import 'package:nodove_flutter/src/page/notification/noti.dart';
import 'package:nodove_flutter/src/page/recruit/list.dart';
import 'package:nodove_flutter/src/page/user/new/login.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/list/feed/feedlist.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

void main() async{
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await _initializeMap();
  
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

Future<void> _initializeMap() async{
  await NaverMapSdk.instance.initialize(
    clientId: "g69k6e2jkr",
    onAuthFailed: (ex) => print("네이버 로그인 실패$ex"),
  );
}

Future<void> requestLocationPermission() async{
  LocationPermission permission = await Geolocator.checkPermission();
  
  if (permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied){
      return;
    }
  }
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
      home : const LoginPage(),
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
        GetPage(name: "/list/:page" , page : ()=>const FeedListPage()),
        GetPage(name : "/view/:page" , page : ()=>FeedPage()),
        GetPage(name : "/tag/:tag" , page : ()=>const TagListPage())
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
  const FeedMainPage(key : Key('listPage')),
  const RecruitListPage(key : Key("RecruitPage")),
  const UserPage(key : Key('userPage')),
];
class _MyHomeState extends State<MyHome>{
  late List<GlobalKey<NavigatorState>> navigatorKeyList;

  @override
  void initState() {
    navigatorKeyList =
        List.generate(pages.length, (index) => GlobalKey<NavigatorState>());
    super.initState();
  }

  Future<void> popFunc() async {
    navigatorKeyList[PageState.page.index.value].currentState!.maybePop();
  }
  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    bool canPop = true;
    return Scaffold(
      key: navigatorKeyList[PageState.page.index.value],
      bottomNavigationBar: const BottomNavbar(),
      body : 
      Obx((){
        return PopScope(
          canPop: canPop,
          onPopInvoked: (b){
            if (Navigator.of(context,rootNavigator: true) == Navigator.of(context)
            ){
              final index = PageState.page.index.value;
              if (index == 0){
                setState((){canPop = true;});
              } else {
                setState((){canPop = false;});
                PageState.page.setIndex(0);
              }
              
            } else {
              setState((){canPop = true;});
            }
          },
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

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int univPage = 3;
  int companyPage = 2;
  int maxSize = 7;

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : const NavbarTitle("메인"),
      actions : [
        NavbarCommonBtn(
          "assets/icons/navbar/alert.svg",
          onClick : ()=>Navigator.of(context).push(
            MaterialPageRoute(builder: (_)=>const NotiPage(key : Key("notiPage")))
          ),
          width : 18, height : 18
        ),
        NavbarCommonBtn(
          "assets/icons/navbar/search.svg",
          onClick : (){},
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(
        navbarOpt,
        centerTitle : false,
      ),
      body: RefreshIndicator(
        onRefresh: ()=>Future.delayed(const Duration(milliseconds: 1000),()=>setState((){})),
        child: const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              
            ]
          ),
        ),
      ),
    );
  }
}