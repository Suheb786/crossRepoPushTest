import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class MyAccountViewModel extends BasePageViewModel {
  MyAccountViewModel();

  Size deviceSize = Size(0, 0);

  String formatBalance(String balance) {
    if (balance.isEmpty) {
      return "";
    }
    double? balanceValue = double.tryParse(balance);
    if (balanceValue != null) {
      return NumberFormat('#,###.000').format(balanceValue);
    } else {
      return balance;
    }
  }
}
