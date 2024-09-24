import 'package:flutter/material.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';

class WriteCatePage extends StatelessWidget {
  const WriteCatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      actions : [
        nextBtn(
          context,
          displayText: "작성",
          callback: (){
            
          }
        )
      ]
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context, navbarOpt, false),
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
            child: commonTextInput(context,
              placeholder: "카테고리 제목을 입력해주세요",
            ),
          )
        ],
      )
    );
  }
}