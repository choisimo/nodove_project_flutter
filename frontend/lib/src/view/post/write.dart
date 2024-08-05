import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/state/color.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final QuillController _controller = QuillController.basic();

  @override
  Widget build(BuildContext context) {
    NavbarContent navbarOpt = NavbarContent(
      leading: backBtn(context),
      actions :[
        nextBtn(context, (){})
      ]
    );
    return Scaffold(
      body: Scaffold(
        appBar: navbarTop(context, navbarOpt, false),
        body : WriteContent(controller: _controller,),
        bottomNavigationBar:QuillToolbar(
          child : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child : Row(
              children: [
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(),
                  controller: _controller,
                  attribute: Attribute.bold,
                ),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(),
                  controller: _controller,
                  attribute: Attribute.italic,
                ),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(),
                  controller: _controller,
                  attribute: Attribute.underline,
                ),
                QuillToolbarToggleStyleButton(
                  options: const QuillToolbarToggleStyleButtonOptions(),
                  controller: _controller,
                  attribute: Attribute.blockQuote,
                ),
              ],
            )
          )
        )
      ),
    );
    
  }
}

class WriteContent extends StatefulWidget {
  final QuillController? controller;
  const WriteContent({super.key,required this.controller});

  @override
  State<WriteContent> createState() => _WriteContentState();
}

class _WriteContentState extends State<WriteContent> {

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin : const EdgeInsets.all(4),
            padding : const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: RowContainer.radius,
              border : Border.all(
                width: 1,
                color : Theme.of(context).colorScheme.onSecondary
              )
            ),
            child: const TextField(
              autocorrect: false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "피드의 제목을 적어주세요"
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin : const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                border : Border.all(
                  width : 1,
                  color : Theme.of(context).colorScheme.onSecondary
                )
              ),
              child: QuillEditor.basic(
                controller: widget.controller,
                configurations: const QuillEditorConfigurations(
                  padding : EdgeInsets.all(4),
                  placeholder: "피드 내용을 입력해주세요",
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  expands: true
                ),
              )
            ),
          )
      ],
    );
  }
}

class WriteEtc extends StatefulWidget {
  const WriteEtc({super.key});

  @override
  State<WriteEtc> createState() => _WriteEtcState();
}

class _WriteEtcState extends State<WriteEtc> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}