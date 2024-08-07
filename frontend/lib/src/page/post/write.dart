import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/navbar/navbar.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:image_picker/image_picker.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final QuillController _controller = QuillController.basic();
  int page = 0;
  int pageMax = 1;

  @override
  Widget build(BuildContext context) {
  List<Widget> contentPage = [
    WriteContent(controller: _controller,), 
    const WriteEtc(),
  ];
  List<List<Widget>> pageTopNavBtn = [[
      nextBtn(context,displayText: "다음", callback : (){setState((){page += 1;});})
    ],[
      backBtn(context,displayText: "이전", callback : (){setState((){page -= 1;});}),
      nextBtn(context,displayText: "게시", callback : (){print("제출");})
    ]
  ];
    NavbarContent navbarOpt = NavbarContent(
      actions : pageTopNavBtn[page]
    );
    return Scaffold(
      body: Scaffold(
        appBar: navbarTop(context, navbarOpt, false),
        body : contentPage[page],
        bottomNavigationBar:SafeArea(
          child: QuillToolbar(
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
                  QuillToolbarFontSizeButton(
                    controller: _controller,
                    options: const QuillToolbarFontSizeButtonOptions(
                      defaultDisplayText: "폰트",
                      rawItemsMap: {"작게" : "small" , "중간" : "large" , "크게" : "huge"}
                    ),
                  )
                ],
              )
            )
          ),
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
  final ImagePicker _picker = ImagePicker();
  
  final FeedImageModel _imageModel = Get.put(FeedImageModel());
  void imageUpload() async{
    List<XFile>? selectImage = await _picker.pickMultiImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 30,
      limit : 16
    );
    
    if(selectImage.isNotEmpty){
      _imageModel.postImages(selectImage);
    }
  }
  void videoUpload() async{
    XFile? selectVideo = await _picker.pickVideo(
      source : ImageSource.gallery,
      maxDuration: const Duration(minutes: 3),
    );
    
    if(selectVideo != null){
      _imageModel.postVideo(selectVideo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              PopupMenuButton(
                  shape : TooltipShape(84,Theme.of(context).colorScheme.onSurface),
                  offset : const Offset(0,64),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: imageUpload,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/post/picture.svg',
                              width : 24,
                              height : 24,
                              colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
                            ),
                            const SizedBox(width : 8),
                            const Text("사진"),
                          ],
                        )
                      ),
                      PopupMenuItem(
                        onTap: videoUpload,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/post/video.svg',
                              width : 24,
                              height : 24,
                              colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
                            ),
                            const SizedBox(width : 8),
                            const Text("동영상"),
                          ],
                        )
                      )
                    ];
                  },
                  child : Container(
                    width : 48,
                    height : 48,
                    decoration: const BoxDecoration(
                      color : CommonStyle.first,
                      borderRadius: RowContainer.radius
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/navbar/noBorderAdd.svg',
                        width : 24, height : 24,
                        colorFilter: const ColorFilter.mode(Colors.white,BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width : 4),
              Expanded(
                child: Container(
                  height : 96,
                  margin : const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: RowContainer.radius,
                    border : Border.all(
                      color : Theme.of(context).colorScheme.onSecondary,
                      width : 0.5,
                    )
                  ),
                  child : Obx((){
                    if (_imageModel.imageList.isNotEmpty){
                      return ListView.builder(
                        itemCount : _imageModel.imageList.length,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index){
                          return Container(
                            margin: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              borderRadius: RowContainer.radius,
                            ),
                            child : customImage(_imageModel.imageList[index])
                          );
                        }
                      );
                    } else {
                      return const Center(child: Text("사진이나 동영상을 추가해주세요"));
                    }
                  },
                  )
                ),
              ),
            ],
          ),
          Container(
            margin : const EdgeInsets.all(4),
            padding : const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: RowContainer.radius,
              border : Border.all(
                width: 0.5,
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
                  width : 0.5,
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
    return Column(
      children: [
        ExpansionTile(
          title : const Text("시간과 장소"),
          children: [
            TextButton(
              onPressed: (){},
              child : Text("시간"),
            )
          ],
        )
      ],
    );
  }
}