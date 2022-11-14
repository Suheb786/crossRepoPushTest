import 'dart:isolate';

import 'package:domain/error/app_error.dart';
import 'package:domain/usecase/app_flyer/log_app_flyers_events.dart';
import 'package:domain/usecase/apple_pay/initialize_antelop_usecase.dart';
import 'package:domain/usecase/infobip_audio/save_user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/di/usecase/app_flyer/app_flyer_usecase-provider.dart';
import 'package:neo_bank/di/usecase/apple_pay/apple_pay_usecase_provider.dart';
import 'package:neo_bank/di/usecase/help_center/help_center_usecase_provider.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class BasePageViewModel extends BaseViewModel {
  late SaveUserUseCase saveUserUseCase;
  late LogAppFlyerSDKEventsUseCase appFlyerSDKEventsUseCase;
  late InitializeAntelopUseCase initializeAntelopUseCase;
  PublishSubject<AppError> _error = PublishSubject<AppError>();
  PublishSubject<String> _toast = PublishSubject<String>();

  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  BehaviorSubject<bool> _isFlippedSubject = BehaviorSubject.seeded(false);

  Stream<bool> get isFlippedStream => _isFlippedSubject.stream;

  ///success subject
  PublishSubject<String> _successSubject = PublishSubject<String>();

  Stream<String> get successStream => _successSubject.stream;

  Stream<AppError> get error => _error.stream;

  Stream<String> get toast => _toast.stream;

  final PublishSubject<bool> _loading = PublishSubject();

  Stream<bool> get loadingStream => _loading.stream;

  bool _isLoading = false;

  ///save user
  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject = PublishSubject();

  ///---------------log app flyers events------------------///
  PublishSubject<LogAppFlyerSDKEventsUseCaseParams> _logAppFlyerSDKEventsRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _logAppFlyerSDKEventsResponseSubject = PublishSubject();

  Stream<Resource<bool>> get logAppFlyerSDKEventsStream => _logAppFlyerSDKEventsResponseSubject.stream;

  void logEventsForAppFlyer({required String eventName, required Map eventValue}) async {
    _logAppFlyerSDKEventsRequestSubject
        .safeAdd(LogAppFlyerSDKEventsUseCaseParams(eventName: eventName, eventValue: eventValue));
  }

  ///---------------log app flyers events------------------///

  ///------------------Isolate for apple pay initialization-----------///

  late ReceivePort receivePort;
  Isolate? isolate;

  PublishSubject<InitializeAntelopUseCaseParams> _antelopInitializeRequest = PublishSubject();

  PublishSubject<Resource<bool>> _antelopInitializeResponse = PublishSubject();

  Stream<Resource<bool>> get antelopInitializeStream => _antelopInitializeResponse.stream;

  /// ISOLATE
  void antelopSdkInitialize() async {
    if (isolate != null) {
      return;
    }
    try {
      receivePort = ReceivePort();
      isolate = await Isolate.spawn(_getTokenCallBack, receivePort.sendPort);
      receivePort.listen(_handleMessage, onDone: () {});
    } on Exception catch (e) {
      debugPrint("Error from ISOLATE " + e.toString());
    }
  }

  void _handleMessage(message) {
    _antelopInitializeRequest.safeAdd(InitializeAntelopUseCaseParams());
  }

  static void _getTokenCallBack(SendPort sendPort) async {
    sendPort.send('Send');
  }

  ///------------------Isolate for apple pay initialization-----------///

  BasePageViewModel() {
    _saveUserRequestSubject.listen((params) {
      saveUserUseCase = ProviderContainer().read(saveUserUseCaseProvider);
      RequestManager(params, createCall: () {
        return saveUserUseCase.execute(params: params);
      }).asFlow().listen((event) {});
    });

    _logAppFlyerSDKEventsRequestSubject.listen((params) {
      appFlyerSDKEventsUseCase = ProviderContainer().read(logAppFlyerEventUseCaseProvider);
      RequestManager(params, createCall: () {
        return appFlyerSDKEventsUseCase.execute(params: params);
      }).asFlow().listen((event) {
        _logAppFlyerSDKEventsResponseSubject.safeAdd(event);
      });
    });

    _antelopInitializeRequest.listen(
      (params) {
        initializeAntelopUseCase = ProviderContainer().read(initializeAntelopSDKUseCaseProvider);
        RequestManager(params, createCall: () => initializeAntelopUseCase.execute(params: params))
            .asFlow()
            .listen((event) {
          _antelopInitializeResponse.safeAdd(event);
        });
      },
    );
  }

  void showToastWithError(AppError error) {
    _error.sink.add(error);
  }

  void showToastWithString(String message) {
    _toast.sink.add(message);
  }

  void updateFlipValue(bool value) {
    _isFlippedSubject.safeAdd(value);
    notify();
  }

  void showSuccessToast(String success) {
    _successSubject.sink.add(success);
  }

  void notify() {
    notifyListeners();
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }

  void saveUserData() {
    _saveUserRequestSubject.safeAdd(SaveUserUseCaseParams());
  }

  void updateLoader() {
    if (!_isLoading) {
      _isLoading = true;
      _loading.safeAdd(true);
    } else {
      _isLoading = false;
      _loading.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _error.close();
    _toast.close();
    _errorDetectorSubject.close();
    _isFlippedSubject.close();
    _successSubject.close();
    _loading.close();
    super.dispose();
  }
}
