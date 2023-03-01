import 'dart:async';

import 'package:domain/usecase/user/enable_finger_print_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BiometricLoginDialogViewModel extends BasePageViewModel {
  final EnableFingerPrintUseCase _enableFingerPrintUseCase;

  PublishSubject<EnableFingerPrintUseCaseParams> _enableFingerPrintRequest = PublishSubject();

  PublishSubject<Resource<bool>> _enableFingerPrintResponse = PublishSubject();

  Stream<Resource<bool>> get enableFingerPrintStream => _enableFingerPrintResponse.stream;

  BiometricLoginDialogViewModel(this._enableFingerPrintUseCase) {
    _enableFingerPrintRequest.listen((value) {
      RequestManager(value, createCall: () => _enableFingerPrintUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enableFingerPrintResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enableFingerPrint(String cipher) {
    _enableFingerPrintRequest.safeAdd(EnableFingerPrintUseCaseParams(cipher: cipher));
  }

  @override
  void dispose() {
    _enableFingerPrintRequest.close();
    _enableFingerPrintResponse.close();
    super.dispose();
  }
}
