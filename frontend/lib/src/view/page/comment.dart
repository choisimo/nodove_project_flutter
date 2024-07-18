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
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';

class CommentList extends StatefulWidget {
  final int? page;
  final bool? enableScroll;
  const CommentList({super.key , this.page , this.enableScroll});
  
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Dio dio = Dio();
  final size = 10;
  late List<Comment> commentList;
  
  final PagingController<int, Comment> _pagingController = PagingController(firstPageKey: 0);
  
  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
  
  Future<void> _fetchPage(int pageKey) async {
    final int page = widget.page??int.parse(Get.parameters['page']??'3');
  
    try {
      final String url = "https://gcp.nodove.com/api/commentListByPostId/$page";
      final newData = await FeedRepo().getCommentPage(pageKey,url,"pageSize=$size");
      final isLastPage = newData.isEmpty;
      if(!mounted) return;
      if (isLastPage) {
        _pagingController.appendLastPage(newData);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newData, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool enableScroll = widget.enableScroll??false;
    return SizedBox(
      width : MediaQuery.of(context).size.width,
      child: RefreshIndicator(
        onRefresh: ()=>Future.sync(()=>_pagingController.refresh()),
        child: PagedListView<int,Comment>(
          pagingController: _pagingController,
          physics : (enableScroll)?const AlwaysScrollableScrollPhysics():const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate<Comment>(
            itemBuilder : (con,item,index) => CommentRow(props : item)
          ),
        ),
      ),
    );
  }
}

class CommentRow extends StatefulWidget {
  final Comment props;
  const CommentRow({super.key ,required this.props});

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
          Container(
            constraints: BoxConstraints(
              maxWidth:  MediaQuery.of(context).size.width * 0.8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin : EdgeInsets.only(bottom: 4),
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
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    props.comment,
                    softWrap: true,
                    style : const TextStyle(
                      height : 1,
                      
                    )
                  ),
                ),
                Container(
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
Widget commentList(BuildContext context,int page){
  final height = MediaQuery.of(context).size.height;
  FocusNode nfocus = FocusNode();
  return SafeArea(
    child: SizedBox(
      height : height * 0.6,
      child: LayoutBuilder(
        builder:(context,constraint){
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: SizedBox(
                    child: CommentList(page : page,enableScroll: true),
                  ),
                ),
              ),
              commentWrite(context,page,false,nfocus)
            ],
          );
        }
      ),
    ),
  );
}
Widget commentWrite(BuildContext context,int page,bool focus,FocusNode nfocus){
  late String comment = "";
  return LayoutBuilder(
    builder : (context,constraint){
      return SafeArea(
        child: Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                width: 1,
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
                width : 42,
                child: IconButton(
                  icon : SvgPicture.asset(
                    "assets/icons/navbar/noBorderAdd.svg",
                    width : 24, height : 24,
                    colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                  ),
                  onPressed: (){},
                ),
              ),
              Container(
                width : constraint.maxWidth - 92,
                padding : const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                      width: 1,
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
              SizedBox(
                width : 42,
                child: IconButton(
                  icon : SvgPicture.asset(
                    "assets/icons/navbar/msg.svg",
                    width : 24, height : 24,
                    colorFilter: const ColorFilter.mode(CommonStyle.first, BlendMode.srcIn),
                  ),
                  onPressed: () async{
                    if (comment.isNotEmpty){
                      await DataSrc().postComment({'post_id': page, 'comment': comment});
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