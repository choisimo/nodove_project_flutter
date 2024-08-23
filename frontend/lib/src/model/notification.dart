class Noti {
  final int commentId;
  final int sender;
  final String senderNickname;
  final int receiver;
  final String receiverNickname;
  final int postId;
  final String postTitle;
  final String postContent;
  final String commentContent;
  final String alarmDate;

  Noti({
    required this.commentId,
    required this.sender,
    this.senderNickname = "",
    required this.receiver,
    this.receiverNickname = "",
    required this.postId,
    this.postTitle = "",
    this.postContent = "",
    this.commentContent = "",
    required this.alarmDate
  });

  factory Noti.fromJson(Map<String,dynamic> json){
    return Noti(
      commentId: json['commentId'],
      sender : json['sender'],
      senderNickname: json['senderNickname'],
      receiver: json['receiver'],
      receiverNickname: json['receiverNickname'],
      postId: json['postId'],
      postTitle: json['postTitle'],
      postContent: json['postContent'],
      commentContent: json['commentContent'],
      alarmDate: json['alarmDate']
    );
  }
}