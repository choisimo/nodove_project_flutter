class Hashtag{
  final int id;
  final String tag;

  Hashtag({
    this.id = 0,
    required this.tag
  });

  factory Hashtag.fromJson(Map<String,dynamic> json){
    return Hashtag(
      tag : json['tag'],
    );
  }

  static defaultState() {}
}