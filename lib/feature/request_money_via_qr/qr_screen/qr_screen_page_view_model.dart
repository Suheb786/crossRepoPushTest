import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page.dart';

class QrScreenPageViewModel extends BasePageViewModel {
  final QrScreenPageArguments arguments;

  QrScreenPageViewModel(this.arguments);

  GlobalKey globalKey = new GlobalKey();
}
