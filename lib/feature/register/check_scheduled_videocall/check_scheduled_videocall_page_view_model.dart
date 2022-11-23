import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CheckScheduledVideoCallPageViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;
  final CheckVideoCallScheduledArguments callScheduledArguments;

  ///logout
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  CheckScheduledVideoCallPageViewModel(this._logoutUseCase, this.callScheduledArguments) {
    _logoutRequest.listen((value) {
      RequestManager(value, createCall: () => _logoutUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void logOutUser() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }
}
