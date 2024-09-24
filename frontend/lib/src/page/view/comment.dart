import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nodove_flutter/func/date/dateTime.dart';
import 'package:nodove_flutter/navbar/navbtn.dart';
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
        return customRefreshIndicator(
          context,
          onRefresh: ()=>Future.sync(()=>con.getCommentFirst(url.url,url.opt)),
          child: GetX<CommentPageModel>(
            builder:(context){
              if (con.isFetching.value){
                return const CircularProgressIndicator(
                  strokeWidth: 2,
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
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin : const EdgeInsets.only(bottom: 0),
                  height : 24,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Profile(profile: "https://pbs.twimg.com/profile_images/1376539213215068162/EnA-bQS5_400x400.jpg", width: 24, height: 24),
                      const SizedBox(width: 2),
                      Text(
                        props.writer,
                        style : const TextStyle(
                          height : 1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),
                      const SizedBox(width : 2),
                      etcCommonBtn(context , fontSize : 10)
                    ],
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(
                    maxWidth: 320,
                    maxHeight: 720,
                  ),
                  clipBehavior: Clip.hardEdge,
                  decoration: const BoxDecoration(borderRadius: RowContainer.radius),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child : Html(
                    data: props.comment,
                  )
                ),
                SizedBox(
                  child: TextButton(
                    onPressed: (){
                      if (commentTopKey.currentContext != null){
                        Scrollable.ensureVisible(
                          commentTopKey.currentContext!,
                          duration : const Duration(seconds : 1),
                        );
                      }
                    },
                    child : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("답글 ${props.replies!.length}개 보기"),
                        const SizedBox(width : 6),
                        SvgPicture.asset(
                          "assets/icons/common/right.svg",
                          width : 16 , height : 10,
                          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onSurface,BlendMode.srcIn),
                        )
                      ],
                    )
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/post/star-empty.svg",
                      width : 20 , height : 20,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed,BlendMode.srcIn),
                    ),
                    Text(
                      "0",
                      style : TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface
                      )
                    )
                  ],
                ),
                onPressed: (){},
              ),
              SizedBox(
                child : Text(
                  getDateDiff(props.createdAt),
                  style: TextStyle(
                    fontSize : 12,
                    color : Theme.of(context).colorScheme.secondary,
                  ),
                )
              ),
            ],
          )
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
          height : height * 0.6,
          child: LayoutBuilder(
            builder:(context,constraint){
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height : 32,
                    child : Center(
                      child: Text(
                        "댓글",
                        style : TextStyle(
                          color : Theme.of(context).colorScheme.onSurface,
                          fontSize : 20,
                        
                        )
                      ),
                    )
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: CommentList(
                      url : url.url,
                      opt : url.opt,
                      page : page
                      ,enableScroll: true)
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary
                    ),
                    child: SafeArea(
                      child: CustomWrite(
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
                    ),
                  )
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
    
    return LayoutBuilder(
      builder : (context,constraint){
        return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(32)),
              border: Border.all(
                width: 0.5,
                color : Theme.of(context).colorScheme.onSecondary
              )
            ),
            constraints : const BoxConstraints(
              minHeight: 42
            ),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width : 56,
                  height : 48,
                  child: IconButton(
                    onPressed: imageUpload,
                    icon: SvgPicture.asset(
                      'assets/icons/post/picture.svg',
                      width : 24, height : 24,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed,BlendMode.srcIn),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding : const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        vertical: BorderSide(
                          width: 0.5,
                          color : Theme.of(context).colorScheme.onSecondary
                        ),
                      ),
                    ),
                    child: TextField(
                      maxLines: 10,
                      minLines: 1,
                      autofocus: focus,
                      onChanged : (text){
                        content = text;
                      },
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width : 56,
                  height : 48,
                  child: IconButton(
                    icon : SvgPicture.asset(
                      "assets/icons/navbar/msg.svg",
                      width : 24, height : 24,
                      colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimaryFixed, BlendMode.srcIn),
                    ),
                    onPressed: () => widget.callback?.call(content),
                  ),
                ),
              ],
            )
          );
      }
    );
  }
}