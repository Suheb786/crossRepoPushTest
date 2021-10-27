import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class PurposeOfAccountOpeningDialogViewModel extends BasePageViewModel {
  final GetPurposeOfAccountOpeningUseCase _getPurposeOfAccountOpeningUseCase;

  final FixedExtentScrollController scrollController =
      FixedExtentScrollController();

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  ///get purpose of account opening request holder
  PublishSubject<GetPurposeOfAccountOpeningUseCaseParams>
      _getPurposeOfAccountOpeningRequest = PublishSubject();

  ///get purpose of account opening response holder
  PublishSubject<Resource<List<String>>> _getPurposeOfAccountOpeningResponse =
      PublishSubject();

  ///get purpose of account opening stream
  Stream<Resource<List<String>>> get getPurposeOfAccountOpeningStream =>
      _getPurposeOfAccountOpeningResponse.stream;

  PurposeOfAccountOpeningDialogViewModel(
      this._getPurposeOfAccountOpeningUseCase) {
    _getPurposeOfAccountOpeningRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getPurposeOfAccountOpeningUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getPurposeOfAccountOpeningResponse.safeAdd(event);
      });
    });
    getPurposeOfAccountOpeningList();
  }

  void getPurposeOfAccountOpeningList() {
    _getPurposeOfAccountOpeningRequest
        .safeAdd(GetPurposeOfAccountOpeningUseCaseParams());
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    _getPurposeOfAccountOpeningRequest.close();
    _getPurposeOfAccountOpeningResponse.close();
    super.dispose();
  }
}
