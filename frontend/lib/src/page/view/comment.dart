import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/graphic/image.dart';
import 'package:nodove_flutter/src/component/navbar/navbtn.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/src/page/custom/custom.dart';
import 'package:nodove_flutter/src/page/list/feed/feedrow.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/page.dart';
import 'package:nodove_flutter/state/url.dart';

class CommentList extends StatefulWidget {
  final String url;
  final String? opt;
  final int page;
  final bool? enableScroll;
  const CommentList({super.key ,required this.url, required this.page , this.opt , this.enableScroll});
  
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Dio dio = Dio();
  final maxPage = 5;
  final CommentPageModel con = Get.put(CommentPageModel());
  late ScrollController _scrollController = ScrollController();
  int pageKey = 0;

  void _initLoad() async{
    String commentUrl = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/${widget.page}";
    String commentOpt = "maxSize=$maxPage";
    ViewPageState.page.setComment(commentUrl,commentOpt);
    con.getCommentFirst(commentUrl,commentOpt);
  }

  @override
  void initState() {
    _initLoad();
    _scrollController = ScrollController()..addListener(fetchPage);
    super.initState();
  }
  @override
  void dispose() {
    _scrollController.removeListener(fetchPage);
    super.dispose();
  }
  
  void fetchPage() async {
    PageUrl url = ViewPageState.page.comment.value;
    if (!con.isFetching.value && 
    !con.isFragFetching.value &&
    _scrollController.position.extentAfter < 100){
      try {
        pageKey += 1;
        final newData = await con.fetchCommentFrag(url.url,url.opt,pageKey);
        final isLastPage = newData.isEmpty;

        if(!mounted) return;
        if (isLastPage) {
          con.appendLastPage(newData);
        } else {
          con.appendPage(newData);
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool enableScroll = widget.enableScroll??false;
    PageUrl url = ViewPageState.page.comment.value;
    return LayoutBuilder(
      builder: (context,constraint) {
        return CustomRefreshIndicator(
          onRefresh: ()=>Future.sync(()=>con.getCommentFirst(url.url,url.opt)),
          child: Obx((){
              if (con.isFetching.value){
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if(con.commentList.isEmpty){
                return const Text("댓글이 없어요..");
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  controller : _scrollController,
                  physics : (enableScroll)?
                  const AlwaysScrollableScrollPhysics()
                  :const NeverScrollableScrollPhysics(),
                  itemBuilder:(context, index) {
                    return CommentRow(props: con.commentList[index], constraint: constraint);
                  },
                  itemCount: con.commentList.length,
                );
              }
            }
          )
        );
      }
    );
  }
}

class CommentRow extends StatefulWidget {
  final Comment props;
  final BoxConstraints constraint;
  const CommentRow({super.key ,required this.props , required this.constraint});

  @override
  State<CommentRow> createState() => _CommentRowState();
}

class _CommentRowState extends State<CommentRow> {
  @override
  Widget build(BuildContext context) {
    Comment props = widget.props;
    final GlobalKey<FormState> commentTopKey = GlobalKey<FormState>();

    return Container(
      margin: const EdgeInsets.all(8.0),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Profile(profile: "https://file.career-block.com/attach/images/logo.jpg", width: 42, height: 42),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin : const EdgeInsets.only(bottom: 0),
                  height : 42,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        props.writer,
                        style : const TextStyle(
                          height : 1,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(height : 2),
                      Row(
                        children: [
                          Text(
                            "${"소속 없음"} |",
                            style: TextStyle(
                              fontSize : 12,
                              color : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Text(
                            getDateDiff(props.createdAt),
                            style: TextStyle(
                              fontSize : 12,
                              color : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 320,
                    maxHeight: 720,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(
                    borderRadius: RowContainer.radius
                  ),
                  child : Html(
                    data: props.comment,
                    style: {
                      "body": Style(margin: Margins.only(
                        top:8.0,
                      ))
                    },
                  )
                ),
                SizedBox(
                  child: TextButton(
                    style : TextButton.styleFrom(
                      padding: const EdgeInsets.all(0.0)
                    ),
                    onPressed: (){
                      if (commentTopKey.currentContext != null){
                        Scrollable.ensureVisible(
                          commentTopKey.currentContext!,
                          duration : const Duration(seconds : 1),
                        );
                      }
                    },
                    child : Text(
                      "답글 달기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const EtcCommonBtn(),
              const SizedBox(height : 16.0),
              Row(
                children: [
                  CustomSvg(
                    "post/star-empty.svg",
                    width : 18 , height : 18,
                    iconColor : Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
                  const SizedBox(width : 4.0),
                    Text(
                    "0",
                    style : TextStyle(
                      color: Theme.of(context).colorScheme.secondary
                    )
                  )
                ],
              ),
            ],
          ),
        ],
      )
    );
  }
}
class commentList extends StatefulWidget {
  final int page;
  const commentList({super.key , required this.page});

  @override
  State<commentList> createState() => _commentListState();
}

class _commentListState extends State<commentList> {
  final CommentPageModel con = Get.put(CommentPageModel());
  @override
  Widget build(BuildContext context) {
    int page = widget.page;
    PageUrl url = ViewPageState.page.comment.value;
    final height = MediaQuery.of(context).size.height;
    FocusNode nfocus = FocusNode();
    return GestureDetector(
      onTap : ()=>FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: SizedBox(
          width : double.infinity,
          height : height * 0.6,
          child: LayoutBuilder(
            builder:(context,constraint){
              return Column(
                children: [
                  Expanded(
                    child: CommentList(
                      url : url.url,
                      opt : url.opt,
                      page : page
                      ,enableScroll: true),
                  ),
                  CustomWrite(
                    focus : false,
                    callback: (content) async{
                      if (content.isNotEmpty){
                        await con.postComment({
                          'post_id': page,
                          'comment': content
                        }).then((res){
                          Get.find<CommentPageModel>().getCommentFirst(url.url, url.opt);
                        });
                      }
                    },
                  ),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

class CustomWrite extends StatefulWidget {
  final bool focus;
  final Function? callback;

  const CustomWrite({super.key ,
  required this.focus,
  required this.callback});

  @override
  State<CustomWrite> createState() => _CustomWriteState();
}

class _CustomWriteState extends State<CustomWrite> {
  final ImagePicker _picker = ImagePicker();
  late String content = "";
  
  final FeedImageModel _imageModel = Get.put(FeedImageModel());
  void imageUpload() async{
    XFile? selectImage = await _picker.pickImage(
      source : ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 30,
    );
    
    if(selectImage != null){
      _imageModel.postImages([selectImage]);
    }
  }
  @override
  Widget build(BuildContext context) {
    final bool focus = widget.focus;
    final double maxWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder : (context,constraint){
        return Container(
            width : double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: rowBorderLine()
              )
            ),
            child: Container(
            width:maxWidth * 0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: RowContainer.radius
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints : const BoxConstraints(
              minHeight: 42
            ),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width : 48,
                  height : 48,
                  child: IconButton(
                    onPressed: imageUpload,
                    icon: CustomSvg(
                      'post/picture.svg',
                      width : 24, height : 24,
                      iconColor: Theme.of(context).colorScheme.onPrimaryFixed,
                    ),
                  ),
                ),
                const SizedBox(width : 8),
                Expanded(
                  child: Container(
                    padding : const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextField(
                      maxLines: 10,
                      minLines: 1,
                      autofocus: focus,
                      onChanged : (text){
                        content = text;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "답글 남기기",
                        hintStyle : TextStyle(
                          color : Theme.of(context).colorScheme.secondary
                        )
                      ),
                    ),
                  ),
                ),
                const SizedBox(width : 8),
                SizedBox(
                  width : 48,
                  height : 48,
                  child: IconButton(
                    icon : Text(
                      "게시",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryFixed
                      ),
                    ),
                    onPressed: () => widget.callback?.call(content),
                  ),
                ),
              ],
            )
          )
        );
      }
    );
  }
}