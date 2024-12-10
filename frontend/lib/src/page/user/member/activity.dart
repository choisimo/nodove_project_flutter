import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';

class UserActivityPage extends StatefulWidget {
  const UserActivityPage({super.key});

  @override
  State<UserActivityPage> createState() => _UserActivityPageState();
}

class _UserActivityPageState extends State<UserActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserActivityView(),
    );
  }
}

class UserActivityView extends StatelessWidget {
  const UserActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return const UserInfoColumn(
      children: [
        UserInfoTitle("자격증"),
        UserCertificationView(),
        UserInfoTitle("점수"),
        UserScoreView(),
        UserInfoTitle("채용"),
        UserRecruitView(),
      ]
    );
  }
}

class UserCertificationView extends StatelessWidget {
  const UserCertificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UserScoreView extends StatelessWidget {
  const UserScoreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class UserRecruitView extends StatelessWidget {
  const UserRecruitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}