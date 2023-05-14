import 'package:domain/model/user/generate_key_pair/generate_key_pair_response.dart';
import 'package:domain/model/user/logout/logout_response.dart';
import 'package:domain/usecase/user/authenticate_bio_metric_usecase.dart';
import 'package:domain/usecase/user/check_bio_metric_support_use_case.dart';
import 'package:domain/usecase/user/enable_biometric_usecase.dart';
import 'package:domain/usecase/user/generate_key_pair_usecase.dart';
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
  final GenerateKeyPairUseCase _generateKeyPairUseCase;
  final EnableBiometricUseCase _enableBiometricUseCase;

  /// logout request holder
  PublishSubject<LogoutUseCaseParams> _logoutRequest = PublishSubject();

  /// logout response holder
  PublishSubject<Resource<LogoutResponse>> _logoutResponse = PublishSubject();

  /// logout response stream
  Stream<Resource<LogoutResponse>> get logoutStream => _logoutResponse.stream;

  /// check whether biometric is supported or not request
  PublishSubject<CheckBioMetricSupportUseCaseParams> _checkBioMetricRequest = PublishSubject();

  /// check whether biometric is supported or not response
  BehaviorSubject<Resource<bool>> _checkBioMetricResponse = BehaviorSubject();

  /// check whether biometric is supported or not response stream
  Stream<Resource<bool>> get checkBioMetricStream => _checkBioMetricResponse.stream;

  /// authenticate using biometric request
  PublishSubject<AuthenticateBioMetricUseCaseParams> _authenticateBioMetricRequest = PublishSubject();

  /// authenticate using biometric response
  PublishSubject<Resource<bool>> _authenticateBioMetricResponse = PublishSubject();

  /// authenticate using biometric response stream
  Stream<Resource<bool>> get authenticateBioMetricStream => _authenticateBioMetricResponse.stream;

  /// generate key pair request
  PublishSubject<GenerateKeyPairUseCaseParams> _generateKeyPairRequest = PublishSubject();

  /// generate key pair response
  PublishSubject<Resource<GenerateKeyPairResponse>> _generateKeyPairResponse = PublishSubject();

  /// generate key pair response stream
  Stream<Resource<GenerateKeyPairResponse>> get generateKeyPairStream => _generateKeyPairResponse.stream;

  /// enable biometric request
  PublishSubject<EnableBiometricUseCaseParams> _enableBiometricRequest = PublishSubject();

  /// enable biometric response
  PublishSubject<Resource<bool>> _enableBiometricResponse = PublishSubject();

  /// enable biometric response stream
  Stream<Resource<bool>> get enableBiometricStream => _enableBiometricResponse.stream;

  DashboardPageViewModel(this._logoutUseCase, this._checkBioMetricSupportUseCase,
      this._authenticateBioMetricUseCase, this._generateKeyPairUseCase, this._enableBiometricUseCase) {
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

    _checkBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _checkBioMetricSupportUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _checkBioMetricResponse.safeAdd(event);
      });
    });

    _authenticateBioMetricRequest.listen((value) {
      RequestManager<bool>(
        value,
        createCall: () => _authenticateBioMetricUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _authenticateBioMetricResponse.safeAdd(event);
      });
    });

    _generateKeyPairRequest.listen((value) {
      RequestManager(value, createCall: () => _generateKeyPairUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _generateKeyPairResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _enableBiometricRequest.listen((value) {
      RequestManager(value, createCall: () => _enableBiometricUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enableBiometricResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _checkBioMetricRequest.add(
      CheckBioMetricSupportUseCaseParams(),
    );
  }

  /// Authenticate before set the biometric
  void authenticateBioMetric({String title = "", String localisedReason = ""}) {
    _authenticateBioMetricRequest.safeAdd(
      AuthenticateBioMetricUseCaseParams(title: title, localisedReason: localisedReason),
    );
  }

  void logout() {
    _logoutRequest.safeAdd(LogoutUseCaseParams());
  }

  void generateKeyPair() {
    _generateKeyPairRequest.safeAdd(GenerateKeyPairUseCaseParams());
  }

  void enableBiometric() {
    _enableBiometricRequest.safeAdd(EnableBiometricUseCaseParams());
  }

  @override
  void dispose() {
    _logoutRequest.close();
    _logoutResponse.close();
    _checkBioMetricRequest.close();
    _checkBioMetricResponse.close();
    _authenticateBioMetricRequest.close();
    _authenticateBioMetricResponse.close();
    _generateKeyPairRequest.close();
    _generateKeyPairResponse.close();
    _enableBiometricRequest.close();
    _enableBiometricResponse.close();
    super.dispose();
  }
}
