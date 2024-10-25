import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nodove_flutter/graphic/border.dart';
import 'package:nodove_flutter/graphic/transform.dart';
import 'package:nodove_flutter/src/component/navbar/navbar.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/src/page/tag/tagrow.dart';

class WritePage extends StatefulWidget {
  const WritePage({super.key});

  @override
  State<WritePage> createState() => _WritePageState();
}

class _WritePageState extends State<WritePage> {
  final QuillController _controller = QuillController.basic();
  int page = 0;
  int pageMax = 1;
  late FeedWrite feedWrite;

  @override
  Widget build(BuildContext context) {
    final FeedListModel formData = Get.put(FeedListModel());
    final url = ViewPageState.page.view.value;
    NavbarContent navbarOpt = NavbarContent(
      actions : [
        NextBtn(displayText: "쓰기", callback : (){
          formData.postWrite(formData.writeForm);
          Get.find<FeedListModel>().getFeedFirst(url.url, url.opt);
          Get.back();
        })
      ]
    );
    List<Widget> contentPage = [
      Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        appBar: NavbarTop(navbarOpt, centerTitle : false),
        body : WriteContent(controller: _controller,),
        bottomNavigationBar:Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border : Border(top: BorderSide(width: 0.5 , color : Theme.of(context).colorScheme.onSecondary))
          ),
          child: SafeArea(
            child: QuillToolbar(
              child : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child : Row(
                  children: [
                    QuillToolbarToggleStyleButton(
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconTheme: QuillIconTheme(
                          iconButtonSelectedData: IconButtonData(
                            color : Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        tooltip: "굵게"
                      ),
                      controller: _controller,
                      attribute: Attribute.bold,
                    ),
                    QuillToolbarToggleStyleButton(
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconTheme: QuillIconTheme(
                          iconButtonSelectedData: IconButtonData(
                            color : Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        tooltip: "이텔릭"
                      ),
                      controller: _controller,
                      attribute: Attribute.italic,
                    ),
                    QuillToolbarToggleStyleButton(
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconTheme: QuillIconTheme(
                          iconButtonSelectedData: IconButtonData(
                            color : Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        tooltip: "밑줄"
                      ),
                      controller: _controller,
                      attribute: Attribute.underline,
                    ),
                    QuillToolbarToggleStyleButton(
                      options: QuillToolbarToggleStyleButtonOptions(
                        iconTheme: QuillIconTheme(
                          iconButtonSelectedData: IconButtonData(
                            color : Theme.of(context).colorScheme.onPrimary,
                          )
                        ),
                        tooltip: "인용 블록"
                      ),
                      controller: _controller,
                      attribute: Attribute.blockQuote,
                    ),
                    QuillToolbarFontSizeButton(
                      controller: _controller,
                      options: QuillToolbarFontSizeButtonOptions(
                        defaultDisplayText: "폰트",
                        rawItemsMap: const {"작게" : "small" , "중간" : "large" , "크게" : "huge"},
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary
                        )
                      ),
                    ),
                  ],
                )
              )
            ),
          ),
        )
      ),
    ];
    return Scaffold(
      body: contentPage[page]
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
  final FeedListModel formData = Get.put(FeedListModel());
  
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
      formData.setForm("imageLinks", _imageModel.imageList);
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
  void initState(){
    int cate = Get.arguments['postCategory']??3;
    formData.setForm('postCategory',cate);
    widget.controller!.document.changes.listen((event){
      dynamic content = widget.controller!.document.toPlainText();
      formData.setForm('content',content);
    });
    super.initState();
  }

  Widget writeTitle(BuildContext context,{
    String? title,
  }){
    return Container(
      padding: const EdgeInsets.all(4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary
    );
    var controller = TextEditingController(text : formData.writeForm['title']);
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            writeTitle(context,title : "사진 혹은 동영상"),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                PopupMenuButton(
                    color : Theme.of(context).colorScheme.onPrimary,
                    shadowColor: Colors.transparent,
                    shape : TooltipShape(
                      vertical : 84,
                      borderColor : Theme.of(context).colorScheme.shadow),
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
                                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                              ),
                              const SizedBox(width : 8),
                              Text(
                                "사진",
                                style:textStyle,
                              ),
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
                                colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                              ),
                              const SizedBox(width : 8),
                              Text(
                                "동영상",
                                style: textStyle,
                              ),
                            ],
                          )
                        )
                      ];
                    },
                    child : Container(
                      width : 48,
                      height : 48,
                      decoration: BoxDecoration(
                        color : Theme.of(context).colorScheme.onPrimaryFixed,
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
                        color : Theme.of(context).colorScheme.secondary,
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
                            return AspectRatio(
                              aspectRatio: 1/1,
                              child: PopupMenuButton(
                                shape : TooltipShape(
                                  vertical : 84,
                                  borderColor : Theme.of(context).colorScheme.onSurface),
                                offset : const Offset(0,96),
                                itemBuilder: (context){
                                  return [
                                    PopupMenuItem(
                                      onTap: (){},
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/post/edit.svg',
                                            width : 24,
                                            height : 24,
                                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                                          ),
                                          const SizedBox(width : 8),
                                          Text("편집",style : textStyle),
                                        ],
                                      )
                                    ),
                                     PopupMenuItem(
                                      onTap: (){_imageModel.deleteImages(index);},
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/post/delete.svg',
                                            width : 24,
                                            height : 24,
                                            colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                                          ),
                                          const SizedBox(width : 8),
                                          Text(
                                            "삭제",style : textStyle
                                          ),
                                        ],
                                      )
                                    ),
                                  ];
                                },
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  child : ClipRRect(
                                    borderRadius: RowContainer.radius,
                                    child: customImage(
                                      _imageModel.imageList[index],
                                      fit: BoxFit.cover
                                    ),
                                  )
                                ),
                              ),
                            );
                          }
                        );
                      } else {
                        return Center(
                          child: Text(
                            "사진이나 동영상을 추가해주세요",
                            style : TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.secondary
                            ),
                          )
                        );
                      }
                    },
                    )
                  ),
                ),
              ],
            ),
            writeTitle(context,title : "제목"),
            Container(
              margin : const EdgeInsets.all(4),
              padding : const EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                border : Border.all(
                  width: 0.5,
                  color : Theme.of(context).colorScheme.secondary
                )
              ),
              child: TextField(
                autocorrect: false,
                onChanged: (text){
                  formData.setForm('title',text);
                },
                controller : controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "피드의 제목을 적어주세요",
                  hintStyle: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary
                  ),
                ),
              ),
            ),
            writeTitle(context,title : "내용"),
            Container(
              height : 320,
              margin : const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: RowContainer.radius,
                border : Border.all(
                  width : 0.5,
                  color : Theme.of(context).colorScheme.secondary
                )
              ),
              child: QuillEditor.basic(
                controller: widget.controller,
                configurations: QuillEditorConfigurations(
                  customStyles: DefaultStyles(
                    placeHolder: DefaultListBlockStyle(
                      TextStyle(
                        fontSize : 18,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                      HorizontalSpacing.zero,
                      VerticalSpacing.zero,
                      VerticalSpacing.zero,
                      null,
                      null
                    )
                  ),
                  padding : const EdgeInsets.all(4),
                  placeholder: "피드 내용을 입력해주세요",
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  expands: true
                ),
              )
            ),
            writeTitle(context,title : "추가사항"),
            const WriteEtc()
        ],
      ),
    );
  }
}

