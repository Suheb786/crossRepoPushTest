import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model.dart';
import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:domain/usecase/bill_payment/get_prepaid_categories_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class DenominationsDialogViewModel extends BasePageViewModel {
  final FixedExtentScrollController scrollController =
  FixedExtentScrollController();

  ///current selected index subject
  PublishSubject<int> _currentSelectIndex = PublishSubject();

  ///current selected index stream
  Stream<int> get currentIndexStream => _currentSelectIndex.stream;

  void currentIndexUpdate(int index) {
    _currentSelectIndex.add(index);
  }

  @override
  void dispose() {
    _currentSelectIndex.close();
    super.dispose();
  }
}
