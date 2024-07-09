import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nodove_flutter/UI/Feed/feedrow.dart';
import 'package:nodove_flutter/UI/navbar.dart';
import 'package:nodove_flutter/model/feed.dart';

class FeedPage extends StatefulWidget{
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: navbarTop(context),
      bottomNavigationBar: navbarBottom(context),
      body : const FeedList(categoryId: 16)
    );
  }
}

class FeedList extends StatefulWidget {
  final int categoryId;
  const FeedList({super.key , required this.categoryId});

  @override
  State<FeedList> createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  late Future<List<Feed>> feedList;
  
  Dio dio = Dio();

  @override
  void initState(){
    super.initState();
    feedList = getFeedData();
  }
  
  Future<List<Feed>> getFeedData() async{
    late List<Feed> list;
    final int categoryId = widget.categoryId;
    try{
      var response = await dio.get("https://gcp.nodove.com/api/getPostByList/0?pageSize=5&categoryId=$categoryId");
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refreshData(),
      child : SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                  return FeedRow(props : data);
                }
              );
            }
          },
        )
      )
    );
  }
}