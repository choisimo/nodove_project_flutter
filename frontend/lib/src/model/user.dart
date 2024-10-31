class User{
  String userId;
  String profile;
  String role;
  String nickname;
  List<dynamic> certifications;
  List<dynamic> groups;
  List<dynamic> hashtags;
  dynamic userActivities;
  int birthDate;
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

class LoginDto{
  final String userId;
  final String password;

  LoginDto({
    required this.userId,
    required this.password,
  });
}

class JoinDto{
    final String userId;
    final String userPw;
    final String userName;
    final String nickname;
    final String phone;
    final String email;
    final String birthDate;
    final String gender;
    final bool isPrivate;
    final String profile;
    final String code;

    JoinDto({
      required this.userId,
      required this.userPw,
      required this.userName,
      required this.nickname,
      required this.phone,
      required this.email,
      required this.birthDate,
      required this.gender,
      required this.isPrivate,
      required this.code,
      this.profile = "https://zrr.kr/iPHf"
    });
}