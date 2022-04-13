import 'package:domain/model/account/request_call_status.dart';
import 'package:domain/usecase/account/request_call_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class CreditCardVideoCallInitiatePageViewModel extends BasePageViewModel {
  final RequestCallUseCase _requestCallUseCase;

  PublishSubject<RequestCallUseCaseParams> _requestCallRequest =
      PublishSubject();

  PublishSubject<Resource<RequestCallStatus>> _requestCallResponse =
      PublishSubject();

  Stream<Resource<RequestCallStatus>> get requestCallStream =>
      _requestCallResponse.stream;

  CreditCardVideoCallInitiatePageViewModel(this._requestCallUseCase) {
    _requestCallRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _requestCallUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _requestCallResponse.safeAdd(event);
      });
    });
  }

  void getAgoraCredentials() {
    _requestCallRequest
        .safeAdd(RequestCallUseCaseParams(type: "CREDITCARDREQ"));
  }

  @override
  void dispose() {
    _requestCallRequest.close();
    _requestCallResponse.close();
    super.dispose();
  }
}
