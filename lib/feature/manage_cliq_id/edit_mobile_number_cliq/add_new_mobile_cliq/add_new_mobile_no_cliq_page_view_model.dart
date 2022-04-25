import 'package:domain/constants/error_types.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/get_allowed_code/allowed_country_list_response.dart';
import 'package:domain/usecase/country/get_allowed_code_country_list_usecase.dart';
import 'package:domain/usecase/manage_cliq/add_new_mobile_number_cliq_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class AddNewMobileNumberCliqPageViewModel extends BasePageViewModel {
  final AddNewMobileNumberCliqUseCase _addNewMobileNumberCliqUseCase;

  final GetAllowedCodeCountryListUseCase _allowedCodeCountryListUseCase;

  /// controller
  final TextEditingController mobileController = TextEditingController();

  final GlobalKey<AppTextFieldState> mobileKey =
      GlobalKey(debugLabel: "mobileNumber");

  ///add new mobile number request subject holder
  PublishSubject<AddNewMobileNumberCliqUseCaseParams>
      _addNewMobileNumberCliqRequest = PublishSubject();

  ///add new mobile number response holder
  PublishSubject<Resource<bool>> _addNewMobileNumberCliqResponse =
      PublishSubject();

  ///add new mobile number stream
  Stream<Resource<bool>> get addNewMobileNumberCliqStream =>
      _addNewMobileNumberCliqResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  CountryData countryData = CountryData();

  String mobileNumber = '';
  String mobileNumberWithCode = '';

  ///get allowed code country request holder
  PublishSubject<GetAllowedCodeCountryListUseCaseParams>
      _getAllowedCountryRequest = PublishSubject();

  ///get allowed code country response holder
  PublishSubject<Resource<AllowedCountryListResponse>>
      _getAllowedCountryResponse = PublishSubject();

  ///get allowed code country response stream
  Stream<Resource<AllowedCountryListResponse>> get getAllowedCountryStream =>
      _getAllowedCountryResponse.stream;

  ///selected country response holder
  BehaviorSubject<CountryData> _selectedCountryResponse =
      BehaviorSubject.seeded(CountryData());

  ///get allowed code country response stream
  Stream<CountryData> get getSelectedCountryStream =>
      _selectedCountryResponse.stream;

  AddNewMobileNumberCliqPageViewModel(this._addNewMobileNumberCliqUseCase,
      this._allowedCodeCountryListUseCase) {
    _addNewMobileNumberCliqRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _addNewMobileNumberCliqUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _addNewMobileNumberCliqResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _getAllowedCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _allowedCodeCountryListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAllowedCountryResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.SUCCESS) {
          countryData = event.data!.contentData!.countryData!.firstWhere(
              (element) => element.isoCode3 == 'JOR',
              orElse: () => event.data!.contentData!.countryData!.first);
          setSelectedCountry(countryData);
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
          showErrorState();
        }
      });
    });

    getAllowedCountryCode();
  }

  void changeMobileNumber() {
    mobileNumberWithCode = '+${countryData.phoneCode} ${mobileController.text}';
    mobileNumber = mobileController.text;
    _addNewMobileNumberCliqRequest.safeAdd(AddNewMobileNumberCliqUseCaseParams(
        mobileCode: '00${countryData.phoneCode}',
        mobileNumber: mobileController.text));
  }

  void validate() {
    if (mobileController.text.isNotEmpty && mobileController.text.length > 8) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_MOBILE:
        mobileKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void setSelectedCountry(CountryData data) {
    _selectedCountryResponse.safeAdd(data);
  }

  /// get allowed country code
  void getAllowedCountryCode() {
    _getAllowedCountryRequest.safeAdd(GetAllowedCodeCountryListUseCaseParams());
  }

  @override
  void dispose() {
    _addNewMobileNumberCliqRequest.close();
    _addNewMobileNumberCliqResponse.close();
    _showButtonSubject.close();
    super.dispose();
  }
}
