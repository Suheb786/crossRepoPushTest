import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_details_bill_paymemts_model.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmBillPaymentAmountPageViewModel extends BasePageViewModel {
  ConfirmBillPaymentAmountPageViewModel() {}
  TextEditingController amtController = TextEditingController();

  ///get new details bill payments model
  PublishSubject<AddNewDetailsBillPaymentsModel>
      _addNewDetailsBillPaymentsModelResponse = PublishSubject();

  Stream<AddNewDetailsBillPaymentsModel> get getPurposeResponseStream =>
      _addNewDetailsBillPaymentsModelResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  setData(AddNewDetailsBillPaymentsModel addNewDetailsBillPaymentsModel) {
    _addNewDetailsBillPaymentsModelResponse
        .safeAdd(addNewDetailsBillPaymentsModel);
  }

  validate(String value) {
    if (double.parse(value) > 0.0) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }
}
