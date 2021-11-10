import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country.dart';
import 'package:domain/usecase/country/fetch_country_by_code_usecase.dart';
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
  final FetchCountryByCodeUseCase _fetchCountryByCodeUseCase;

  ///controllers and keys
  final TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<AppTextFieldState> mobileNumberKey =
      GlobalKey(debugLabel: "mobileNumber");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  PublishSubject<RegisterNumberUseCaseParams> _registerNumberRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _registerNumberResponse = PublishSubject();

  Stream<Resource<bool>> get registerNumberStream =>
      _registerNumberResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///COUNTRY
  PublishSubject<FetchCountryByCodeUseCaseParams> _fetchCountryRequest =
      PublishSubject();

  BehaviorSubject<Resource<Country>> _fetchCountryResponse = BehaviorSubject();

  Stream<Resource<Country>> get countryByCode => _fetchCountryResponse.stream;

  AddNumberViewModel(
      this._registerNumberUseCase, this._fetchCountryByCodeUseCase) {
    _registerNumberRequest.listen((value) {
      RequestManager(value,
              createCall: () => _registerNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _registerNumberResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _fetchCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _fetchCountryByCodeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _fetchCountryResponse.safeAdd(event);
      });
    });
  }

  void fetchCountryByCode(BuildContext context, String code) {
    _fetchCountryRequest.safeAdd(
        FetchCountryByCodeUseCaseParams(context: context, countryCode: code));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.EMPTY_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMAIL:
        emailKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_MOBILE:
        mobileNumberKey.currentState!.isValid = false;
        break;
    }
  }

  void validateNumber({required String dialCode}) {
    _registerNumberRequest.safeAdd(RegisterNumberUseCaseParams(
        emailAddress: emailController.text,
        countryCode: dialCode,
        mobileNumber: mobileNumberController.text));
  }

  void validate() {
    if (mobileNumberController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _registerNumberRequest.close();
    _registerNumberResponse.close();
    _showButtonSubject.close();
    _fetchCountryRequest.close();
    _fetchCountryResponse.close();
    super.dispose();
  }
}
