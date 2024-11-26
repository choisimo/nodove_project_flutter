import 'package:flutter/material.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: BackBtn(onPressed: ()=>Navigator.of(context).pop()),
      title: const NavbarTitle("설정")
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: NavbarTop(navbarOpt,centerTitle : true,),
      body: const SettingView()
    );
  }
}

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}