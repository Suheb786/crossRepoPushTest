import 'package:domain/usecase/user/register_number_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddNumberViewModel extends BasePageViewModel {
  final RegisterNumberUseCase _registerNumberUseCase;
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey =
      GlobalKey(debugLabel: "mobileNumber");
  PublishSubject<RegisterNumberUseCaseParams> _registerNumberRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _registerNumberResponse = PublishSubject();

  Stream<Resource<bool>> get registerNumberStream =>
      _registerNumberResponse.stream;

  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  AddNumberViewModel(this._registerNumberUseCase) {
    _registerNumberRequest.listen((value) {
      RequestManager(value,
              createCall: () => _registerNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _registerNumberResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateNumber({required String dialCode}) {
    _registerNumberRequest.safeAdd(RegisterNumberUseCaseParams(
        countryCode: dialCode, mobileNumber: mobileNumberController.text));
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }

  @override
  void dispose() {
    _registerNumberRequest.close();
    _registerNumberResponse.close();
    _errorDetectorSubject.close();
    super.dispose();
  }
}
