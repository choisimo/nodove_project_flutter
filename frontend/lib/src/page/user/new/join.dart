import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/datetime.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/datasrc/auth.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
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

class JoinPage extends StatefulWidget {
  const JoinPage({super.key});

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;

  @override
  void initState(){
    currentPage = 0;
    pageController.addListener((){
      setState(() {
        currentPage = pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose(){
    con.resetJoinForm();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Navigator.of(context).pop()),
      title : const NavbarTitle("회원가입")
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result){
        print(didPop);
        if (!didPop&&mounted){
          if (currentPage >= 1){
            pageController.previousPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutQuad);
          } else {
            Future.delayed(const Duration(milliseconds: 300))
            .then((value)=>showDialog(
              context: context,
              builder:(context) => CustomDialog(
                title : const DialogStrTitle("회원가입을 취소할까요?"),
                content: const DialogStrContent("기입했던 내용이 모두 사라져요"),
                bottomBtns: [
                  DialogBottomBtn(
                    onPressed: (){
                      Get.back();
                      Get.back();
                    },
                    title: "취소",
                  )
                ],
              ),
            ));
          }
        }
      },
      child: GestureDetector(
        onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: NavbarTop(navbarOpt,centerTitle: true,),
          body : PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: pageWidget,
          ),
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              width : double.infinity,
              height : 96,
              child : Column(
                children: [
                  SizedBox(
                    width : double.infinity,
                    height : 32,
                    child: PageIndicator(
                      pageSize : pageWidget.length,
                      indicatorBtnColor : Theme.of(context).colorScheme.secondary
                    )
                  ),
                  FormCommitButton(
                    height: 54,
                    width : MediaQuery.of(context).size.width * 0.9,
                    title: "다음",
                    onPressed: ()=>pageController.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeInOutQuad)
                  ),
                ],
              )
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        )
      ),
    );
  }
}


class PageIndicator extends StatefulWidget {
  final int pageSize;
  final void Function(int index)? onIndicatorTap;
  final void Function(int index)? onDireBtnTap;
  final int initialPage;
  final double width;
  final double height;
  final Color indicatorBtnColor;
  final double indicatorDefaultOpac;
  final double indicatorActivedOpac;
  final int delay;
  const PageIndicator({
    super.key,
    this.pageSize = 1,
    this.onIndicatorTap,
    this.onDireBtnTap,
    this.initialPage = 0,
    this.width = 320,
    this.height = 16,
    this.indicatorBtnColor = Colors.white,
    this.indicatorDefaultOpac = 0.5,
    this.indicatorActivedOpac = 1,
    this.delay = 500,
  });

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  RxInt currentPage = 0.obs;

  @override
  void initState(){
    setState((){currentPage.value = widget.initialPage;});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: widget.width,
      ),
      height : widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children : [
          (widget.onDireBtnTap != null)?
          IconButton(
            onPressed: () async{
              await Future.delayed(Duration(milliseconds: widget.delay)).then((_){
                if (currentPage > 0){
                  setState((){currentPage -= 1;});
                  widget.onDireBtnTap?.call(currentPage.value);
                }
              });
            },
            icon: SvgPicture.asset(
              "assets/icons/common/left.svg",
              width: widget.height, height : widget.height,
            ),
          ):const SizedBox.shrink(),
          Container(
            constraints: BoxConstraints(
              maxWidth: widget.width / 2,
              maxHeight: widget.height
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder:(context, index) => Obx(()=>indicatorBtn(context, index , currentPage.value)),
              itemCount: widget.pageSize,
              scrollDirection: Axis.horizontal,
            ),
          ),
          (widget.onDireBtnTap != null)?
          IconButton(
            onPressed: () async{
              await Future.delayed(Duration(milliseconds: widget.delay)).then((_){
                if (currentPage < widget.pageSize - 1){
                  setState((){currentPage += 1;});
                  widget.onDireBtnTap?.call(currentPage.value);
                }
              });
            },
            icon: SvgPicture.asset(
              "assets/icons/common/right.svg",
              width: widget.height, height : widget.height,
            ),
          ):const SizedBox.shrink(),
        ]
      ),
    );
  }

  Widget indicatorBtn(BuildContext context,int index , int currentIndex){
    return GestureDetector(
      onTap: () async{
        await Future.delayed(Duration(milliseconds: widget.delay)).then((_){
          setState((){currentPage.value = index;});
          widget.onDireBtnTap?.call(currentPage.value);
        });
      },
      child: Opacity(
        opacity: (index == currentIndex)?
          widget.indicatorActivedOpac
          :widget.indicatorDefaultOpac,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color : widget.indicatorBtnColor,
          ),
        width : widget.height,
        height : widget.height,
        child : const SizedBox.shrink()
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
            const Text("생성할 아이디와 비밀번호를 적어주세요"),
            const SizedBox(height : 16),
            userIdForm(context),
            const SizedBox(height : 32),
            passwordForm(context),
          ],
        ),
      ),
    );
  }

  Widget passwordForm(BuildContext context){
    RegExp reg = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$");
    return CommonTextInput(
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
          if (value.isEmpty){
            return null;
          } else {
            return "8자 이상으로 적어주세요";
          }
        }
      },
    );
  }

  Widget userIdForm(BuildContext context){
    bool? loginValidate;
    return CommonTextInput(
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
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height : 32),
            const Text("나에 대한 정보를 작성해주세요"),
            const SizedBox(height : 16),
            CommonTextInput(
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
            CommonTextInput(
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
              child : CommonTextInput(
                initialValue: con.joinForm['email'],
                onChanged: (content) => con.setJoinForm("email",content),
                keyboard: TextInputType.emailAddress,
                placeholder: "이메일을 적어주세요"
              ),
            ),
            FormCommitButton(
              fontSize: 16,
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
              title : "코드 발송"
            ),
            const SizedBox(height : 16),
            CommonTextInput(
              maxLength: 8,
              enabled: sendMail,
              initialValue: con.joinForm['code'],
              onChanged: (content) => con.setJoinForm("code",content),
              filter: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              placeholder: (sendMail)?"메일로 온 코드를 적어주세요":"이메일을 적고 코드 발송을 눌러주세요"
            ),
            const SizedBox(height : 32),
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
              const ProfileSetting(),
              const SizedBox(height : 42),
              CommonTextInput(
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
                  SettingSwitch(
                    value: con.joinForm['isPrivate'],
                    onChanged: (b){
                      private = !private;
                      con.setJoinForm('isPrivate', private);
                    }
                  ),
                ],
              ),
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
              "입력하셨던 아이디와 비밀번호로 다시 로그인 해주세요",
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