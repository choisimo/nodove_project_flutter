import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/graphic/painter.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/setting.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
import 'package:nodove_flutter/src/page/user/member/userpage.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/user.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Navigator.of(context).pop(),),
      actions : [
        NextBtn(
          displayText: "수정",
          onPressed: (){}
        ),
      ]
    );
    return GestureDetector(
      onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body : const EditUser(),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final UserInfoModel _con = Get.put(UserInfoModel());
  final UserState userState = Get.find();
  late Future<User> userInfo;
  final TextEditingController controller = TextEditingController();

  @override
  void initState(){
    refreshState();
    super.initState();
  }

  Future<void> refreshState() async{
    String myid = userState.id.value;
    await _con.getUserInfo(myid);
    final user = _con.userInfo.value;
    controller.text = user.nickname;
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    return CustomRefreshIndicator(
      onRefresh: ()=>refreshState(),
      child: Obx((){
        final user = _con.userInfo.value;
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary
          ),
          width : maxWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                const SettingTitle(
                  title : "프로필"
                ),
                SettingContent(
                  children: [
                    const SizedBox(height : 16),
                    ProfileSetting(
                      current : user.profile,
                      onUpdated: (image){

                      }
                    ),
                    const SizedBox(height : 8),
                    SizedBox(
                      width : maxWidth * 0.8,
                      child: CommonTextInput(
                        bColor: Theme.of(context).colorScheme.secondary,
                        initialValue: user.nickname,
                        placeholder: "닉네임을 적어주세요",
                      ),
                    ),
                    const SizedBox(height : 16),
                  ]
                ),
                const SettingTitle(
                  title : "인적사항"
                ),
                SettingContent(
                  children: [
                    const SizedBox(height : 16),
                    SelectedDateButton(
                      title : "생년월일 : ",
                      date : 
                      _con.editInfo['birthDate']
                      ??getMilisecondToDateTime(_con.userInfo.value.birthDate),
                      mode : "Date",
                      onSubmitted: (dt){
                        _con.editUserInfo("birthDate",dt);
                        Get.back();
                      },
                    ),
                    const SizedBox(height : 8),
                    PopupMenuButton(
                      color : Theme.of(context).colorScheme.onPrimary,
                      shadowColor: Colors.transparent,
                      offset: const Offset(0,42),
                      shape : TooltipShape(
                        vertical : 92,
                        borderColor : Theme.of(context).colorScheme.secondary
                      ),
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem(
                            onTap : ()=>_con.editUserInfo("gender",'M'),
                            child: const Text(
                              "남",
                              style: TextStyle(
                                fontSize : 18,
                              ),
                            )
                          ),
                          PopupMenuItem(
                            onTap : ()=>_con.editUserInfo("gender",'F'),
                            child: const Text(
                              "여",
                              style: TextStyle(
                                fontSize : 18,
                              ),
                            )
                          ),
                          PopupMenuItem(
                            onTap : ()=>_con.editUserInfo("gender",'O'),
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
                        decoration: BoxDecoration(
                          borderRadius: RowContainer.radius,
                          border : Border.all(
                            width : 0.5,
                            color : Theme.of(context).colorScheme.secondary
                          )
                        ),
                        child : Text("성별 : ${
                          (_con.editInfo['gender'] == "M")?"남":
                          (_con.editInfo['gender'] == "F")?"여":
                          "그 외"
                        }")
                      )
                    ),
                    const SizedBox(height : 8),
                    SizedBox(
                      width : maxWidth * 0.8,
                      child : CommonTextInput(
                        keyboard: TextInputType.phone,
                        bColor: Theme.of(context).colorScheme.secondary,
                        maxLength: 17,
                        filter: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ], //
                        placeholder: "전화번호를 적어주세요"
                      ),
                    ),
                    const SizedBox(height : 8),
                    SizedBox(
                      width : maxWidth * 0.8,
                      child : CommonTextInput(
                        keyboard: TextInputType.emailAddress,
                        maxLength: 17,
                        bColor: Theme.of(context).colorScheme.secondary,
                        placeholder: "이메일을 적어주세요"
                      ),
                    ),
                    const SizedBox(height : 16),
                  ],
                ),
                const SettingTitle(title: "계정",),
                SettingContent(children: [
                  const SettingRow(
                    title : Text(
                      "비밀번호 변경",
                      style: TextStyle(
                        fontSize : 18,
                      ),
                    )
                  ),
                  SettingRow(
                    onClick: ()=>showUserDialog(context),
                    title : Text(
                      "로그아웃",
                      style: TextStyle(
                        fontSize : 18,
                        color: Theme.of(context).colorScheme.error
                      ),
                    )
                  ),    
                ])    
              ]
            ),
          ),
        );
      })
    );
  }
}