import 'package:domain/usecase/dynamic_link/create_dynamic_link_usecases.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/qr_screen/qr_screen_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class QrScreenPageViewModel extends BasePageViewModel {
  final QrScreenPageArguments arguments;

  final CreateDynamicLinkUseCase _createDynamicLinkUseCase;
  PublishSubject<CreateDynamicLinkUseCaseParams> _createDynamicLinkRequest = PublishSubject();

  PublishSubject<Resource<String>> _createDynamicLinkResponse = PublishSubject();

  Stream<Resource<String>> get createDynamicLinkStream => _createDynamicLinkResponse.stream;

  QrScreenPageViewModel(this.arguments, this._createDynamicLinkUseCase) {
    _createDynamicLinkRequest.listen((value) {
      RequestManager(value, createCall: () => _createDynamicLinkUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createDynamicLinkResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  GlobalKey globalKey = new GlobalKey();

  void createDynamicLink() {
    _createDynamicLinkRequest.safeAdd(CreateDynamicLinkUseCaseParams(
        dateTime: DateTime.now().toString(),
        accountNo: arguments.account.accountNo ?? '',
        accountTitle: arguments.account.accountTitle ?? '',
        requestId: arguments.requestId,
        requestAmt: arguments.requestAmt));
  }
}
