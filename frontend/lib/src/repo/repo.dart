
import 'package:nodove_flutter/src/datasrc/datasrc.dart';
import 'package:nodove_flutter/src/model/cate.dart';
import 'package:nodove_flutter/src/model/comment.dart';
import 'package:nodove_flutter/src/model/feed.dart';

class FeedRepo{
  final DataSrc _source = DataSrc();

  Future<List<Feed>> getFeedList(pageKey,url,opt) {
    return _source.getFeedList(pageKey,url,opt);
  }
  Future<Feed> getFeedPage(page,url) {
    return _source.getFeedPage(page,url);
  }
  Future<List<Categories>> getCateList(url,opt , child){
    return _source.getCateList(url, opt , child);
  }
  Future<List<Comment>> getCommentPage(pageKey,url,opt){
    return _source.getCommentList(pageKey,url,opt);
  }
}