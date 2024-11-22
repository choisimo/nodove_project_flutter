import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/chatting.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/model/user.dart';

class TempFeed extends GetxController{
  final RxBool isFetching = false.obs;
  RxList<RecruitFeed> feed = [
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
  ].obs;

  RxList<Feed> feedList = [
    Feed(
      id: 0,
      title : "테스트1",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/logo.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 3,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 4,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 5,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 6,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: ["개발","프론트엔드"],
      imageLinks: [
        "https://file.career-block.com/attach/images/2a5d5602-fe59-47e9-b1d3-4f3d066fc11e.jpg"
      ],
      private : false,
    ),
  ].obs;

  RxList<Categories> catelist = [
    Categories(
      categoryId : 1,
      categoryName : "공모전",
      categoryDescription : "행사와 이벤트 등의 대외적인 활동에 대한 정보를 다룹니다",
      categoryImage : "",
      depth : 1,
      parentCategoryName: "",
      children : []
    ),
    Categories(
      categoryId : 2,
      categoryName : "경진대회",
      categoryDescription : "기관이나 학교의 경진대회에 대한 정보가 올라옵니다",
      categoryImage : "",
      depth : 1,
      parentCategoryName: "",
    ),
    Categories(
      categoryId : 2,
      categoryName : "기타 대외활동",
      categoryImage : "",
      categoryDescription : "그 외 경험 해보지 못한 대외활동을 다룹니다",
      depth : 1,
      parentCategoryName: "",
    )
  ].obs;

  Rx<Categories> currentCate = Categories(
    categoryId : 2,
    categoryName : "테스트1",
    categoryDescription : "테스트1",
    depth : 1,
    parentCategoryName: "",
    children : [
      Categories(
      categoryId : 4,
      categoryName : "테스트2",
      categoryDescription : "테스트2",
      parentCategoryName: "테스트1",
      depth : 2,
      children: [
        Categories(
          categoryId : 8,
          categoryName : "테스트3",
          categoryDescription : "테스트3",
          depth : 3,
          parentCategoryName: "테스트2",
        )
      ]
    )
    ]
  ).obs;

  List<Room> roomlist = [
    Room(
      roomId : "룸 ID",
      user: ChatUser(
        userId: 'admin',
        username: '관리자',
        profile : "",
        lastOnline: null,
        id : "admin"
      ),
      lastMsg: ChatContent(
        chatId: 0,
        content : "마지막 메세지",
        createdAt: "2024-11-14 12:12:12"
      ),
      roomName: "관리자",
      profile : ""
    )
  ];

  Rx<User> userInfo = User(
    userId: 'careerblock',
    profile: 'https://file.career-block.com/attach/images/logo.jpg',
    role : "소속 없음",
    nickname : "커리어블록",
    certifications: [],
    groups: [],
    hashtags: ["개발","프론트엔드"],
    userActivities: null,
    birthDate: DateTime.now().microsecond,
    private : false
  ).obs;

  Rx<Feed> content = Feed(
    id: 0,
    title : "테스트1",
    writerNick: "커리어블록",
    writerId : 6,
    writerUserId: "careerblock",
    writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
    createdAt : "2024-11-14 12:12:12",
    updatedAt: "2024-11-14 12:12:12",
    content : "<p>테스트</p>",
    hashtags: [],
    imageLinks: [],
    private : false,
  ).obs;

  RxList<Comment> commentList = [
      Comment(
        commentId: 0,
        comment: "댓글 테스트1",
        writer: "커리어블록",
        createdAt: "2024-11-14 11:16:00"
      )
    ].obs;

  RxList<Feed> community = [
    Feed(
      id: 1,
      title : "테스트2",
      writerNick: "커리어블록",
      writerId : 6,
      writerUserId: "careerblock",
      writerProfile: "https://file.career-block.com/attach/images/logo.jpg",
      createdAt : "2024-11-14 12:12:12",
      updatedAt: "2024-11-14 12:12:12",
      content : "<p>테스트</p>",
      hashtags: [],
      imageLinks: [],
      private : false,
    ),
  ].obs;
}