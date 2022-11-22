import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pall_all_postpaid_bills_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class PayAllPostPaidBillsPageViewModel extends BasePageViewModel {
  final PayAllPostPaidBillsPageArguments arguments;

  PayAllPostPaidBillsPageViewModel(this.arguments);

  final TextEditingController searchBillController = TextEditingController();
  List<PallAllPostPaidBillsData> payAllPostPaidBillsDataList = [];

  PublishSubject<List<PallAllPostPaidBillsData>> _itemSelectedSubject = PublishSubject();

  Stream<List<PallAllPostPaidBillsData>> get itemSelectedStream => _itemSelectedSubject.stream;

  PublishSubject<double> _totalBillAmtDueSubject = PublishSubject();

  Stream<double> get totalBillAmtDueStream => _totalBillAmtDueSubject.stream;

  double totalBillAmt = 0.0;

  void selectedItem(int index) {
    if (payAllPostPaidBillsDataList.isNotEmpty) {
      if (payAllPostPaidBillsDataList[index].isSelected == true) {
        payAllPostPaidBillsDataList[index].isSelected = false;
        totalBillAmt = totalBillAmt - payAllPostPaidBillsDataList[index].billAmtDue;
        debugPrint('multiple selected $totalBillAmt');
      } else {
        payAllPostPaidBillsDataList[index].isSelected = true;
        totalBillAmt = totalBillAmt + payAllPostPaidBillsDataList[index].billAmtDue;
      }
    }
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    _itemSelectedSubject.safeAdd(payAllPostPaidBillsDataList);
  }

  void addAllBillAmt() {
    payAllPostPaidBillsDataList.forEach((element) {
      totalBillAmt = element.billAmtDue + totalBillAmt;
    });
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
  }

  void removeItem(int index) {
    // _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    totalBillAmt = totalBillAmt - payAllPostPaidBillsDataList[index].billAmtDue;
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    payAllPostPaidBillsDataList.removeAt(index);
    _totalBillAmtDueSubject.safeAdd(totalBillAmt);
    _itemSelectedSubject.safeAdd(payAllPostPaidBillsDataList);
  }

  @override
  void dispose() {
    _itemSelectedSubject.close();
    super.dispose();
  }
}

class PallAllPostPaidBillsData {
  final String icon;
  final String billType;
  final String billName;
  double billAmtDue;
  bool isSelected;

  PallAllPostPaidBillsData(
      {this.icon = '',
      this.billType = '',
      this.billName = '',
      this.billAmtDue = 0.0,
      this.isSelected = false});
}
