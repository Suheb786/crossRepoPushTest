import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:domain/usecase/register/get_purpose_of_account_opening_usecase.dart';

class PurposeOfAccountOpeningDialogViewModel extends BasePageViewModel {
  final GetPurposeOfAccountOpeningUseCase _getPurposeOfAccountOpeningUseCase;

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PublishSubject<GetPurposeOfAccountOpeningUseCaseParams>
      _getPurposeOfAccountOpeningRequest = PublishSubject();

  PublishSubject<Resource<List<String>>> _getPurposeOfAccountOpeningResponse =
      PublishSubject();

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
}
