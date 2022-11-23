import 'package:domain/usecase/card_delivery/create_pin_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class CreateReplacementPinPageViewModel extends BasePageViewModel {
  final CreatePinUseCase _createPinUseCase;

  ///otp controller
  TextEditingController pinController = TextEditingController();

  ///create pin request subject holder
  PublishSubject<CreatePinUseCaseParams> _createPinRequest = PublishSubject();

  ///create pin response holder
  PublishSubject<Resource<bool>> _createPinResponse = PublishSubject();

  ///create pin stream
  Stream<Resource<bool>> get createPinStream => _createPinResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _pinSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  CreateReplacementPinPageViewModel(this._createPinUseCase) {
    _createPinRequest.listen((value) {
      RequestManager(value, createCall: () => _createPinUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createPinResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  String currentPin = '';

  void validatePin() {
    _createPinRequest.safeAdd(CreatePinUseCaseParams(pin: _pinSubject.value));
  }

  void validate(String value) {
    _pinSubject.safeAdd(value);
    if (value.isNotEmpty && value.length == 4) {
      _showButtonSubject.safeAdd(true);
      currentPin = value;
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _createPinRequest.close();
    _createPinResponse.close();
    _showButtonSubject.close();
    _pinSubject.close();
  }
}
