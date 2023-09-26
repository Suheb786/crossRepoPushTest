import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_by_denomination_amount/purchase_by_denomination_amount_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/subjects.dart';

class PurchaseByDenominationAmountPageViewModel extends BasePageViewModel {
  PurchaseByDenominationAmountPageArgument argument;

  TextEditingController textController = TextEditingController();

  PurchaseByDenominationAmountPageViewModel(this.argument) {
    setInitialData();
  }

  /// ------------- voucher filter stream -----------------------

  List<VoucherItem> filterList = [];

  BehaviorSubject<List<VoucherItem>> voucherFilterResponseSubject = BehaviorSubject();

  Stream<List<VoucherItem>> get voucherFilterResponseStream => voucherFilterResponseSubject.stream;

  void searchItems() {
    if (textController.text.trim().isEmpty) {
      voucherFilterResponseSubject.safeAdd(filterList);
    } else {
      List<VoucherItem> searchedItems = filterList
          .where((element) => element.name.toLowerCase().contains(textController.text.toLowerCase().trim()))
          .toList();
      voucherFilterResponseSubject.safeAdd(searchedItems);
    }
  }

  setInitialData() {
    voucherFilterResponseSubject.safeAdd(argument.voucherItems);
    filterList = argument.voucherItems;
  }
}
