import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ManageLimitsWidgetViewModel extends BasePageViewModel {
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject();

  TextEditingController controller = TextEditingController();

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  void showErrorToast() {
    showToastWithError(AppError(
        error: ErrorInfo(message: ''),
        type: ErrorType.INVALID_LIMIT_VALUE,
        cause: Exception()));
  }

  @override
  void dispose() {
    //_switchSubject.close();
    super.dispose();
  }
}
