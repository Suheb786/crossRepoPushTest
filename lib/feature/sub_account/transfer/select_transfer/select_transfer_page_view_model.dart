import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/usecase/sub_account/add_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/sub_account/transfer/select_transfer/select_transfer_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../base/base_page_view_model.dart';
import '../../../../generated/l10n.dart';
import '../../../../ui/molecules/textfield/app_textfield.dart';
import '../../../../utils/request_manager.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';

class SelectTransferPageViewModel extends BasePageViewModel {
//*-----------------------------------------------[Variables]----------------------------------------------

  TextEditingController amountTextController = TextEditingController();
  final GlobalKey<AppTextFieldState> amountKey = GlobalKey();

  final AccountToAccountTransferUseCase accountToAccountTransferUseCase;

//*---------------------------------[transfer between Account api variable]-----------------------///

  PublishSubject<AccountToAccountTransferUseCaseParams> accountToAccountTransferRequest = PublishSubject();

  BehaviorSubject<Resource<bool>> accountToAccountTransferResponse = BehaviorSubject();

  Stream<Resource<bool>> get accountToAccountTransferResponseStream =>
      accountToAccountTransferResponse.stream;

  final SelectTranferPageArgument argument;
  SelectTransferPageViewModel({
    required this.argument,
    required this.accountToAccountTransferUseCase,
  }) {
    accountToAccountTransferRequest.listen((value) {
      RequestManager(value, createCall: () => accountToAccountTransferUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        accountToAccountTransferResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }

  ///-------------[account-details-dummy-lists]----------------///
  ///----> dummy lists need to remove after api integration ---->
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

  void accountToAccountTransfer() {
    accountToAccountTransferRequest.safeAdd(AccountToAccountTransferUseCaseParams(
        FromAccount: transferFromAccountDetailsResponse.value.accountNo,
        ToAccount: transferToAccountDetailsResponse.value.accountNo,
        TransferAmount: double.parse(amountTextController.value.text),
        GetToken: true));
  }

  void validateIfEmpty() {
    if (amountTextController.text != "" &&
        transferFromAccountDetailsResponse.hasValue &&
        transferToAccountDetailsResponse.hasValue) {
      _showButtonSubject.safeAdd(true);
    } else
      _showButtonSubject.safeAdd(false);
  }

  // String formatBalance(String balance) {
  //   if (balance.isEmpty) {
  //     return "";
  //   }
  //   double? balanceValue = double.tryParse(balance);
  //   if (balanceValue != null) {
  //     return NumberFormat('#,###.000').format(balanceValue);
  //   } else {
  //     return balance;
  //   }
  // }

  void validForm(BuildContext ctx) {
    if (double.parse(
            removeCommasFromNumberString(transferFromAccountDetailsResponse.value.availableBalance!)) <
        double.parse(removeCommasFromNumberString(amountTextController.text))) {
      amountKey.currentState?.isValid = false;
      showToastWithErrorString(S.current.insufficientBalanceTransfer);
    } else {
      accountToAccountTransfer();
    }
  }

  // void formatAmount(value) {
  //   if (value.isNotEmpty) {
  //     double numericValue = double.tryParse(value.replaceAll(',', '')) ?? 0.0;
  //     String formattedValue = NumberFormat('#,###.000').format(numericValue);
  //     // String formattedValueWithJOD = formattedValue + " " + "JOD";
  //     amountTextController.value = TextEditingValue(
  //       text: formattedValue,
  //       selection: TextSelection.collapsed(offset: formattedValue.length),
  //     );
  //   }
  //   validateIfEmpty();
  // }

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
    if (argument.allAccountNumbers!.contains(account.accountNo)) {
      transferFromAccountDetailsResponse.safeAdd(argument.account);
      return account;
    }
    transferFromAccountDetailsResponse.safeAdd(argument.account);
    return account;
    // transferFromAccountDetailsResponse.safeAdd(argument.account);
  }

  getNonSelectedAccountNumberTransferFromList() {
    List<String> updatedTransferFromList = List.from(argument.allAccountNumbers ?? []);
    if (transferToAccountDetailsResponse.hasValue) {
      String? selectedTransferToAccount = transferToAccountDetailsResponse.value.accountNo;
      if (updatedTransferFromList.contains(selectedTransferToAccount)) {
        updatedTransferFromList.remove(selectedTransferToAccount);
      }
      return updatedTransferFromList;
    }
    return argument.allAccountNumbers;
  }

  getNonSelectedAccountTitleTransferFromList() {
    List<String> updatedTransferFromList = List.from(argument.allAccountTitles ?? []);
    if (transferToAccountDetailsResponse.hasValue) {
      String? selectedTransferToAccount = transferToAccountDetailsResponse.value.accountTitle;
      if (updatedTransferFromList.contains(selectedTransferToAccount)) {
        updatedTransferFromList.remove(selectedTransferToAccount);
      }
      return updatedTransferFromList;
    } else {
      return argument.allAccountTitles;
    }
  }

  getNonSelectedAvailableBalanceTransferFromList() {
    List<String> updatedTransferFromList = List.from(argument.allAvailableBalances ?? []);
    if (transferToAccountDetailsResponse.hasValue) {
      String? selectedTransferToAccount = transferToAccountDetailsResponse.value.availableBalance;
      if (updatedTransferFromList.contains(selectedTransferToAccount)) {
        updatedTransferFromList.remove(selectedTransferToAccount);
      }
      return updatedTransferFromList;
    }
    return argument.allAvailableBalances;
  }

  getNonSelectedAccountNumberTransferToList() {
    List<String> updatedAccountNumbersList = List.from(argument.allAccountNumbers ?? []);
    String? selectedAccount = transferFromAccountDetailsResponse.value.accountNo;

    if (updatedAccountNumbersList.contains(selectedAccount)) {
      updatedAccountNumbersList.remove(selectedAccount);
    }
    return updatedAccountNumbersList;
  }

  getNonSelectedAccountNameTransferToList() {
    List<String> updatedAccountNameList = List.from(argument.allAccountTitles ?? []);
    String? selectedAccount = transferFromAccountDetailsResponse.value.accountTitle;

    if (updatedAccountNameList.contains(selectedAccount)) {
      updatedAccountNameList.remove(selectedAccount);
    }
    return updatedAccountNameList;
  }

  getNonSelectedavailableAmountTansferToList() {
    List<String> updatedAvailableAmountList = List.from(argument.allAvailableBalances ?? []);
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
