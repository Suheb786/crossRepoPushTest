import 'package:domain/usecase/debit_card_replacement/confirm_replacement_pin_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ConfirmReplacementPinPageViewModel extends BasePageViewModel {
  final ConfirmReplacementPinUseCase _confirmPinUseCase;

  ///otp controller
  TextEditingController confirmPinController = TextEditingController();

  ///Confirm pin request subject holder
  PublishSubject<ConfirmReplacementPinUseCaseParams> _confirmPinRequest = PublishSubject();

  ///Confirm pin response holder
  PublishSubject<Resource<bool>> _confirmPinResponse = PublishSubject();

  ///Confirm pin stream
  Stream<Resource<bool>> get confirmPinStream => _confirmPinResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _pinSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ConfirmReplacementPinPageViewModel(this._confirmPinUseCase) {
    _confirmPinRequest.listen((value) {
      RequestManager(value, createCall: () => _confirmPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _confirmPinResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void validatePin(String previousPin, String cardNumber) {
    _confirmPinRequest.safeAdd(ConfirmReplacementPinUseCaseParams(
        currentPin: _pinSubject.value, previousPin: previousPin, cardNumber: cardNumber));
  }

  void validate(String value) {
    _pinSubject.safeAdd(value);
    if (value.isNotEmpty && value.length == 4) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _confirmPinRequest.close();
    _confirmPinResponse.close();
    _showButtonSubject.close();
    _pinSubject.close();
    super.dispose();
  }
}
