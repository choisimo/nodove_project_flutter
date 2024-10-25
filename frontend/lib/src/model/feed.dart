
class Feed{
  final int id;
  final String title;
  final String writerNick;
  final String writerUserId;
  final String writerProfile;
  final int writerId;
  final String? caption;
  final String? content;
  final String? status;
  final String createdAt;
  final String updatedAt;
  final dynamic likeCount;
  final dynamic commentCount;
  final List<dynamic> hashtags;
  final List<dynamic> imageLinks;
  final bool private;

  Feed({
    required this.id,
    required this.title,
    required this.writerNick,
    required this.writerUserId,
    required this.writerProfile,
    required this.writerId,
    this.caption,
    this.content,
    this.status,
    required this.createdAt,
    required this.updatedAt,
    this.likeCount = 0,
    this.commentCount = 0,
    required this.hashtags,
    required this.imageLinks,
    required this.private,
  });

  factory Feed.fromJson(Map<String,dynamic> json){
    return Feed(
      id : json['id'],
      title : json['title'],
      writerNick : json['writerNick'],
      writerUserId : json['writerUserId'],
      writerProfile : json['writerProfile'],
      writerId : json['writerId'],
      caption : json['caption'],
      content : json['content'],
      status : json['status'],
      createdAt : json['createdAt'],
      updatedAt : json['updatedAt'],
      likeCount : json['likeCount'],
      commentCount : json['commentCount'],
      hashtags : json['hashtags'],
      imageLinks : json['imageLinks'],
      private : json['private'],
    );
  }

  factory Feed.defaultState(){
    return Feed(
      id : 0,
      title : "",
      writerNick : "",
      writerUserId : "",
      writerProfile : "",
      writerId : 0,
      caption : "",
      content : "",
      status : "",
      createdAt : "",
      updatedAt : "",
      likeCount : 0,
      commentCount : 0,
      hashtags : [],
      imageLinks : [],
      private : false,
    );
  }
}

class FeedWrite{
  final String title;
  final String content;
  final String caption;
  final bool isPrivate;
  final String status;
  final List<String> tags;
  final List<String> imageLinks;
  final int postCategory;

  FeedWrite({
    required this.title,
    this.content = "",
    this.caption = "",
    this.isPrivate = false,
    this.status = "published",
    required this.tags,
    required this.imageLinks,
    required this.postCategory,
  });

  factory FeedWrite.defaultState(){
    return FeedWrite(
      title : "",
      tags : [],
      imageLinks: [],
      postCategory: 0,
    );
  }
}

class Pos{
  final String name;
  final int lat;
  final int lng;
  Pos({
    required this.name,
    required this.lat,
    required this.lng
  });
}

class PageUrl{
  final String url;
  final String opt;

  PageUrl({
    required this.url,
    this.opt = ""
  });
}