class WriteEtc extends StatefulWidget {
  const WriteEtc({super.key});

  @override
  State<WriteEtc> createState() => _WriteEtcState();
}

class _WriteEtcState extends State<WriteEtc>{
  DateTime date = DateTime.now();
  bool private = false;
  final TagListModel tagModel = Get.put(TagListModel());
  final FeedListModel formData = Get.put(FeedListModel());
  
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.primary
    );
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title : Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/navbar/navi.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                  ),
                  const SizedBox(width : 4),
                  Text(
                    "시간과 장소",style : textStyle
                  ),
                ]
              ),
              children: [
                const Text("어떤 시간에 활동하셨나요?"),
                SizedBox(
                  height : 42,
                  child: SelectedDateButton(
                    onSubmitted: (dt){
                      setState((){date = dt;});
                      Get.back();
                    },
                    title : "",
                    date : date
                  ),
                ),
                const Text("어떤 곳에서 활동하셨나요?"),
                OutlinedButton(
                  onPressed: (){},
                  child : const Text("장소"),
                )
              ],
            ),
            ExpansionTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title : Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/navbar/hashtag.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                  ),
                  const SizedBox(width : 4),
                  Text("해시태그",style : textStyle),
                ]
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("내 활동에 "),
                    Text("#해시태그",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),),
                    const Text("도 달아보세요")
                  ],
                ),
                tagParts(context)
              ],
            ),
            ExpansionTile(
              collapsedBackgroundColor: Theme.of(context).colorScheme.onPrimary,
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title : Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/common/setting.svg",
                    width : 16,height : 16,
                    colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                  ),
                  const SizedBox(width : 4),
                  Text("설정",style : textStyle),
                ],
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("나만 볼수 있는 피드로 할까요?"),
                    Switch(
                      value: private,
                      onChanged: (b){
                        setState((){
                          private = !private;
                        });
                        formData.setForm('isPrivate', private);
                      }
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      )
    );
  }
  
  Widget tagParts(BuildContext context){
    var controller = TextEditingController();
    return SizedBox(
      width : MediaQuery.of(context).size.width * 0.95,
      child: Column(
        children: [
          TagRow(hashtags: tagModel.tagList),
          TextField(
            maxLength: 96,
            onTapOutside: ((event) {
              FocusScope.of(context).unfocus();
            }),
            textInputAction: TextInputAction.go,
            onSubmitted: (text){
              if (text.isNotEmpty){
                tagModel.addTag(text);
              }
            },
            controller : controller,
            decoration: InputDecoration(
              hintText: "태그를 입력해주세요",
              suffixIcon: IconButton(
                icon : Rotate(
                  angle : 90,
                  child: SvgPicture.asset(
                    "assets/icons/common/left.svg",
                    width : 16,height:16,
                    colorFilter : ColorFilter.mode(Theme.of(context).colorScheme.onSecondary, BlendMode.srcIn)
                  ),
                ),
                onPressed: (){
                  if (controller.text.isNotEmpty){
                    tagModel.addTag(controller.text);
                    formData.setForm('postHashtags', tagModel);
                    controller.text = "";
                  }
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedDateButton extends StatelessWidget {
  final Function? onSubmitted;
  final DateTime? date;
  final String? title;
  final String mode;
  const SelectedDateButton({
    super.key,
    this.onSubmitted,
    this.date,
    this.title,
    this.mode = "DateTime",
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
    height : 42,
    child: OutlinedButton(
      onPressed: (){
        showCupertinoModalPopup(
          context: context,
          builder: (context){
            return SelectDate(
              onSubmitted: onSubmitted,
              current : date,
              mode : mode
            );
          }
        );
      },
      style: OutlinedButton.styleFrom(
        shape : const RoundedRectangleBorder(
          side : BorderSide(width : 0.5),
          borderRadius: RowContainer.radius
        )
      ),
      child : Text(
        "${(title!=null)?title:"날짜:"}${
          DateFormat("yyyy년 MM월 dd일").format(date??DateTime.now())
        }"
      ),
    ),
  );
  }
}
class SelectDate extends StatefulWidget {
  final Function? onSubmitted;
  final DateTime? current;
  final String mode;
  const SelectDate({
    super.key,
    this.onSubmitted,
    required this.current,
    this.mode = "DateTime"
  });

  @override
  State<SelectDate> createState() => _SelectDateState();
}

class _SelectDateState extends State<SelectDate> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(
    length: 2,
    vsync: this,
    initialIndex: 0,
  );
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime current = widget.current??DateTime.now();
    return SafeArea(
      child: Container(
        width : double.infinity,
        height : 320,
        color : Theme.of(context).colorScheme.secondary,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: TabBar(
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Theme.of(context).colorScheme.onPrimaryFixed,
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Theme.of(context).colorScheme.onPrimaryFixed,
              controller: tabController,
              tabs: [
                (widget.mode.contains("Date"))?const Tab(text : "날짜",):const SizedBox.shrink(),
                (widget.mode.contains("Time"))?const Tab(text : "시간",):const SizedBox.shrink(),
              ] 
            ),
            body : CupertinoTheme(
              data : CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color : Theme.of(context).colorScheme.primary,
                    fontSize : 24
                  )
                ),
              ),
              child: TabBarView(
                controller: tabController,
                children: [
                  CupertinoDatePicker(
                    minimumYear: 1970,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: current,
                    onDateTimeChanged: (DateTime dt) {
                      if (mounted) {
                        setState(() => date = dt);
                      }
                    },
                  ),
                  CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.time,
                    initialDateTime: current,
                    onDateTimeChanged: (DateTime dt) {
                      if (mounted) {
                          print(dt);
                      }
                    },
                  ),
                ]
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: TextButton(
                onPressed: () => widget.onSubmitted?.call(date),
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimaryFixed
                ),
                child: const Text(
                  "확인",
                  style : TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  )
                ),
              ),
            ),
        ),
      ),
    );
  }
}