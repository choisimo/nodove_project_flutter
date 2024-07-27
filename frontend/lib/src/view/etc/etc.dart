import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';

class EtcPage extends StatelessWidget {
  const EtcPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      title : navbarTitle(context,"더보기",20),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: navbarTop(context,navbarOpt,false),
      body : EtcList()
    );
  }
}

class EtcList extends StatefulWidget {
  const EtcList({super.key});

  @override
  State<EtcList> createState() => _EtcListState();
}

class _EtcListState extends State<EtcList> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TextButton(onPressed: (){
        const storage = FlutterSecureStorage();
        storage.delete(key: 'userToken');
        storage.delete(key: 'cookie');
      },
      child : Text("캐시 삭제")
    ),
    );
  }
}