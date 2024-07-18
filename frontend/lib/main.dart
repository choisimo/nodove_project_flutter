import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/interceptor.dart';
import 'package:nodove_flutter/func/token.dart';
import 'package:nodove_flutter/src/user/login.dart';
import 'package:nodove_flutter/src/view/cate/cate.dart';
import 'package:nodove_flutter/src/view/normal/feedlist.dart';
import 'package:nodove_flutter/src/view/page/page.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
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
        GetPage(name : "/cate/:page" , page : ()=>const CatePage()),
      ],
    );
  }
}

class MyHome extends StatefulWidget{
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}
List<Widget> page = [
  const MainPage(key : Key("fuck")),
  const SizedBox.shrink(),
  const CatePage(),
  const SizedBox.shrink(),
  SafeArea(
    child: TextButton(onPressed: (){
      const storage = FlutterSecureStorage();
      storage.delete(key: 'userToken');
      storage.delete(key: 'cookie');
    },
    child : Text("캐시 삭제")
    ),
  ),
];

class _MyHomeState extends State<MyHome>{
  final PageState index = PageState();

  @override
  Widget build(BuildContext context){
    Get.put(PageState());
    
    return Scaffold(
      bottomNavigationBar: const BottomNavbar(),
      body : Obx(()=>page[PageState.page.index.value]),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 3;

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
      body: const SizedBox.shrink(),
    );
  }
}