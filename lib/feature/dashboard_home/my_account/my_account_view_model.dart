import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class MyAccountViewModel extends BasePageViewModel {
  MyAccountViewModel();

  Size deviceSize = Size(0, 0);

  String formatBalance(double balance) {
    return NumberFormat('#,###.###').format(balance);
  }
}
  

