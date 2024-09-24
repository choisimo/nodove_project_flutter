import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/graphic/painter.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/user.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/page/post/write.dart';
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
      actions : [
        nextBtn(
          context,
          displayText: "수정",
          callback: (){}
        ),
      ]
    );
    return GestureDetector(
      onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: navbarTop(context,navbarOpt, false),
        body : const EditUser(),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
  final userState = Get.put(UserState());
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
    final TextStyle statusStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    );
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    );
    return customRefreshIndicator(
      context,
      onRefresh: ()=>refreshState(),
      child: Obx((){
        final user = _con.userInfo.value;
        return SizedBox(
          width : maxWidth,
          child: SingleChildScrollView(
            child: Column(
              children : [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "유저",
                      style: TextStyle(
                        color : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                ClipPath(
                  clipper: const CustomClip(
                    vertical: 96
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                        maxHeight: 240,
                    ),
                    width : maxWidth * 0.8,
                    padding: const EdgeInsets.only(left: 8, right: 8, bottom: 12, top: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimaryFixed
                    ),
                    child : commonTextInput(
                      context,
                      keyboard: TextInputType.multiline,
                      maxLines: null,
                      style : statusStyle,
                      key : "상태메세지",
                      initialValue: "상태메세지",
                      placeholder: "나에 대한 한마디를 추가해보세요",
                      placeholderStyle: statusStyle
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    
                  },
                  child : profileSetting(
                    context,
                    current : user.profile,
                    onUpdated: (image){

                    }
                  )
                ),
                const SizedBox(height : 8),
                SizedBox(
                  width : maxWidth * 0.9,
                  child: commonTextInput(
                    context,
                    key : user.nickname,
                    initialValue: user.nickname,
                    placeholder: "닉네임을 적어주세요",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width : double.infinity,
                  height : 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "정보",
                      style: TextStyle(
                        color : Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
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
                    borderColor : Theme.of(context).colorScheme.shadow
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
                        color : Theme.of(context).colorScheme.onSurface
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
                  width : maxWidth * 0.9,
                  child : commonTextInput(
                    context,
                    keyboard: TextInputType.phone,
                    maxLength: 17,
                    filter: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], //
                    placeholder: "전화번호를 적어주세요"
                  ),
                ),
                const SizedBox(height : 8),
                SizedBox(
                  width : maxWidth * 0.9,
                  child : commonTextInput(
                    context,
                    keyboard: TextInputType.emailAddress,
                    maxLength: 17,
                    placeholder: "이메일을 적어주세요"
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width : double.infinity,
                  height : 0.5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurface
                  ),
                ),
              ]
            ),
          ),
        );
      })
    );
  }
}