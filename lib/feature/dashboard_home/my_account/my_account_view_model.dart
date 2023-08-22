import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class MyAccountViewModel extends BasePageViewModel {
  final TextEditingController nickNameController = TextEditingController();
  final BehaviorSubject<bool> nameEditableNotifierSubject = BehaviorSubject();
  Stream<bool> get nameEditableNotifierStream => nameEditableNotifierSubject.stream;

  toggleNickNameIcon(value) {
    nameEditableNotifierSubject.safeAdd(value);
  }

  MyAccountViewModel();
  Size deviceSize = Size(0, 0);

  @override
  void dispose() {
    nickNameController.dispose();
    super.dispose();
  }
}
