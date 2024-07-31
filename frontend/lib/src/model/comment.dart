class CommentAll{
  final int totalItems;
  final int totalReplies;
  final int totalPages;
  final int currentPage;
  final List<Comment> comments;

  CommentAll({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.totalReplies,
    required this.comments,
  });

  factory CommentAll.fromJson(Map<String,dynamic> json){
    return CommentAll(
      totalItems : json['totalItems'],
      totalReplies : json['totalReplies'],
      totalPages : json['totalPages'],
      currentPage : json['currentPage'],
      comments : json['comments'].map<Comment>((json)=>
        Comment.fromJson(json)
      ).toList(),
    );
  }
  factory CommentAll.defaultState(){
    return CommentAll(
      totalItems : 0,
      totalReplies : 0,
      totalPages : 0,
      currentPage : 0,
      comments:[],
    );
  }
}

class Comment{
  final int commentId;
  final String comment;
  final String writer;
  final String createdAt;
  final List<dynamic>? replies;

  Comment({
    required this.commentId,
    required this.comment,
    required this.writer,
    required this.createdAt,
    this.replies,
  });

  factory Comment.fromJson(Map<String,dynamic> json){
    return Comment(
      commentId : json['commentId'],
      comment : json['comment'],
      writer : json['writer'],
      createdAt : json['createdAt'],
      replies : json['replies'],
    );
  }

  static defaultState() {}
}

class CommentWrite{
  final int post_id;
  final String comment;

  CommentWrite({
    required this.post_id,
    required this.comment,
  });
}