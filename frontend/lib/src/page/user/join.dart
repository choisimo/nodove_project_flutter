import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';

List<Widget> pageWidget = [
  const JoinForm(),
  const JoinFormPrivateInfo()
];
UserInfoModel con = Get.put(UserInfoModel());

class JoinPage extends StatelessWidget {
  final int page;
  const JoinPage({
    super.key,
    required this.page
  });

  @override
  Widget build(BuildContext context) {
    int nextPage = page + 1;
    NavbarContent navbarOpt = NavbarContent(
      actions : [
        nextBtn(
          context,
          displayText: (page<pageWidget.length - 1)?"다음":"제출",
          callback: (){
            if (page<pageWidget.length - 1){
              Get.to(
                ()=>JoinPage(page: nextPage,),
                preventDuplicates: false
              );
            } else{
              
            }
          }
        ),
      ]
    );
    return GestureDetector(
      onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: navbarTop(context,navbarOpt, false),
        body : pageWidget[page],
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class JoinForm extends StatefulWidget {
  const JoinForm({super.key});

  @override
  State<JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    );
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: RowContainer.radius,
      border : Border.all(
        color: Theme.of(context).colorScheme.onSurface,
        width: 0.5
      )
    );
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height : 32),
            const Text("만들고 싶은 아이디와 비밀번호를 적어주세요"),
            const SizedBox(height : 16),
            Container(
              decoration: boxDecoration,
              padding: const EdgeInsets.all(4),
              child : TextFormField(
                initialValue: con.joinForm['userId'],
                onChanged: (content) => con.setJoinForm("userId",content),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "아이디",
                  hintStyle: textStyle
                ),
              ),
            ),
            const SizedBox(height : 32),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: boxDecoration,
              child : TextFormField(
                initialValue: con.joinForm['userPw'],
                onChanged: (content) => con.setJoinForm("userPw",content),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: "",
                  hintText: "비밀번호",
                  hintStyle: textStyle
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class JoinFormPrivateInfo extends StatefulWidget {
  const JoinFormPrivateInfo({super.key});

  @override
  State<JoinFormPrivateInfo> createState() => _JoinFormPrivateInfoState();
}

class _JoinFormPrivateInfoState extends State<JoinFormPrivateInfo> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}