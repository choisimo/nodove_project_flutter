import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/page/list/mainlist.dart';
import 'package:nodove_flutter/src/page/list/taglist.dart';
import 'package:nodove_flutter/src/page/messenger/room.dart';
import 'package:nodove_flutter/src/page/notification/noti.dart';
import 'package:nodove_flutter/src/page/user/login.dart';
import 'package:nodove_flutter/src/page/user/userpage.dart';
import 'package:nodove_flutter/src/page/cate/cate.dart';
import 'package:nodove_flutter/src/page/list/feedlist.dart';
import 'package:nodove_flutter/src/page/view/view.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

void main(){
  runApp(const MyApp());
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
      initialRoute: '/',
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
  const NotiPage(key : Key("notiPage")),
  const UserPage(key : Key('userPage')),
];

class _MyHomeState extends State<MyHome>{
  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      body : 
      Obx((){
        return PopScope(
          canPop: (PageState.page.index.value == 0),
          onPopInvoked: (b){
            if (!b){
              PageState.page.setIndex(0);
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
      title : navbarTitle(context,"메인",20),
      actions : [
        navbarCommonBtn(
          context,
          "assets/icons/navbar/search.svg",
          cb : (){},
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false),
      body: RefreshIndicator(
        onRefresh: ()=>Future.delayed(const Duration(milliseconds: 1000),()=>setState((){})),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              CollectedVList(
                url : "${Url.apiUrl}${Url.feedList}",
                opt : "pageSize=$maxSize&categoryId=$companyPage",
                title : "대학홍보"
              ),
              CollectedVList(
                url : "${Url.apiUrl}${Url.feedList}",
                opt : "pageSize=$maxSize&categoryId=$univPage",
                title : "창업정보"
              ),
            ]
          ),
        ),
      ),
    );
  }
}