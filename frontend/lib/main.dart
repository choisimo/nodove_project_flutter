import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/UI/Feed/feedlist.dart';
import 'package:nodove_flutter/UI/Feed/feedrow.dart';
import 'package:nodove_flutter/UI/navbar.dart';

import 'package:nodove_flutter/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home : const MyHome(),
      theme : Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.system,
    );
  }
}

class MyHome extends StatefulWidget{
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: navbarTop(context),
      bottomNavigationBar: navbarBottom(context),
      body : const MainPage(key : Key('fuck'))
    );
  }
}
//FeedList(categoryId: 3,)
/*

*/
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>Navigator.of(context).push(
        MaterialPageRoute(builder: (_)=>const FeedPage()
        ),
      ), child: Text("이동"),
    );
  }
}