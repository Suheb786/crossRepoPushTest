import 'package:domain/model/kyc/check_kyc_response.dart';
import 'package:domain/usecase/kyc/check_kyc_status_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import 'change_device_success_page.dart';

class ChangeDeviceSuccessPageViewModel extends BasePageViewModel {
  final CheckKYCStatusUseCase _kycStatusUseCase;

  ///kyc status request
  PublishSubject<CheckKYCStatusUseCaseParams> _kycStatusRequest = PublishSubject();

  ///kyc status response
  PublishSubject<Resource<CheckKycResponse>> _kycStatusResponse = PublishSubject();

  ///kyc status response stream
  Stream<Resource<CheckKycResponse>> get kycStatusStream => _kycStatusResponse.stream;

  late ChangeDeviceParams arguments;

  ChangeDeviceSuccessPageViewModel(this._kycStatusUseCase) {
    _kycStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _kycStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _kycStatusResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void checkKycStatus() {
    _kycStatusRequest.safeAdd(CheckKYCStatusUseCaseParams());
  }
}
