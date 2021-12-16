import 'package:domain/usecase/payment/request_from_new_recipient_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RequestFromNewRecipientViewModel extends BasePageViewModel {
  RequestFromNewRecipientUseCase _useCase;

  TextEditingController ibanOrMobileController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();

  bool? dropDownEnabled = true;

  final GlobalKey<AppTextFieldState> ibanOrMobileKey =
      GlobalKey(debugLabel: "ibanOrMobileNo");

  final GlobalKey<AppTextFieldState> purposeKey =
      GlobalKey(debugLabel: "purpose");

  final GlobalKey<AppTextFieldState> purposeDetailKey =
      GlobalKey(debugLabel: "purposeDetails");

  bool isAnyOtherNationality = false;

  PublishSubject<RequestFromNewRecipientUseCaseParams>
      _sendToNewRecipientRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendToNewRecipientResponse = PublishSubject();

  Stream<Resource<bool>> get sendToNewRecipientResponseStream =>
      _sendToNewRecipientResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  RequestFromNewRecipientViewModel(this._useCase) {
    _sendToNewRecipientRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _sendToNewRecipientResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void sendToNewRecipient() {
    _sendToNewRecipientRequest.safeAdd(RequestFromNewRecipientUseCaseParams(
        ibanOrMobile: ibanOrMobileController.text,
        purpose: "",
        purposeDetail: ""));
  }

  void updatePurpose(String value) {
    purposeController.text = value;
  }

  void updatePurposeDetail(String value) {
    purposeDetailController.text = value;
  }

  void validateAddress() {}

  @override
  void dispose() {
    _showButtonSubject.close();
    _sendToNewRecipientRequest.close();
    _sendToNewRecipientResponse.close();
    super.dispose();
  }
}
