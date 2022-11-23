import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class PaySelectedBillsPostPaidBillsPageViewModel extends BasePageViewModel {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;
  List<double> totalAmt = [];

  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  PaySelectedBillsPostPaidBillsPageViewModel(this.arguments);

  void newAmtEnter(int index, double value) {
    totalAmt[index] = value;
    arguments.noOfSelectedBills[index].billAmtDue = value;

    _totalBillAmtDueSubject.safeAdd(totalAmt.sum);
  }

  @override
  void dispose() {
    _totalBillAmtDueSubject.close();
    super.dispose();
  }
}
