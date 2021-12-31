import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:rxdart/subjects.dart';

class CardCancelDialogViewModel extends BasePageViewModel {
  /// stream for listening checkbox value

  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  /// declaring controller

  final TextEditingController reasonCancellationController =
      TextEditingController();

  /// check value for terms & condition

  void updateDeclarationSelection(bool value) {
    _declarationSelected.add(value);
  }

  /// validating fields for reason and check box

  bool isValidateFields() {
    if (reasonCancellationController.text.isEmpty) {
      showToastWithError(AppError(
        error: ErrorInfo(message: ''),
        type: ErrorType.SELECT_CANCELATION_REASON,
        cause: Exception(),
      ));

      return false;
    } else {
      return true;
    }
  }
}
