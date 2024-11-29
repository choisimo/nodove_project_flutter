
import 'package:nodove_flutter/src/model/user.dart';

class RecruitFeed{
  String id;
  String title;
  List<dynamic> imageLinks;
  String? content;
  String url;
  String createdAt;
  String? updatedAt;
  String to;
  List<dynamic> hashtags;
  List<Pos> region;
  Company user;

  RecruitFeed({
    required this.id,
    required this.title,
    this.imageLinks = const [],
    this.content = "",
    required this.url,
    required this.createdAt,
    this.updatedAt,
    required this.to,
    required this.user,
    this.hashtags = const [],
    this.region = const []
  });

  factory RecruitFeed.fromJson(Map<String,dynamic> json){
    final user = json['user'];
    final pos = user['position'];
    return RecruitFeed(
      id : json['_id'],
      title : json['title'],
      imageLinks : json['imageLinks'],
      content : json['content'],
      url : json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      to: json['to'],
      hashtags: json['tag'],
      region: json['region'].map<Pos>((a)=>Pos(
        lat: a['lat'],
        lon: a['lon'],
        name : a['name']
      )).toList(),
      user: Company(
        id : user['_id'],
        name : user['name'],
        rating : user['rating'],
        profile : user['profile'],
        createdAt: user['createdAt'],
        founded: user['founded'],
        headcount : user['headcount'],
        header : user['header'],
        description: user['description'],
        pos: Pos(
          lat: pos['lat'],
          lon: pos['long'],
          name : pos['name']
        ),
      )
    );
  }

  factory RecruitFeed.defaultState(){
    return RecruitFeed(
      id : "",
      title : "",
      imageLinks : [],
      content : "",
      url : "",
      createdAt: "",
      updatedAt: "",
      to : "",
      hashtags: [],
      region: [
        Pos(
          lat: 0,
          lon: 0,
          name : ""
        )
      ],
      user: Company(
        id : "",
        name : "",
        rating : 0,
        profile : "",
        createdAt: "",
        founded: "",
        pos: Pos(
          lat: 0,
          lon: 0,
          name : ""
        ),
      )
    );
  }
}

class Pos{
  double lat;
  double lon;
  String name;

  Pos({
    required this.lat,
    required this.lon,
    this.name = ""
  });
}

class Company{
  String id;
  String name;
  int rating;
  String? profile;
  Pos pos;
  String createdAt;
  String founded;
  int headcount;
  String header;
  String description;
  List<User> editor;

  Company({
    required this.id,
    required this.name,
    required this.rating,
    this.profile = "/asset/images/logo.png",
    required this.pos,
    required this.createdAt,
    required this.founded,
    this.description = "",
    this.headcount = 0,
    this.header = "",
    this.editor = const [],
  });
}