import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/subjects.dart';

class IdWiseIntialPageViewModel extends BasePageViewModel {
  ScrollController scrollController = ScrollController();

  ///checkBox Subject
  BehaviorSubject<bool> isChecked = BehaviorSubject();
  Stream<bool> get checkBoxStream => isChecked.stream;

  //button Subject
  BehaviorSubject<bool> isButtonVisible = BehaviorSubject();
  Stream<bool> get buttonStream => isButtonVisible.stream;

  void checkBoxToggle(bool value) {
    isChecked.safeAdd(value);
    buttonVisibilty(!value);
  }

  void buttonVisibilty(bool value) {
    if (isChecked.value == value) {
      isButtonVisible.safeAdd(value);
    }
  }
}
