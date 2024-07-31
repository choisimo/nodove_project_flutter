import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nodove_flutter/src/vmodel/vmodel.dart';
import 'package:nodove_flutter/state/color.dart';
import 'package:nodove_flutter/state/url.dart';

class CommentList extends StatefulWidget {
  final int? page;
  final bool? enableScroll;
  const CommentList({super.key , this.page , this.enableScroll});
  
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Dio dio = Dio();
  final size = 5;
  late List<Comment> commentList;
  final CommentPageModel con = Get.put(CommentPageModel());
  late ScrollController _scrollController = ScrollController();
  int pageKey = 0;

  void _initLoad() async{
    final int page = widget.page??int.parse(Get.parameters['page']??'3');
    final String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";

    con.getCommentFirst(url, "pageSize=$size");
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
    if (!con.isFetching.value && 
    !con.isFragFetching.value &&
    _scrollController.position.extentAfter < 100){
      try {
        pageKey += 1;
        final int page = widget.page??int.parse(Get.parameters['page']??'3');
        final String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";
        final newData = await con.fetchCommentFrag(pageKey, url, "pageSize=5");
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
    final int page = widget.page??int.parse(Get.parameters['page']??'3');
    final String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";
    bool enableScroll = widget.enableScroll??false;
    return LayoutBuilder(

      builder: (context,constraint) {
        return RefreshIndicator(
          onRefresh: ()=>Future.sync(()=>con.update()),
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
    BoxConstraints constraints = widget.constraint;
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
                  margin : const EdgeInsets.only(bottom: 4),
                  height : 21,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Profile(profile: "https://pbs.twimg.com/profile_images/1376539213215068162/EnA-bQS5_400x400.jpg", width: 18, height: 18),
                      const SizedBox(width: 2),
                      Text(
                        props.writer,
                        style : const TextStyle(
                          height : 1,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
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
                        SizedBox(width : 6),
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
                      colorFilter: ColorFilter.mode(CommonStyle.first,BlendMode.srcIn),
                    ),
                    Text(
                      "0",
                      style : TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground
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
  
  @override
  Widget build(BuildContext context) {
    final page = widget.page;
    final height = MediaQuery.of(context).size.height;
    FocusNode nfocus = FocusNode();
    return SafeArea(
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
                    onTap : ()=>nfocus.unfocus(),
                    child: CommentList(page : page,enableScroll: true)
                  ),
                ),
                commentWrite(page : page,focus : false,nfocus : nfocus)
              ],
            );
          }
        ),
      ),
  );
  }
}

class commentWrite extends StatefulWidget {
  final int page;
  final bool focus;
  final FocusNode nfocus;

  const commentWrite({super.key ,
  required this.page,
  required this.focus,
  required this.nfocus});

  @override
  State<commentWrite> createState() => _commentWriteState();
}

class _commentWriteState extends State<commentWrite> {
  @override
  Widget build(BuildContext context) {
    final int page = widget.page;
    final bool focus = widget.focus;
    final FocusNode nfocus = widget.nfocus;
    late String comment = "";
    final String url = "${Url.serverUrl}${Url.apiUrl}/commentListByPostId/$page";
    final CommentPageModel con = Get.put(CommentPageModel());
    return LayoutBuilder(
      builder : (context,constraint){
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  width: 0.5,
                  color : Theme.of(context).colorScheme.onSecondary
                )
              )
            ),
            constraints : const BoxConstraints(
              minHeight: 50
            ),
            child : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width : 56,
                  height : 56,
                  child: IconButton(
                    icon : SvgPicture.asset(
                      "assets/icons/navbar/noBorderAdd.svg",
                      width : 24, height : 24,
                      colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                    ),
                    onPressed: (){},
                  ),
                ),
                Expanded(
                  child: Container(
                    padding : const EdgeInsets.symmetric(
                      vertical: 2,
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
                        comment = text;
                      },
                      focusNode: nfocus,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width : 56,
                  height : 56,
                  child: IconButton(
                    icon : SvgPicture.asset(
                      "assets/icons/navbar/msg.svg",
                      width : 24, height : 24,
                      colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                    ),
                    onPressed: () async{
                      if (comment.isNotEmpty){
                        con.postComment({
                          'post_id': page,
                          'comment': comment
                        });
                      }
                    },
                  ),
                ),
              ],
            )
          ),
        );
      }
    );
  }
}