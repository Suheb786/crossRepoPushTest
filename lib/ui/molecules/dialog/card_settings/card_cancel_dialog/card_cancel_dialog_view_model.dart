import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:rxdart/subjects.dart';

class CardCancelDialogViewModel extends BasePageViewModel {
  /// stream for listening checkbox value

  BehaviorSubject<bool> declarationSelected = BehaviorSubject.seeded(false);

  Stream<bool> get declarationSelectedStream => declarationSelected.stream;

  bool isSelected = false;

  /// reason controller
  final TextEditingController reasonCancellationController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> reasonKey =
      GlobalKey(debugLabel: "reason-Key");

  /// update terms & condition value
  void updateDeclarationSelection(bool value) {
    declarationSelected.add(value);
  }
}
