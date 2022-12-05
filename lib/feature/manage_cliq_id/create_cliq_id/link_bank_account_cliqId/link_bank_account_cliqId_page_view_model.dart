import 'package:domain/usecase/cliq/create_cliq_id_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/manage_cliq/link_account_dialog/link_account_dialog_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LinkBankAccountCliqIdPageViewModel extends BasePageViewModel {
  final ScrollController controller = ScrollController();

  final CreateCliqIdUseCase _createCliqIdUseCase;
  List<LinkBankAccountData> linkBankAccountCliqIdList = [];

  //*----------------Create Cliq Id--------------///

  PublishSubject<CreateCliqIdParams> _createCliqIdRequest = PublishSubject();
  PublishSubject<Resource<bool>> _createCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get createCliqIdStream => _createCliqIdResponse.stream;

  void createCliqID(
      String accountNumber, bool isAlias, String aliasValue, bool getToken) {
    _createCliqIdRequest.safeAdd(CreateCliqIdParams(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        getToken: getToken));
  }
  //----------------Create Cliq Id--------------///

  PublishSubject<List<LinkBankAccountData>> _linkBankAccountCliqIdListRequest =
      PublishSubject();

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

  LinkBankAccountCliqIdPageViewModel(this._createCliqIdUseCase) {
    _createCliqIdRequest.listen((value) {
      RequestManager(value,
              createCall: () => _createCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    createCliqID("4007573", true, "RUTVIJ", true);
  }
}
