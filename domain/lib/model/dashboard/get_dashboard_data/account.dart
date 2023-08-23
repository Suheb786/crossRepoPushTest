import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:flutter/cupertino.dart';

class Account {
  Account(
      {this.accountTitle,
      this.availableBalance,
      this.accountNo,
      this.iban,
      this.cardNo,
      this.isSubAccount,
      this.nickName,
      this.accountStatusEnum = AccountStatusEnum.NONE,
      this.controller}) {
    controller = TextEditingController();
  }

  String? accountTitle;
  String? availableBalance;
  String? accountNo;
  String? iban;
  String? cardNo;
  AccountStatusEnum accountStatusEnum;
  String? nickName;
  bool? isSubAccount;
  TextEditingController? controller;
}
