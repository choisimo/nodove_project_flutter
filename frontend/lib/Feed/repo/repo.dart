
import 'package:nodove_flutter/Feed/datasrc/datasrc.dart';
import 'package:nodove_flutter/Feed/model/feed.dart';

class FeedRepo{
  final DataSrc _source = DataSrc();

  Future<List<Feed>> getFeedList(pageKey,size,cateid,url) {
    return _source.getFeedList(pageKey,size,cateid,url);
  }
}