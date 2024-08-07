import 'package:flutter/material.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';

class MsgPage extends StatelessWidget {
  const MsgPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(context,"메신저",20),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false,),
      body : const MsgList()
    );
  }
}

class MsgList extends StatefulWidget {
  const MsgList({super.key});

  @override
  State<MsgList> createState() => _MsgListState();
}

class _MsgListState extends State<MsgList> {

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("메신저 페이지")
    );
  }
}