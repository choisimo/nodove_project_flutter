import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title : 'login',
      home : LogIn()
    );
  }
}
class LogIn extends StatefulWidget{
  const LogIn({super.key});
  State<LogIn> createState() => _LogInState();
}
class _LogInState extends State<LogIn>{
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title : const Text('로그인',style : TextStyle(color:Colors.white)),
        backgroundColor: const Color.fromARGB(255, 255, 133, 34),
      ),
      body : GestureDetector(
        child :Column(
          children: [
            Form(
              child: Theme(
                data:ThemeData(primaryColor: Colors.grey),
                child : Container(
                  padding : const EdgeInsets.all(24),
                  child: Builder(builder : (context){
                    return Column(
                      children: [
                        Container(
                            margin:EdgeInsets.only(bottom:24),
                            child:TextField(
                              controller : controller,
                              autofocus: true,
                              decoration: const InputDecoration(labelText : '아이디'),
                              keyboardType: TextInputType.text,
                          ),
                        ),
                        Container(
                            margin:EdgeInsets.only(bottom:24),
                            child : TextField(
                              controller : controller,
                              decoration: const InputDecoration(labelText : '비밀번호'),
                              keyboardType: TextInputType.text,
                            )
                        )
                      ],
                    );
                  })
                )
              ),
            )
          ],
        )
      ),
      bottomNavigationBar : Container(
        decoration : const BoxDecoration(
            border : Border(
              top : BorderSide(
                width : 1,
                color : Color.fromARGB(255, 193, 193, 193)
              ),
            )
        ),
        child : const BottomAppBar(
          height : 60,
          color : Color.fromARGB(255, 240, 240, 240),
          child : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Icon(Icons.arrow_back),Icon(Icons.home),Icon(Icons.list)],
          )
        )
      )
    );
  }
}