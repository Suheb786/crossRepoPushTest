import 'package:domain/usecase/register/nature_of_special_needs_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class NatureSpecialNeedsDialogViewModel extends BasePageViewModel {
  final NatureOfSpecialNeedsUseCase _getNatureSpecialNeedsUseCase;

  final FixedExtentScrollController scrollController = FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  PublishSubject<NatureOfSpecialNeedsUseCaseParams> _getNatureSpecialNeedsRequest = PublishSubject();

  PublishSubject<Resource<List<String>>> _getNatureSpecialNeedsResponse = PublishSubject();

  Stream<Resource<List<String>>> get getNatureSpecialNeedsStream => _getNatureSpecialNeedsResponse.stream;

  NatureSpecialNeedsDialogViewModel(this._getNatureSpecialNeedsUseCase) {
    _getNatureSpecialNeedsRequest.listen((value) {
      RequestManager(value, createCall: () => _getNatureSpecialNeedsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getNatureSpecialNeedsResponse.safeAdd(event);
      });
    });
    getNatureSpecialNeedsList();
  }

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  void getNatureSpecialNeedsList() {
    _getNatureSpecialNeedsRequest.safeAdd(NatureOfSpecialNeedsUseCaseParams());
  }
}
