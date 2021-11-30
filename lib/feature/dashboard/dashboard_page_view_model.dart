import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DashboardPageViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;

  ///logout request holder
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  ///logout response holder
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  ///logout response stream
  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  DashboardPageViewModel(this._logoutUseCase) {
    _logoutRequest.listen((value) {
      RequestManager(value,
              createCall: () => _logoutUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _logoutResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    super.dispose();
  }
}
