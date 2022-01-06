import 'package:domain/usecase/apply_credit_card/set_credit_limit_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SetCreditLimitViewModel extends BasePageViewModel {
  SetCreditLimitUseCase _setCreditLimitUseCase;

  List<String> percentageList = [
    "3 %",
    "5 %",
    "7 %",
    "10 %",
    "12 %",
  ];

  final GlobalKey<AppTextFieldState> minimumSettlementKey =
      GlobalKey(debugLabel: "minimumSettlement");

  final GlobalKey<AppTextFieldState> nickNameKey =
      GlobalKey(debugLabel: "nickName");

  PublishSubject<SetCreditLimitUseCaseParams> _setCreditLimitRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _setCreditLimitResponse = PublishSubject();

  Stream<Resource<bool>> get setCreditLimitResponse =>
      _setCreditLimitResponse.stream;

  TextEditingController minimumSettlementController = TextEditingController();

  TextEditingController nickNameController = TextEditingController();

  SetCreditLimitViewModel(this._setCreditLimitUseCase) {
    _setCreditLimitRequest.listen((value) {
      RequestManager(value,
              createCall: () => _setCreditLimitUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _setCreditLimitResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void updatedMinimumSettlementValue(String value) {
    minimumSettlementController.text = value;
  }

  void setCreditLimit() {
    _setCreditLimitRequest.safeAdd(SetCreditLimitUseCaseParams(
        nickName: nickNameController.text,
        limit: "1000",
        minimumSettlement: minimumSettlementController.text));
  }

  @override
  void dispose() {
    _setCreditLimitResponse.close();
    _setCreditLimitRequest.close();
    super.dispose();
  }
}
