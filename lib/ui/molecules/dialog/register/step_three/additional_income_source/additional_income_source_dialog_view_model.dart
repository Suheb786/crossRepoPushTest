import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AdditionIncomeSourceDialogViewModel extends BasePageViewModel {
  final GetAdditionalIncomeSourceUseCase _getAdditionIncomeSourceUseCase;

  int currentIndex = 0;
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  PublishSubject<GetAdditionalIncomeSourceUseCaseParams>
      _getAdditionIncomeSourceRequest = PublishSubject();

  PublishSubject<Resource<List<String>>> _getAdditionIncomeSourceResponse =
      PublishSubject();

  Stream<Resource<List<String>>> get getAdditionIncomeSourceStream =>
      _getAdditionIncomeSourceResponse.stream;

  AdditionIncomeSourceDialogViewModel(this._getAdditionIncomeSourceUseCase) {
    _getAdditionIncomeSourceRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getAdditionIncomeSourceUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAdditionIncomeSourceResponse.safeAdd(event);
      });
    });
    getAdditionIncomeSourceList();
  }

  void getAdditionIncomeSourceList() {
    _getAdditionIncomeSourceRequest
        .safeAdd(GetAdditionalIncomeSourceUseCaseParams());
  }
}
