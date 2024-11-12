import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

class WriteCatePage extends StatelessWidget {
  const WriteCatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      actions : [
        NextBtn(
          displayText: "작성",
          callback: (){
            
          }
        )
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(
        navbarOpt,
        centerTitle :false
      ),
      body : const WriteCate()
    );
  }
}

class WriteCate extends StatelessWidget {
  const WriteCate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height : 8),
          SizedBox(
            width : MediaQuery.of(context).size.width * 0.9,
            child: const CommonTextInput(
              placeholder: "카테고리 제목을 입력해주세요",
            ),
          )
        ],
      )
    );
  }
}