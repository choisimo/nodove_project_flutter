import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddRoomModel con = Get.put(AddRoomModel());
    RoomListModel lcon = Get.put(RoomListModel());
    NavbarContent navbarOpt = NavbarContent(
      actions: [
        nextBtn(
          context,
          displayText: "시작",
          callback : () async{
            final result = await con.addRoom();
            Navigator.pop(context);
            if (result){
              await lcon.getRoomList();
            }
          }
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false,),
      body : const AddRoomView()
    );
  }
}

class AddRoomView extends StatefulWidget {
  const AddRoomView({super.key});

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> {
  @override
  Widget build(BuildContext context) {
    AddRoomModel con = Get.put(AddRoomModel());
    bool private = false;
    Color textColor = Theme.of(context).colorScheme.onSurface;
    TextStyle textStyle = TextStyle(
      color: textColor,
      fontSize : 14,
      fontWeight: FontWeight.bold
    );
    return SingleChildScrollView(
      child: SizedBox(
        width : double.infinity,
        child: LayoutBuilder(
          builder: (context,constraint) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height : 8),
                profileSetting(
                  context,
                  current : con.addRoomForm['profileImage'],
                  onUpdated: (String image) => con.setAddRoom('profileImage', image)
                ),
                const SizedBox(height : 8),
                Text(
                  "대화 주제",
                  style: textStyle
                ),
                SizedBox(
                  width : constraint.maxWidth * 0.9,
                  child: commonTextInput(
                    context,
                    placeholder: "대화 주제를 적어주세요",
                    onChanged: (content)=>con.setAddRoom("roomName", content)
                  ),
                ),
                const SizedBox(height : 8),
                Text(
                  "설정",
                  style : textStyle
                ),
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "대화 형태",
                    style: TextStyle(
                      fontSize: 16
                    ),
                  ),
                  CustomToggle(
                    childState: const [
                      Text(
                        "개인",
                        style: TextStyle(
                          color : CommonStyle.first
                        ),
                      ),
                      Text(
                        "그룹",
                        style: TextStyle(
                          color : Colors.white
                        ),
                      ),
                    ],
                    childColors: [
                      Theme.of(context).colorScheme.onPrimary,
                      CommonStyle.first
                    ],
                    initialIndex: 0,
                    onChanged: (b){
                      private = !private;
                      con.setAddRoom('isGroup', private);
                    }
                  )
                ],
              ),
              Text(
                "대화할 친구를 1명만 선택하면 개인,\n2명 이상이면 그룹으로 전환되요",
                textAlign: TextAlign.center,
                style : TextStyle(
                  color: textColor
                )
              )
              ],
            );
          }
        ),
      )
    );
  }
}