import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/view/etc/etc.dart';
import 'package:nodove_flutter/src/view/messenger/messenger.dart';
import 'package:nodove_flutter/src/view/user/login.dart';
import 'package:nodove_flutter/src/view/user/userpage.dart';
import 'package:nodove_flutter/src/view/cate/cate.dart';
import 'package:nodove_flutter/src/view/normal/feedlist.dart';
import 'package:nodove_flutter/src/view/page/page.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

void main(){
  runApp(const MyApp());
}
/*

*/
class MyApp extends StatelessWidget{
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context){

    return GetMaterialApp(
      home : const LoginPage(),
      theme : Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: ()=>const MainPage()),
        GetPage(name: "/list/:page" , page : ()=>const FeedListPage()),
        GetPage(name : "/view/:page" , page : ()=>FeedPage()),
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
  const MsgPage(key : Key('messengerPage')),
  const CatePage(page: 0,key : Key('listPage')),
  const UserPage(id: 'bocchi',key : Key('userPage')),
  const EtcPage(key : Key("etcPage")),
];

class _MyHomeState extends State<MyHome>{
  final PageState index = PageState();

  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      body : Obx((){
        return IndexedStack(
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
  int univPage = 15;
  int companyPage = 16;
  int maxSize = 7;

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(context,"메인",20),
      actions : [
        searchBtn(context),
        alertBtn(context)
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false),
      body: RefreshIndicator(
        onRefresh: ()=>Future.delayed(Duration(milliseconds: 1000),()=>setState((){})),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              CollectedVList(
                url : "${Url.apiUrl}${Url.feedList}",
                opt : "pageSize=$maxSize&categoryId=$companyPage"
              ),
              CollectedVList(
                url : "${Url.apiUrl}${Url.feedList}",
                opt : "pageSize=$maxSize&categoryId=$univPage"
              ),
            ]
          ),
        ),
      ),
    );
  }
}