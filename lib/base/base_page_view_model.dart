import 'package:domain/error/app_error.dart';
import 'package:neo_bank/base/base_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class BasePageViewModel extends BaseViewModel {
  PublishSubject<AppError> _error = PublishSubject<AppError>();
  PublishSubject<String> _toast = PublishSubject<String>();

  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  Stream<AppError> get error => _error.stream;

  Stream<String> get toast => _toast.stream;

  void showToastWithError(AppError error) {
    _error.sink.add(error);
  }

  void showToastWithString(String message) {
    _toast.sink.add(message);
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

  @override
  void dispose() {
    _error.close();
    _toast.close();
    _errorDetectorSubject.close();
    super.dispose();
  }
}
