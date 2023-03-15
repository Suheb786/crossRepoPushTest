import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_validation_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:domain/usecase/activity/return_payment_transaction_usecase.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';

class ReturnPaymentReasonSelectionPageViewModel extends BasePageViewModel {
  final GlobalKey<AppTextFieldState> reasonToReturnKey = GlobalKey(debugLabel: "Retrun Reasons");

  ///controllers and keys
  final TextEditingController reasonToReturnController = TextEditingController();

  final List<String> returnResonTypeListAr = ["Enemy", "It' a Loan", "I am Richer", "Others"];
  final List<String> returnResonTypeListEn = ["Enemy", "It' a Loan", "I am Richer", "Others"];

  ///validation request and response
  PublishSubject<ReturnPaymentTransactionUsecaseParams> _requestPaymentReasonValidationRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _requestPaymentReasonValidationResponse = PublishSubject();
  final ReturnPaymentTransactionUsecase _returnPaymentTransactionUsecase;
  ReturnPaymentReasonSelectionPageViewModel(this._returnPaymentTransactionUsecase) {
    _requestPaymentReasonValidationRequest.listen((params) {
      RequestManager(params, createCall: () => _returnPaymentTransactionUsecase.execute(params: params))
          .asFlow()
          .listen(
        (event) {
          _requestPaymentReasonValidationResponse.safeAdd(event);
          if (event.status == Status.ERROR) {
            showErrorState();
            showToastWithError(event.appError!);
          } else {}
        },
      );
    });
  }

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<Resource<bool>> get requestPaymentReasonValidationStream =>
      _requestPaymentReasonValidationResponse.stream;

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validateSelectedReason() {
    _requestPaymentReasonValidationRequest
        .safeAdd(ReturnPaymentTransactionUsecaseParams(returnReason: reasonToReturnController.text));
  }

  void validate() {
    if (reasonToReturnController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_VERIFY_INFO_DECLARATION_SELECTION:
        reasonToReturnKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }
}
