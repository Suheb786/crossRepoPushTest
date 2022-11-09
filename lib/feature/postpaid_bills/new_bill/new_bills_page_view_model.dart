import 'package:domain/constants/enum/new_bills_type_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class NewBillsPageViewModel extends BasePageViewModel {
  List<NewBillsPageData> newBillsPageDataList = [];
  final TextEditingController searchBillController = TextEditingController();
  String title = '';
  String titleIcon = '';
}

class NewBillsPageData {
  final String icon;
  final String title;
  final NewBillsTypeEnum newBillsTypeEnum;

  NewBillsPageData(this.icon, this.title, this.newBillsTypeEnum);
}
