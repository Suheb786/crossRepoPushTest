import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class PayMyPrePaidBillsPageViewModel extends BasePageViewModel {
  TextEditingController searchBillController = TextEditingController();
  List<PayMyPrePaidBillsPageData> payMyPrePaidBillsPageDataList = [];
  List<PayMyPrePaidBillsPageData> selectedPrePaidBillsPageDataList = [];
}

class PayMyPrePaidBillsPageData {
  final String icon;
  final String billType;
  final String billName;

  PayMyPrePaidBillsPageData(this.icon, this.billType, this.billName);
}
