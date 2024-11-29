import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nodove_flutter/src/model/recruit.dart';
import 'package:nodove_flutter/src/repo/repo.dart';

class RecruitModel extends GetxController{
  final FeedRepo _feedrepo = FeedRepo();
  RxList<RecruitFeed> recruitlist = <RecruitFeed>[].obs;
  Rx<RecruitFeed> content = RecruitFeed.defaultState().obs;
  RxBool isFetching = false.obs;
  RxBool isFragFetching = false.obs;
  RxBool isLastAppend = false.obs;

  Future<void> deleteRecruitmentFeed(id) async{
    await _feedrepo.deleteRecruitmentFeed(id);
    recruitlist.refresh();
  }
  Future<void> editRecruitmentFeed(formData,id) async{
    await _feedrepo.editRecruitmentFeed(formData,id);
    recruitlist.refresh();
  }

  Future<void> getRecruitmentPage(id) async{
    try{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      isFetching(true);
      RecruitFeed feedPage = await _feedrepo.getRecruitmentPage(id);
      isFetching(false);
      content(feedPage);
    });
    }catch(error){
      print(error);
    }
  }

  Future<void> getRecruitmentFirst(int page,int size) async{
    try{
      WidgetsBinding.instance.addPostFrameCallback((_) async{
        isLastAppend(false);
        isFetching(true);
        final list = await _feedrepo.getRecruitmentList(page,size);

        recruitlist(list);
        isFetching(false);
      });
        }catch(error){
      print(error);
    }
  }

  Future<List<RecruitFeed>> getRecruitmentList(int page,int size) async{
    if (isLastAppend.isFalse&&isFetching.isFalse&&isFragFetching.isFalse){
      isFragFetching(true);
      final list = await _feedrepo.getRecruitmentList(page,size);
      isFragFetching(false);
      return list;
          
    } else {return [];}
  }
  Future<void> appendLastPage(List<RecruitFeed> newData) async{
    recruitlist.addAll(newData);
  }
  Future<void> appendPage(List<RecruitFeed> newData) async{
    recruitlist.addAll(newData);
  }
}