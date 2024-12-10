import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/custom/modal.dart';
import 'package:nodove_flutter/src/page/custom/widget.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';

class AddRoomPage extends StatelessWidget {
  const AddRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddRoomModel con = Get.put(AddRoomModel());
    RoomListModel lcon = Get.put(RoomListModel());
    NavbarContent navbarOpt = NavbarContent(
      leading: DialogCloseBtn(onPressed: ()=>Navigator.of(context).pop()),
      actions: [
        NextBtn(
          displayText: "시작",
          onPressed : () async{
            final result = await con.addRoom();
            Get.back();
            if (result){
              await lcon.getRoomList();
            }
          }
        ),
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      appBar: NavbarTop(navbarOpt,centerTitle : false),
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
                ProfileSetting(
                  current : con.addRoomForm['profileImage'],
                  onUpdated: (String image) => con.setAddRoom('profileImage', image)
                ),
                const SizedBox(height : 8),
                const Text(
                  "주제",
                ),
                SizedBox(
                  width : constraint.maxWidth * 0.9,
                  child: CommonTextInput(
                    placeholder: "주제를 적어주세요",
                    onChanged: (content)=>con.setAddRoom("roomName", content)
                  ),
                ),
                const SizedBox(height : 8),
                const Text(
                  "설정",
                ),
                
              ],
            );
          }
        ),
      )
    );
  }
}