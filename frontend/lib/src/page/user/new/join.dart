import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/page/user/new/login.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';

List<Widget> pageWidget = [
  const JoinForm(),
  const JoinFormPrivateInfo(),
  const JoinFormProfile(),
  const JoinCompleted(),
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
    bool canPop = false;
    NavbarContent navbarOpt = NavbarContent(
      actions : [
        NextBtn(
          displayText: (page<pageWidget.length - 2)?"다음":"제출",
          callback: (){
            if (page<pageWidget.length - 2){
              Get.to(
                ()=>JoinPage(page: nextPage,),
                preventDuplicates: false
              );
            } else{
              con.postJoin().then((res){
                if (res){
                  Get.off(()=>JoinPage(page : nextPage));
                } else{
                  showToast("가입에 실패했어요..");
                }
              });
            }
          }
        ),
      ]
    );
    return PopScope(
      onPopInvoked: (value){
        if (page == 0){
          canPop = false;
          if (!value){
            showDialog(
              context: context,
              builder: (BuildContext context){
                return customDialog(
                  title : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DialogCloseBtn(
                        onPressed: ()=>Get.back(),
                      ),
                    ],
                  ),
                  content: const Column(
                    children: [
                      Text("가입을 취소할까요?"),
                      Text("적었던 내용이 모두 사라집니다"),
                    ],
                  ),
                  bottomBtns: [
                    TextButton(
                      onPressed: (){
                        canPop = true;
                        Get.offAll(()=>const LoginPage());
                      },
                      child: const Text("뒤로가기")
                    )
                  ]
                );
              }
            );
          }
        } else {
          canPop = true;
          Get.back();
        }
      },
      canPop: canPop,
      child: GestureDetector(
        onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: NavbarTop(navbarOpt, centerTitle : false),
          body : SingleChildScrollView(
            child:pageWidget[page],
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
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
            userIdForm(context),
            const SizedBox(height : 32),
            passwordForm(context)
          ],
        ),
      ),
    );
  }

  Widget passwordForm(BuildContext context){
    RegExp reg = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
    return commonTextInput(
      context,
      initialValue: con.joinForm['userPw'],
      onChanged: (content) => con.setJoinForm("userPw",content),
      placeholder: "비밀번호",
      obscureText : true,
      validator: (value) {
        if (value!.length>8){
          if (reg.hasMatch(value)){
            return null;
          } else {
            return "비밀번호는 영문과 숫자, 특수문자로 설정해주세요";
          }
        } else {
          return "8자 이상으로 적어주세요";
        }
      },
    );
  }

  Widget userIdForm(BuildContext context){
    bool? loginValidate;
    return commonTextInput(
      context,
      initialValue: con.joinForm['userId'],
      onChanged: (content) async{
        bool result = await con.isUserIdDuplicate(content);
        if (result){
          setState((){
            loginValidate = false;
          });
          con.setJoinForm("userId",content);
        } else {
          setState((){
            loginValidate = true;
          });
        }
      },
      placeholder : "아이디",
      validator : (value){
        if (loginValidate == true){
          return null;
        } else if (loginValidate == false) {
          return "사용 할 수 없는 아이디에요";
        } else {
          return null;
        }
      }
    );
  }
}
class JoinFormPrivateInfo extends StatefulWidget {
  const JoinFormPrivateInfo({super.key});

  @override
  State<JoinFormPrivateInfo> createState() => _JoinFormPrivateInfoState();
}

