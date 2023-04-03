import 'package:domain/constants/enum/cliq_id_type_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
import 'package:domain/usecase/manage_cliq/cliq_id_type_selection_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/return_rtp_request_otp_usecase.dart';
import 'package:domain/usecase/payment/get_rejection_reason_usecase.dart';
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
  final ReturnRTPrequestOTPUsecase _returnRTPrequestOTPUsecase;

  String returnReasonCode = "";
  final ReturnPaymentTransactionUsecase _returnPaymentTransactionUsecase;
  final GlobalKey<AppTextFieldState> reasonToReturnKey = GlobalKey(debugLabel: "Retrun Reasons");

  PublishSubject<GetRejectionReasonUseCaseParams> _reasonToReturnRequest = PublishSubject();

  PublishSubject<Resource<GetRejectionReasonResponseModel>> _reasonToReturnResponse = PublishSubject();

  Stream<Resource<GetRejectionReasonResponseModel>> get reasonToReturnStream =>
      _reasonToReturnResponse.stream;

  void reasonToReturn() {
    _reasonToReturnRequest.safeAdd(GetRejectionReasonUseCaseParams(GetToken: true));
  }

  ///--------------------------returnRTPrequestOTP-Subjects-------------------------------------///

  PublishSubject<ReturnRTPrequestOTPUsecaseParams> _returnRTPreqeustOTPrequest = PublishSubject();

  PublishSubject<Resource<ReturnRTPRequestOTP>> _returnRTPreqeustOTPresponse = PublishSubject();

  Stream<Resource<ReturnRTPRequestOTP>> get returnRTPrequestOTPstream => _returnRTPreqeustOTPresponse.stream;

  void returnRTPrequestOTP() {
    _returnRTPreqeustOTPrequest.safeAdd(ReturnRTPrequestOTPUsecaseParams(true));
  }

  ///controllers and keys
  final TextEditingController reasonToReturnController = TextEditingController();

  final List<String> returnResonTypeListAr = ["Enemy", "It' a Loan", "I am Richer", "Others"];
  final List<String> returnResonTypeListEn = ["Enemy", "It' a Loan", "I am Richer", "Others"];

  ///validation request and response
  PublishSubject<ReturnPaymentTransactionUsecaseParams> _requestPaymentReasonValidationRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _requestPaymentReasonValidationResponse = PublishSubject();
  final GetRejectionReasonUseCase _getRejectionReasonUseCase;
  ReturnPaymentReasonSelectionPageViewModel(this._returnPaymentTransactionUsecase,
      this._getRejectionReasonUseCase, this._returnRTPrequestOTPUsecase) {
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
    _reasonToReturnRequest.listen((value) {
      RequestManager(value, createCall: () => _getRejectionReasonUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reasonToReturnResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
    reasonToReturn();
    _returnRTPreqeustOTPrequest.listen((value) {
      RequestManager(value, createCall: () => _returnRTPrequestOTPUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        _returnRTPreqeustOTPresponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else {}
      });
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
