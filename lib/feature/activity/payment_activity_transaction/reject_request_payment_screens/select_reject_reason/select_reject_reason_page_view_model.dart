import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/model/cliq/reuest_to_pay_result_otp/request_to_pay_result_otp.dart';
import 'package:domain/usecase/activity/reason_to_reject_validation_usecase.dart';
import 'package:domain/usecase/manage_cliq/rejection_reason_inward_usecase.dart';
import 'package:domain/usecase/manage_cliq/request_to_pay_result_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class SelectRejectReasonPageViewModel extends BasePageViewModel {
  final ReasonToRejectValidationUseCase _reasonToRejectValidationUseCase;
  final RejectionReasonInwardUseCase _rejectionReasonInwardUseCase;
  final RequestToPayResultOtpUseCase _requestToPayResultOtpUseCase;

  SelectRejectReasonPageViewModel(this._reasonToRejectValidationUseCase, this._rejectionReasonInwardUseCase,
      this._requestToPayResultOtpUseCase) {
    ///reason to reject validation request
    _reasonToRejectValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _reasonToRejectValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _reasonToRejectValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          getError(event);
        }
      });
    });

    /// reason for reject inward request

    _reasonToRejectRequest.listen((value) {
      RequestManager(value, createCall: () => _rejectionReasonInwardUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reasonToRejectResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
    reasonToReject();

    _rejectOtpRequest.listen(
      (value) {
        RequestManager(value, createCall: () => _requestToPayResultOtpUseCase.execute(params: value))
            .asFlow()
            .listen(
          (event) {
            updateLoader();
            _rejectOtpResponse.safeAdd(event);

            if (event.status == Status.ERROR) {
              showToastWithError(event.appError!);
            }
          },
        );
      },
    );
  }

  void validateUserInput() {
    _reasonToRejectValidationRequest
        .safeAdd(ReasonToRejectValidationUseCaseParams(reason: reasonToRejectController.text));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.REJECT_REASON_TYPE:
        reasonToRejectKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  List<String> reasonToRejectListEn = ['Fail', 'Out of Limited', 'Transaction'];
  List<String> reasonToRejectListAr = ['Fail', 'Out of Limited', 'Transaction'];

  void validate() {
    if (reasonToRejectController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  ///reject reason for inward requet
  PublishSubject<RejectionReasonInwardUseCaseParams> _reasonToRejectRequest = PublishSubject();

  PublishSubject<Resource<List<RejectionReasonInward>>> _reasonToRejectResponse = PublishSubject();

  Stream<Resource<List<RejectionReasonInward>>> get reasonToRejectStream => _reasonToRejectResponse.stream;

  void reasonToReject() {
    _reasonToRejectRequest.safeAdd(RejectionReasonInwardUseCaseParams());
  }

  @override
  void dispose() {
    _rejectOtpRequest.close();
    _rejectOtpResponse.close();
    _reasonToRejectValidationRequest.close();
    _reasonToRejectValidationResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }

  ///*--------------------[reject-otp]---------------------->>>>>>>

  PublishSubject<RequestToPayResultOtpUseCaseParams> _rejectOtpRequest = PublishSubject();

  Stream<Resource<RequestToPayResultOtp>> get rejectOtpStream => _rejectOtpResponse.stream;

  PublishSubject<Resource<RequestToPayResultOtp>> _rejectOtpResponse = PublishSubject();
  String mobileCode = '';
  String mobileNumber = '';

  void makeRejectOtpRequest() {
    _rejectOtpRequest.safeAdd(RequestToPayResultOtpUseCaseParams());
  }

  ///---------------------------------------variables--------------------------------------------------

  final TextEditingController reasonToRejectController = TextEditingController();
  final GlobalKey<AppTextFieldState> reasonToRejectKey = GlobalKey(debugLabel: "reasonToReject");

  String rejectReasonCode = '';

  ///validation request and response
  PublishSubject<ReasonToRejectValidationUseCaseParams> _reasonToRejectValidationRequest = PublishSubject();

  PublishSubject<Resource<bool>> _reasonToRejectValidationResponse = PublishSubject();

  Stream<Resource<bool>> get reasonToRejectValidationStream => _reasonToRejectValidationResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;
}
