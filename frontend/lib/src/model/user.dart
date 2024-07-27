class User{
  String userId;
  String profile;
  String role;
  String nickname;
  List<dynamic> certifications;
  List<dynamic> groups;
  List<dynamic> hashtags;
  dynamic userActivities;
  dynamic birthDate;
  bool private;

  User({
    required this.userId,
    required this.profile,
    required this.role,
    required this.nickname,
    required this.certifications,
    required this.groups,
    required this.hashtags,
    required this.userActivities,
    required this.birthDate,
    required this.private,
  });

  factory User.fromJson(Map<String,dynamic> json) {
    return User(
      userId : json['userId'],
      profile : json['profile'],
      role : json['role'],
      nickname : json['nickname'],
      certifications: json['certifications'],
      groups: json['groups'],
      hashtags: json['hashtags'],
      userActivities: json['userActivities'],
      birthDate: json['birthDate'],
      private: json['private']
    );
  }

  factory User.defaultState() {
    return User(
      userId : '',
      profile : '',
      role : '',
      nickname : '',
      certifications: [],
      groups: [],
      hashtags: [],
      userActivities: [],
      birthDate: 0,
      private: false,
    );
  }
}