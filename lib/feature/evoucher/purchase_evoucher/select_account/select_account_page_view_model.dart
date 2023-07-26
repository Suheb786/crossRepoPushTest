import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/evouchers/select_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../purchase_evoucher_page.dart';

class SelectAccountPageViewModel extends BasePageViewModel {
  final PurchaseEVoucherPageArgument argument;

  final SelectAccountUseCase _selectAccountUseCase;

  ///controllers and keys
  final TextEditingController accountController = TextEditingController();
  final GlobalKey<AppTextFieldState> accountKey = GlobalKey(debugLabel: "account");

  ///select region amount request
  PublishSubject<SelectAccountUseCaseParams> _selectAccountRequest = PublishSubject();

  PublishSubject<Resource<bool>> _selectAccountResponse = PublishSubject();

  Stream<Resource<bool>> get selectAccountStream => _selectAccountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  SelectAccountPageViewModel(this._selectAccountUseCase, this.argument) {
    _selectAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _selectAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _selectAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.SELECT_ACCOUNT:
        accountKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateFields() {
    _selectAccountRequest.safeAdd(SelectAccountUseCaseParams(account: accountController.text));
  }

  void validate() {
    if (accountController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _selectAccountRequest.close();
    _selectAccountResponse.close();
    _showButtonSubject.close();

    super.dispose();
  }
}
