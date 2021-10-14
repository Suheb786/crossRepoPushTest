import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/register/get_additional_income_source_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AdditionIncomeSourceDialogViewModel extends BasePageViewModel {
  final GetAdditionalIncomeSourceUseCase _getAdditionIncomeSourceUseCase;

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  ///get additional income source request subject
  PublishSubject<GetAdditionalIncomeSourceUseCaseParams>
      _getAdditionIncomeSourceRequest = PublishSubject();

  ///get additional income source response holder
  PublishSubject<Resource<List<String>>> _getAdditionIncomeSourceResponse =
      PublishSubject();

  ///get additional income source stream
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

  @override
  void dispose() {
    _currentSelectIndex.close();
    _getAdditionIncomeSourceRequest.close();
    _getAdditionIncomeSourceResponse.close();
    super.dispose();
  }
}