class _JoinFormPrivateInfoState extends State<JoinFormPrivateInfo> {
  String profile = "";
  bool sendMail = false;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    );
    final maxWidth = MediaQuery.of(context).size.width;
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: RowContainer.radius,
      border : Border.all(
        color: Theme.of(context).colorScheme.onSurface,
        width: 0.5
      )
    );
    return Obx(()=>Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height : 32),
            const Text("나에 대한 정보를 작성해주세요"),
            const SizedBox(height : 16),
            commonTextInput(
              context,
              initialValue: con.joinForm['userName'],
              onChanged: (content) => con.setJoinForm("userName",content),
              placeholder: "성명"
            ),
            const SizedBox(height : 16),
            SelectedDateButton(
              title : "생년월일 : ",
              date : 
              con.joinForm['birthDate']
              ??getMilisecondToDateTime(con.joinForm['birthDate']),
              mode : "Date",
              onSubmitted: (dt){
                con.setJoinForm("birthDate",dt);
                Get.back();
              },
            ),
            const SizedBox(height : 16),
            PopupMenuButton(
              initialValue: con.joinForm['gender'],
              color : Theme.of(context).colorScheme.onPrimary,
              shadowColor: Colors.transparent,
              offset: const Offset(0,42),
              shape : TooltipShape(
                vertical : 72,
                borderColor : Theme.of(context).colorScheme.shadow
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    onTap : ()=>con.setJoinForm("gender",'M'),
                    child: const Text(
                      "남",
                      style: TextStyle(
                        fontSize : 18,
                      ),
                    )
                  ),
                  PopupMenuItem(
                    onTap : ()=>con.setJoinForm("gender",'F'),
                    child: const Text(
                      "여",
                      style: TextStyle(
                        fontSize : 18,
                      ),
                    )
                  ),
                  PopupMenuItem(
                    onTap : ()=>con.setJoinForm("gender",'O'),
                    child: const Text(
                      "그 외",
                      style: TextStyle(
                        fontSize : 18,
                      ),
                    )
                  )
                ];
              },
              child : Container(
                padding : const EdgeInsets.all(8),
                decoration: boxDecoration,
                child : Text("성별 : ${
                  (con.joinForm['gender'] == "M")?"남":
                  (con.joinForm['gender'] == "F")?"여":
                  "그 외"
                }")
              )
            ),
            const SizedBox(height : 16),
            commonTextInput(
              context,
              keyboard: TextInputType.phone,
              maxLength: 17,
              initialValue: con.joinForm['phone'],
              onChanged: (content) => con.setJoinForm("phone",content),
              filter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], //
              placeholder: "전화번호를 적어주세요"
            ),
            const SizedBox(height : 16),
            Container(
              padding: const EdgeInsets.all(4),
              width : maxWidth * 0.9,
              child : Row(
                children: [
                  Expanded(
                    child: commonTextInput(
                      context,
                      initialValue: con.joinForm['email'],
                      onChanged: (content) => con.setJoinForm("email",content),
                      keyboard: TextInputType.emailAddress,
                      placeholder: "이메일을 적어주세요"
                    ),
                  ),
                  SizedBox(
                    width : 72,
                    child: TextButton(
                      onPressed: () async{
                        if (con.joinForm['email'] != null){
                          await AuthDataSrc().postCode(con.joinForm['email']).then(
                            (res){
                              if (res){
                                setState((){
                                  sendMail = true;
                                });
                              } else{
                                showToast("메일 전송에 실패했어요..");
                              }
                            }
                          );
                        }
                      },
                      style : TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed
                      ),
                      child : const Text("코드 발송")
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height : 16),
            (sendMail)?commonTextInput(
              context,
              maxLength: 8,
              enabled: sendMail,
              initialValue: con.joinForm['code'],
              onChanged: (content) => con.setJoinForm("code",content),
              filter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ], //
              placeholder: "메일로 온 코드를 적어주세요"
            ):const SizedBox.shrink(),
          ],
        ),
      ),
    ));
  }
}


class JoinFormProfile extends StatelessWidget {
  const JoinFormProfile({super.key});

  
  @override
  Widget build(BuildContext context) {
    bool private = false;
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
    return Obx(()=>
      Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height : 32),
              const Text("나만의 프로필을 작성해주세요"),
              const SizedBox(height : 16),
              profileSetting(
                context,

              ),
              const SizedBox(height : 42),
              commonTextInput(
                context,
                initialValue: con.joinForm['userNick'],
                onChanged: (content) => con.setJoinForm("userNick",content),
                placeholder: "닉네임"
              ),
              const SizedBox(height : 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "비공개 계정인가요?",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  Switch(
                    value: con.joinForm['isPrivate'],
                    onChanged: (b){
                      private = !private;
                      con.setJoinForm('isPrivate', private);
                    }
                  ),
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}


class JoinCompleted extends StatelessWidget {
  const JoinCompleted({super.key});

  
  @override
  Widget build(BuildContext context) {
    String profile = "";
    bool private = false;
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
            const Text(
              "가입이 완료되었어요",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            const Text(
              "입력하셨던 아이디와 비밀번호로 다시 로그인하시면 돼요",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            TextButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary
              ),
              onPressed: ()=>Get.off(()=>const LoginPage()),
              child : const Text("뒤로 가기")
            )
          ],
        ),
      ),
    );
  }
}