import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:rxdart/rxdart.dart';

class LinkBankAccountCliqIdPageViewModel extends BasePageViewModel {
  final ScrollController controller = ScrollController();
  List<LinkBankAccountData> linkBankAccountCliqIdList = [];

  PublishSubject<List<LinkBankAccountData>> _linkBankAccountCliqIdListRequest = PublishSubject();

  Stream<List<LinkBankAccountData>> get linkBankAccountCliqIdListStream =>
      _linkBankAccountCliqIdListRequest.stream;

  void updateLinkAccount(LinkBankAccountData data) {
    linkBankAccountCliqIdList.add(data);
    _linkBankAccountCliqIdListRequest.safeAdd(linkBankAccountCliqIdList);
  }

  BehaviorSubject<bool> _isSelectedRequest = BehaviorSubject();

  Stream<bool> get isSelectedStream => _isSelectedRequest.stream;

  void termAndConditionSelected(bool value) {
    _isSelectedRequest.safeAdd(value);
  }
}
