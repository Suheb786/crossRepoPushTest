import 'package:domain/error/app_error.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/user/listen_current_user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/di/usecase/user/user_usecase_provider.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class BasePageViewModel extends BaseViewModel {
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

  ListenCurrentUserUseCase? listenCurrentUserUseCase;

  /// listen current user request holder
  final PublishSubject<ListenCurrentUserUseCaseParams>
      _listenCurrentUserRequestSubject = PublishSubject();

  /// listen current user response holder
  final PublishSubject<Resource<Stream<User>>>
      _listenCurrentUserResponseSubject = PublishSubject();

  ///listen current user response stream
  Stream<Resource<Stream<User>>> get listenCurrentUserStream =>
      _listenCurrentUserResponseSubject.stream;

  BasePageViewModel() {
    _listenCurrentUserRequestSubject.listen((listenCurrentUserUseCaseParams) {
      listenCurrentUserUseCase =
          ProviderContainer().read(listenCurrentUserUseCaseProvider);
      RequestManager(listenCurrentUserUseCaseParams, createCall: () {
        return listenCurrentUserUseCase!
            .execute(params: listenCurrentUserUseCaseParams);
      }).asFlow().listen((event) {
        _listenCurrentUserResponseSubject.add(event);
      });
    });
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

  ///get current user
  void getCurrentUserStream() {
    _listenCurrentUserRequestSubject.add(
      ListenCurrentUserUseCaseParams(),
    );
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.safeAdd(false);
    });
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
