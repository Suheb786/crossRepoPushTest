import 'package:domain/usecase/register/relationship_with_pep_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class RelationshipWithPEPDialogViewModel extends BasePageViewModel {
  final RelationshipWithPEPUseCase _relationshipUseCase;

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  PublishSubject<RelationshipWithPEPUseCaseParams> _relationshipWithPEPRequest =
      PublishSubject();

  PublishSubject<Resource<List<String>>> _relationshipWithPEPResponse =
      PublishSubject();

  Stream<Resource<List<String>>> get getRelationshipWithPEPStream =>
      _relationshipWithPEPResponse.stream;

  RelationshipWithPEPDialogViewModel(this._relationshipUseCase) {
    _relationshipWithPEPRequest.listen((value) {
      RequestManager(value,
              createCall: () => _relationshipUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _relationshipWithPEPResponse.safeAdd(event);
      });
    });
    getRelationshipWithPEPList();
  }

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  void getRelationshipWithPEPList() {
    _relationshipWithPEPRequest.safeAdd(RelationshipWithPEPUseCaseParams());
  }
}
