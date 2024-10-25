import 'package:nodove_flutter/src/model/recruit.dart';
class TempFeed{
  final List<RecruitFeed> feed = [
    RecruitFeed(
      id : "fjdsika3j20j",
      title : "게시글 테스트",
      images : [],
      content : "게시글 테스트입니등",
      url : "",
      createdAt : "2024-09-14 14:00:00",
      from : "2024-09-15 14:00:00",
      to : "2024-09-17 14:00:00",
      hashtags : ["개발","프론트엔드"],
      region: [],
      user: Company(
        id : "fduskfdkl",
        name : "유저",
        userId : "test",
        rating : 0,
        pos : Pos(
          lat: 35.4930,
          long : 129.4930
        ),
        createdAt: "",
        founded: "",
      )
    ),
    RecruitFeed(
      id : "fjdsika3j20j",
      title : "게시글 테스트",
      hashtags : ["개발","프론트엔드"],
      images : [],
      content : "게시글 테스트입니등",
      url : "",
      createdAt : "2024-09-14 14:00:00",
      from : "2024-09-15 14:00:00",
      to : "2024-09-17 14:00:00",
      region: [],
      user: Company(
        id : "fduskfdkl",
        userId : "test",
        name : "유저",
        rating : 0,
        pos : Pos(
          lat: 35.4930,
          long : 129.4930
        ),
        createdAt: "",
        founded: "",
      )
    ),
  ];
}