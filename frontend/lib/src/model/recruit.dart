import 'package:geolocator/geolocator.dart';

class RecruitFeed{
  String id;
  String title;
  List<dynamic> images;
  String? content;
  String url;
  String createdAt;
  String? updatedAt;
  String from;
  String to;
  List<dynamic> hashtags;
  List<dynamic> region;
  Company user;

  RecruitFeed({
    required this.id,
    required this.title,
    this.images = const [],
    this.content = "",
    required this.url,
    required this.createdAt,
    this.updatedAt,
    required this.from,
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
      images : json['images'],
      content : json['content'],
      url : json['url'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      from: json['from'],
      to: json['to'],
      hashtags: json['tag'],
      region: json['region'],
      user: Company(
        id : user['_id'],
        name : user['name'],
        userId : user['userId'],
        rating : user['rating'],
        profile : user['profile'],
        createdAt: user['createdAt'],
        founded: user['founded'],
        pos: Pos(
          lat: pos['lat'],
          long: pos['long']
        ),
      )
    );
  }

  factory RecruitFeed.defaultState(){
    return RecruitFeed(
      id : "",
      title : "",
      images : [],
      content : "",
      url : "",
      createdAt: "",
      updatedAt: "",
      from: "",
      to : "",
      hashtags: [],
      region: [],
      user: Company(
        id : "",
        name : "",
        rating : 0,
        userId : "",
        profile : "",
        createdAt: "",
        founded: "",
        pos: Pos(
          lat: 0,
          long: 0,
        ),
      )
    );
  }
}

class Pos{
  double lat;
  double long;

  Pos({
    required this.lat,
    required this.long
  });
}

class Company{
  String id;
  String name;
  int rating;
  String? profile;
  String userId;
  Pos pos;
  String createdAt;
  String founded;

  Company({
    required this.id,
    required this.name,
    required this.rating,
    required this.userId,
    this.profile = "/asset/images/logo.png",
    required this.pos,
    required this.createdAt,
    required this.founded
  });
}