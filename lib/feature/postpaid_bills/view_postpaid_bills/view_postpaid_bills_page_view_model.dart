import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class ViewPostPaidBillsPageViewModel extends BasePageViewModel {
  final TextEditingController searchBillController = TextEditingController();
  List<ViewPostPaidBillsPageData> viewPostPaidBillsPageDataList = [];

  PublishSubject<List<ViewPostPaidBillsPageData>> _itemSelectedSubject = PublishSubject();

  Stream<List<ViewPostPaidBillsPageData>> get itemSelectedStream => _itemSelectedSubject.stream;

  double calculateTotalDueAmt = 0.0;

  void selectedItem(int index) {
    if (viewPostPaidBillsPageDataList.isNotEmpty) {
      if (viewPostPaidBillsPageDataList[index].isSelected == true) {
        viewPostPaidBillsPageDataList[index].isSelected = false;
        calculateTotalDueAmt = calculateTotalDueAmt - viewPostPaidBillsPageDataList[index].billAmtDue;
        debugPrint('multiple selected $calculateTotalDueAmt');
      } else {
        viewPostPaidBillsPageDataList[index].isSelected = true;
        calculateTotalDueAmt = viewPostPaidBillsPageDataList[index].billAmtDue + calculateTotalDueAmt;
        debugPrint('single selected $calculateTotalDueAmt');
      }
    }

    _itemSelectedSubject.safeAdd(viewPostPaidBillsPageDataList);
  }
}

class ViewPostPaidBillsPageData {
  final String icon;
  final String billType;
  final String billName;
  final double billAmtDue;
  bool isSelected;

  ViewPostPaidBillsPageData(
      {this.icon = '',
      this.billType = '',
      this.billName = '',
      this.billAmtDue = 0.0,
      this.isSelected = false});
}
