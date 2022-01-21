import 'package:domain/constants/error_types.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/model/card/process_loan_request/process_loan_request_response.dart';
import 'package:domain/usecase/apply_credit_card/set_credit_limit_usecase.dart';
import 'package:domain/usecase/card_delivery/get_loan_values_usecase.dart';
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
  final GetLoanValueUseCase _getLoanValueUseCase;

  List<String> percentageList = ["5 %", "25 %", "50 %", "100 %"];

  BehaviorSubject<double> _valueSubject = BehaviorSubject();

  Stream<double> get valueStream => _valueSubject.stream;

  void updatevalue(double value) {
    _valueSubject.safeAdd(value);
  }

  PublishSubject<SliderLimitValues> _sliderValueSubject = PublishSubject();

  Stream<SliderLimitValues> get sliderValueStream => _sliderValueSubject.stream;

  void updateSliderValue(SliderLimitValues value) {
    _sliderValueSubject.safeAdd(value);
  }

  final GlobalKey<AppTextFieldState> minimumSettlementKey =
      GlobalKey(debugLabel: "minimumSettlement");

  final GlobalKey<AppTextFieldState> nickNameKey =
      GlobalKey(debugLabel: "nickName");

  PublishSubject<SetCreditLimitUseCaseParams> _setCreditLimitRequest =
      PublishSubject();

  PublishSubject<Resource<ProcessLoanRequestResponse>> _setCreditLimitResponse =
      PublishSubject();

  Stream<Resource<ProcessLoanRequestResponse>> get setCreditLimitResponse =>
      _setCreditLimitResponse.stream;

  TextEditingController minimumSettlementController = TextEditingController();

  TextEditingController nickNameController = TextEditingController();

  ///get loan value
  PublishSubject<GetLoanValueUseCaseParams> _getLoanValueRequest =
      PublishSubject();

  PublishSubject<Resource<GetLoanValuesResponse>> _getLoanValueResponse =
      PublishSubject();

  Stream<Resource<GetLoanValuesResponse>> get getLoanValueResponse =>
      _getLoanValueResponse.stream;

  SetCreditLimitViewModel(
      this._setCreditLimitUseCase, this._getLoanValueUseCase) {
    _setCreditLimitRequest.listen((value) {
      RequestManager(value,
              createCall: () => _setCreditLimitUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _setCreditLimitResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          if (event.appError!.type ==
              ErrorType.EMPTY_MINIMUM_SETTLEMENT_VALUE) {
            minimumSettlementKey.currentState!.isValid = false;
          }
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
    _getLoanValueRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getLoanValueUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getLoanValueResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateSliderValue(SliderLimitValues(
              divisions: int.parse(event.data!.getLoanValuesContent!.step!),
              maxValue: event.data!.getLoanValuesContent!.maxLimit!.toDouble(),
              minValue: double.parse(
                  event.data!.getLoanValuesContent!.minimumLimit!)));

          updatevalue(double.parse(
              event.data!.getLoanValuesContent!.maxLimit!.toString()));
        }
      });
    });

    getLoanValues();
  }

  void updatedMinimumSettlementValue(String value) {
    minimumSettlementController.text = value;
  }

  void setCreditLimit(num loanValueId) {
    _setCreditLimitRequest.safeAdd(SetCreditLimitUseCaseParams(
        nickName: nickNameController.text,
        limit: _valueSubject.value.toString(),
        minimumSettlement: minimumSettlementController.text.replaceAll('%', ''),
        loanValueId: loanValueId));
  }

  void getLoanValues() {
    _getLoanValueRequest.safeAdd(GetLoanValueUseCaseParams());
  }

  @override
  void dispose() {
    _setCreditLimitResponse.close();
    _setCreditLimitRequest.close();
    super.dispose();
  }
}

class SliderLimitValues {
  final double? minValue;
  final double? maxValue;
  final int? divisions;

  SliderLimitValues(
      {this.minValue: 0.0, this.maxValue: 0.0, this.divisions: 0});
}
