import 'package:domain/model/account/check_existing_call_status.dart';
import 'package:domain/usecase/account/check_existing_call_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class VideoCallInformationPageViewModel extends BasePageViewModel {
  final CheckExistingCallUseCase _checkExistingCallUseCase;

  PublishSubject<CheckExistingCallUseCaseParams> _checkExistingCallRequest =
      PublishSubject();
  PublishSubject<Resource<CheckExistingCallStatus>> _checkExistingCallResponse =
      PublishSubject();

  Stream<Resource<CheckExistingCallStatus>> get checkExistingCall =>
      _checkExistingCallResponse.stream;

  VideoCallInformationPageViewModel(this._checkExistingCallUseCase) {
    _checkExistingCallRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkExistingCallUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkExistingCallResponse.safeAdd(event);
      });
    });

    checkExistingScheduledCall();
  }

  void checkExistingScheduledCall() {
    _checkExistingCallRequest.safeAdd(CheckExistingCallUseCaseParams());
  }
}
