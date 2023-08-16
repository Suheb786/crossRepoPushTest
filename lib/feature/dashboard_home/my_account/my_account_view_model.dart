import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class MyAccountViewModel extends BasePageViewModel {
  MyAccountViewModel();

  Size deviceSize = Size(0, 0);

  String formatBalance(double balance) {
    String formattedBalance = balance.toStringAsFixed(3); // Format with 3 decimal places

    List<String> parts = formattedBalance.split('.');
    String integerPart = parts[0];
    String decimalPart = parts[1];

    // Add commas to the integer part
    String commaSeparatedIntegerPart = '';
    for (int i = integerPart.length - 1, count = 0; i >= 0; i--, count++) {
      if (count != 0 && count % 3 == 0) {
        commaSeparatedIntegerPart = ',' + commaSeparatedIntegerPart;
      }
      commaSeparatedIntegerPart = integerPart[i] + commaSeparatedIntegerPart;
    }

    return '$commaSeparatedIntegerPart.$decimalPart';
  }
}
