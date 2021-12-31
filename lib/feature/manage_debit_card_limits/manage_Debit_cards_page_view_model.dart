import 'package:domain/usecase/manage_card_limits/manage_debit_card_limits_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageDebitCardLimitsPageViewModel extends BasePageViewModel {
  PublishSubject<Resource<bool>> _manageCardLimitResponseSubject =
      PublishSubject();

  PublishSubject<ManageDebitCardLimitUseCaseParams>
      _manageCardLimitRequestSubject = PublishSubject();

  final ManageDebitCardLimitUseCase _manageCardLimitUseCase;

  ManageDebitCardLimitsPageViewModel(this._manageCardLimitUseCase) {
    _manageCardLimitRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _manageCardLimitUseCase.execute(params: value);
      }).asFlow().listen((event) {
        updateLoader();
        _manageCardLimitResponseSubject.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  @override
  void dispose() {
    _manageCardLimitRequestSubject.close();

    super.dispose();
  }
}
