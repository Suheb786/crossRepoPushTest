import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../base/base_page_view_model.dart';
import '../../../../main/navigation/route_paths.dart';
import '../../../../ui/molecules/textfield/transfer_account_textfield.dart';
import '../transfer_success/transfer_success_page.dart';

class SelectTransferPageViewModel extends BasePageViewModel {
//*-----------------------------------------------[Variables]----------------------------------------------

  TextEditingController amountTextController = TextEditingController();
  final GlobalKey<TransferAccountTextFieldState> transferFromKey = GlobalKey();
  final GlobalKey<TransferAccountTextFieldState> transferToKey = GlobalKey();

  final SelectTranferPageArgument argument;
  SelectTransferPageViewModel({required this.argument});

  ///-------------[account-details-lists]----------------///

  List<String> accountNameList = [
    "Main Account 1 - Primary",
    "Sub Account - Savings",
    "Main Account 2 - Primary"
  ];
  List<String> accountNumberList = ["9869868", "8986808", "3369856"];
  List<String> availableAmountList = ["8769", "900", "555"];

  ///-------------[button-subject]----------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///-------------[update-Account-Details-subject]----------------///

  BehaviorSubject<Account> transferFromAccountDetailsResponse = BehaviorSubject();
  Stream<Account> get transferFromAccountDetailsStream => transferFromAccountDetailsResponse.stream;

  BehaviorSubject<Account> transferToAccountDetailsResponse = BehaviorSubject();
  Stream<Account> get transferToAccountDetailsStream => transferToAccountDetailsResponse.stream;

  bool get isValid => _isValid;
  bool _isValid = true;

//*-----------------------------------------------[Methods]----------------------------------------------

  void validateIfEmpty() {
    if (amountTextController.text != "" &&
        transferFromAccountDetailsResponse.hasValue &&
        transferToAccountDetailsResponse.hasValue) {
      _showButtonSubject.safeAdd(true);
    } else
      _showButtonSubject.safeAdd(false);
  }

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

  void validButton(BuildContext ctx) {
    if (transferFromAccountDetailsResponse.value.accountNo ==
        transferToAccountDetailsResponse.value.accountNo) {
      transferFromKey.currentState?.isValid = false;
      transferToKey.currentState?.isValid = false;
      showToastWithErrorString("Can not transfer money to same account number");
    } else {
      Navigator.pushNamed(
        ctx,
        RoutePaths.TransferSuccessPage,
        arguments: TransferSuccessPageArgument(
            amount: amountTextController.text, account: transferToAccountDetailsResponse.value),
      );
    }
  }

  void isSatisfied() {
    if (transferFromKey.currentState?.isValid == false || transferToKey.currentState?.isValid == false) {
      transferFromKey.currentState?.isValid = true;
      transferToKey.currentState?.isValid = true;
    }
    transferFromKey.currentState?.isValid = true;
  }

  void formatAmount(value) {
    if (value.isNotEmpty) {
      double numericValue = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
      String formattedValue = NumberFormat('#,###.000').format(numericValue);
      // String formattedValueWithJOD = formattedValue + " " + "JOD";
      amountTextController.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }
    validateIfEmpty();
  }

  String removeCommasFromNumberString(String formattedNumber) {
    return formattedNumber.replaceAll(',', '');
  }

  void updateTransferFromAccount(Account value) {
    Account(accountNo: value.accountNo);
    transferFromAccountDetailsResponse.safeAdd(value);
  }

  void updateTransferToAccount(Account value) {
    Account(accountNo: value.accountNo);
    transferToAccountDetailsResponse.safeAdd(value);
  }

  getIntialTrasnferfromAccountDetail(Account account) {
    if (accountNumberList.contains(account.accountNo)) {
      return account;
    }
  }

  getNonSelectedAccountNumberList() {
    List<String> updatedAccountNumbersList = List.from(accountNumberList);
    String? selectedAccount = transferFromAccountDetailsResponse.value.accountNo;

    if (updatedAccountNumbersList.contains(selectedAccount)) {
      argument.account.accountNo = selectedAccount;
      updatedAccountNumbersList.remove(selectedAccount);
    }
    return updatedAccountNumbersList;
  }

  getNonSelectedAccountNameList() {
    List<String> updatedAccountNameList = List.from(accountNameList);
    String? selectedAccount = transferFromAccountDetailsResponse.value.accountTitle;

    if (updatedAccountNameList.contains(selectedAccount)) {
      updatedAccountNameList.remove(selectedAccount);
    }
    return updatedAccountNameList;
  }

  getNonSelectedavailableAmountList() {
    List<String> updatedAvailableAmountList = List.from(availableAmountList);
    String? selectedAccount = transferFromAccountDetailsResponse.value.availableBalance;

    if (updatedAvailableAmountList.contains(selectedAccount)) {
      updatedAvailableAmountList.remove(selectedAccount);
    }
    return updatedAvailableAmountList;
  }

//*-----------------------------------------------[disposed variables]----------------------------------------------

  @override
  void dispose() {
    transferFromAccountDetailsResponse.close();
    transferToAccountDetailsResponse.close();
    amountTextController.dispose();
    super.dispose();
  }
}
