import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/logout_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DashboardPageViewModel extends BasePageViewModel {
  final LogoutUseCase _logoutUseCase;
  final CheckBioMetricSupportUseCase _checkBioMetricSupportUseCase;
  final AuthenticateBioMetricUseCase _authenticateBioMetricUseCase;

  /// logout request holder
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  /// logout response holder
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  /// logout response stream
  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  /// check whether biometric is supported or not request
  PublishSubject<CheckBioMetricSupportUseCaseParams> _checkBioMetricRequest =
      PublishSubject();

  /// check whether biometric is supported or not response
  BehaviorSubject<Resource<bool>> _checkBioMetricResponse = BehaviorSubject();

  /// check whether biometric is supported or not response stream
  Stream<Resource<bool>> get checkBioMetricStream =>
      _checkBioMetricResponse.stream;

  /// authenticate using biometric request
  PublishSubject<AuthenticateBioMetricUseCaseParams>
      _authenticateBioMetricRequest = PublishSubject();

  /// authenticate using biometric response
  PublishSubject<Resource<bool>> _authenticateBioMetricResponse =
      PublishSubject();

  /// authenticate using biometric response stream
  Stream<Resource<bool>> get authenticateBioMetricStream =>
      _authenticateBioMetricResponse.stream;

  DashboardPageViewModel(this._logoutUseCase,
      this._checkBioMetricSupportUseCase, this._authenticateBioMetricUseCase) {
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

    _checkBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _checkBioMetricSupportUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _checkBioMetricResponse.safeAdd(event);
      });
    });

    _authenticateBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _authenticateBioMetricUseCase.execute(params: value),
      ).asFlow().listen((event) {
        _authenticateBioMetricResponse.safeAdd(event);

        ///TODO:: ADD API CALL HERE INCASE OF ENABLE TRUE
      });
    });

    _checkBioMetricRequest.add(
      CheckBioMetricSupportUseCaseParams(),
    );
  }

  /// Authenticate before set the biometric
  void authenticateBioMetric({String title: "", String localisedReason: ""}) {
    _authenticateBioMetricRequest.safeAdd(
      AuthenticateBioMetricUseCaseParams(
          title: title, localisedReason: localisedReason),
    );
  }

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    _checkBioMetricRequest.close();
    _checkBioMetricResponse.close();
    _authenticateBioMetricRequest.close();
    _authenticateBioMetricResponse.close();
    super.dispose();
  }
}
