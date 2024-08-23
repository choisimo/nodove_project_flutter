import 'package:flutter/material.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';

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
    return const Placeholder();
  }
}