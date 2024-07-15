import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nodove_flutter/func/dateTime.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/repo/repo.dart';
import 'package:nodove_flutter/src/view/normal/feedrow.dart';
import 'package:nodove_flutter/src/model/feed.dart';
import 'package:nodove_flutter/state/color.dart';

class CommentList extends StatefulWidget {
  const CommentList({super.key});
  
  @override
  State<CommentList> createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  Dio dio = Dio();
  final size = 10;
  final int page = int.parse(Get.parameters['page']??'3');
  
  late List<Comment> commentList;
  
  final PagingController<int, Comment> _pagingController = PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final String url = "https://gcp.nodove.com/api/commentListByPostId/$page";
      final newData = await FeedRepo().getCommentPage(pageKey,url,"pageSize=$size");
      final isLastPage = newData.isEmpty;
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

  @override
  Widget build(BuildContext context) {
    return normalRow();
  }

  Widget normalRow (){
    return PagedListView<int,Comment>(
        pagingController: _pagingController,
        physics : const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        builderDelegate: PagedChildBuilderDelegate<Comment>(
          itemBuilder : (con,item,index) => CommentRow(props : item)
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

    return Container(
      margin: const EdgeInsets.only(left : 8 , right : 8),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Row(
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
                SizedBox(
                  child: Text(
                    props.comment,
                    softWrap: true,
                    style : TextStyle(
                      height : 1,
                      
                    )
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: (){},
                    child : Row(
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
