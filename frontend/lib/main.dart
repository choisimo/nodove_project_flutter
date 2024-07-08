import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nodove_flutter/model/feed.dart';
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
  //var 
  late Future<List<Feed>> feedList;
  Dio dio = Dio();

  @override
  void initState(){
    super.initState();
    feedList = getFeedData();
  }
  
  Future<List<Feed>> getFeedData() async{
    late List<Feed> list;
    try{
      var response = await dio.get("https://gcp.nodove.com/api/getPostByList/0?pageSize=5&categoryId=3");
      list =  response.data
                .map<Feed>((json)=> Feed.fromJson(json))
                .toList();
    } catch (e){
      print(e);
    }

    return list;
  }

  Future<void> refreshData() async{
    feedList = getFeedData();
    setState((){});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text("야발"),
        backgroundColor: Colors.blue,
      ),
      body : RefreshIndicator(
        onRefresh: () => refreshData(),
        child : SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child : FutureBuilder<List<Feed>>(
            future: feedList,
            builder: (BuildContext con, AsyncSnapshot snapshot) {
              if (!snapshot.hasData){
                return const Center(child: Text("로딩중"));
              } else{
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext cont,int index){
                    var data = snapshot.data[index];
                    return feedrow(props : data);
                  }
                );
              }
            },
          )
        )
        )
    );
  }
  Widget feedrow({required Feed props}){
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
                child : Text("제목 : ${props.title}"))
            ],
          ),
        ),
      ],
    );
  }
}