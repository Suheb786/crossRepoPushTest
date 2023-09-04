import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/sub_account/account_to_account_transfer_response.dart';
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
  ///*-----------------------------------------------[Variables]----------------------------------------------

  TextEditingController amountTextController = TextEditingController();
  final GlobalKey<AppTextFieldState> amountKey = GlobalKey();

  final AccountToAccountTransferUseCase accountToAccountTransferUseCase;

  ///*---------------------------------[transfer between Account api variable]-----------------------///

  PublishSubject<AccountToAccountTransferUseCaseParams> accountToAccountTransferRequest = PublishSubject();

  BehaviorSubject<Resource<AccountToAccountTransferResponse>> accountToAccountTransferResponse =
      BehaviorSubject();

  Stream<Resource<AccountToAccountTransferResponse>> get accountToAccountTransferResponseStream =>
      accountToAccountTransferResponse.stream;

  final SelectTranferPageArgument argument;

  SelectTransferPageViewModel({required this.argument, required this.accountToAccountTransferUseCase}) {
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

    getInitialvalues();
  }

  void getInitialvalues() {
    allAccountList = argument.allAccountsList;
    addFromAccountData(selectedAccount: argument.selectedAccount);
    filterFromAccountList(selectedAccount: argument.selectedAccount!, isFirstRun: true);
    filterToAccountList(selectedAccount: argument.selectedAccount!);
  }

  List<Account> allAccountList = [];

  ///-----------------------From Account-----------------///
  List<Account> _fromAccountList = [];

  List<Account> get getAllFromList => _fromAccountList;

  BehaviorSubject<Account> _selectedFromAccountSubject = BehaviorSubject();

  Stream<Account> get selectedFromAccountStream => _selectedFromAccountSubject.stream;

  void filterFromAccountList({Account? selectedAccount, bool isFirstRun = false}) {
    if (isFirstRun) {
      _fromAccountList = allAccountList;
    } else {
      _fromAccountList = allAccountList;
      var temp = _fromAccountList;
      _fromAccountList = temp.where((element) => element.accountNo != selectedAccount?.accountNo).toList();
    }
  }

  void addFromAccountData({Account? selectedAccount}) {
    _selectedFromAccountSubject.safeAdd(selectedAccount);
    validateIfEmpty();
  }

  ///-------------------From Account---------------------///

  ///-----------------------To Account-------------------///
  List<Account> _toAccountList = [];

  List<Account> get getAllToAccountList => _toAccountList;

  BehaviorSubject<Account> _selectedToAccountSubject = BehaviorSubject();

  Stream<Account> get selectedToAccountStream => _selectedToAccountSubject.stream;

  Account? selectedToAccount;

  void addToAccountData({required Account selectedAccount}) {
    selectedToAccount = selectedAccount;
    _selectedToAccountSubject.safeAdd(selectedAccount);
    validateIfEmpty();
  }

  void filterToAccountList({required Account selectedAccount}) {
    _toAccountList = allAccountList;
    var temp = _toAccountList;
    _toAccountList = temp.where((element) => element.accountNo != selectedAccount.accountNo).toList();
  }

  ///-------------[button-subject]----------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void accountToAccountTransfer() {
    accountToAccountTransferRequest.safeAdd(AccountToAccountTransferUseCaseParams(
        FromAccount: _selectedFromAccountSubject.value.accountNo,
        ToAccount: _selectedToAccountSubject.value.accountNo,
        TransferAmount: double.parse(amountTextController.value.text),
        GetToken: true,
        fromAccountAvailableBalance:
            double.parse(_selectedFromAccountSubject.value.availableBalance ?? '0')));
  }

  void validateIfEmpty() {
    if (amountTextController.text.isNotEmpty &&
        _selectedFromAccountSubject.hasValue &&
        _selectedToAccountSubject.hasValue) {
      _showButtonSubject.safeAdd(true);
    } else
      _showButtonSubject.safeAdd(false);
  }

  getIntialTrasnferfromAccountDetail(Account? account) {
    _selectedFromAccountSubject.safeAdd(account);
  }

  @override
  void dispose() {
    _selectedFromAccountSubject.close();
    _selectedToAccountSubject.close();
    amountTextController.dispose();
    _showButtonSubject.close();
    super.dispose();
  }
}
