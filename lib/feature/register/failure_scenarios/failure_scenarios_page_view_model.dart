import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base/base_page_view_model.dart';
import '../../../utils/request_manager.dart';
import '../../../utils/resource.dart';
import '../../../utils/status.dart';
import 'failure_scenarios_page.dart';

class OnboardingFailureScenariosPageViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;

  late OnboardingFailureScenarioArgument argument;

  ///---------------logout response ------------------------///
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  OnboardingFailureScenariosPageViewModel(this._logoutUseCase) {
    _logoutRequest.listen((value) {
      RequestManager(value, createCall: () => _logoutUseCase.execute(params: value)).asFlow().listen((event) {
        updateLoader();
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    super.dispose();
  }
}
