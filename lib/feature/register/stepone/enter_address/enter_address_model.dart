import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/country/country_list/country_data.dart';
import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:domain/usecase/country/get_cities_by_country_usecase.dart';
import 'package:domain/usecase/user/enter_address_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterAddressViewModel extends BasePageViewModel {
  final EnterAddressUseCase _enterAddressUseCase;

  final GetCityByCountryListUseCase _getCityByCountryListUseCase;

  TextEditingController residentCountryController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNumberController =
      TextEditingController();
  TextEditingController permanentHomeAddressController =
      TextEditingController();
  TextEditingController permanentStreetAddressController =
      TextEditingController();
  TextEditingController permanentBuildingNameOrNumberController =
      TextEditingController();
  TextEditingController permanentResidentCountryController =
      TextEditingController();
  TextEditingController permanentCityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  bool? dropDownEnabled = true;

  final GlobalKey<AppTextFieldState> residentCountryKey =
      GlobalKey(debugLabel: "residentCountry");

  final GlobalKey<AppTextFieldState> streetAddressKey =
      GlobalKey(debugLabel: "streetAddress");

  final GlobalKey<AppTextFieldState> buildingNameOrNumberKey =
      GlobalKey(debugLabel: "buildingNameOrNumber");

  final GlobalKey<AppTextFieldState> permanentHomeAddressKey =
      GlobalKey(debugLabel: "permanentHomeAddress");

  final GlobalKey<AppTextFieldState> permanentStreetAddressKey =
      GlobalKey(debugLabel: "permanentStreetAddress");

  final GlobalKey<AppTextFieldState> permanentBuildingNameOrNumberKey =
      GlobalKey(debugLabel: "permanentBuildingNameOrNumber");

  final GlobalKey<AppTextFieldState> permanentResidentCountryKey =
      GlobalKey(debugLabel: "permanentResidentCountry");

  final GlobalKey<AppTextFieldState> permanentCityKey =
      GlobalKey(debugLabel: "permanentCity");
  final GlobalKey<AppTextFieldState> districtKey =
      GlobalKey(debugLabel: "district");

  final GlobalKey<AppTextFieldState> cityKey = GlobalKey(debugLabel: "city");

  /// enter address request subject holder
  PublishSubject<EnterAddressUseCaseParams> _enterAddressRequest =
      PublishSubject();

  /// enter address response subject holder
  PublishSubject<Resource<SaveCountryResidenceInfoResponse>>
      _enterAddressResponse = PublishSubject();

  Stream<Resource<SaveCountryResidenceInfoResponse>>
      get enterAddressResponseStream => _enterAddressResponse.stream;

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///permanent address Subject holder
  BehaviorSubject<bool> _permanentAddressVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get permanentAddressVisibilityStream =>
      _permanentAddressVisibilitySubject.stream;

  /// get cities by country request subject holder
  PublishSubject<GetCityByCountryListUseParams> _getCitiesByCountryRequest =
      PublishSubject();

  /// get cities by country response subject holder
  PublishSubject<Resource<CityListResponse>> _getCitiesByCountryResponse =
      PublishSubject();

  /// get cities by country response stream
  Stream<Resource<CityListResponse>> get getCitiesByCountryResponseStream =>
      _getCitiesByCountryResponse.stream;

  CountryData currentCountry = CountryData();
  StateCityData currentCity = StateCityData();
  CountryData permanentCountry = CountryData();
  StateCityData permanentCity = StateCityData();

  void updatePermanentAddressVisibility() {
    permanentResidentCountryController.clear();
    permanentCityController.clear();
    permanentCountry = CountryData();
    permanentCity = StateCityData();
    if (residentCountryController.text == 'Jordan') {
      _permanentAddressVisibilitySubject.safeAdd(false);
    } else {
      _permanentAddressVisibilitySubject.safeAdd(true);
    }
  }

  EnterAddressViewModel(
      this._enterAddressUseCase, this._getCityByCountryListUseCase) {
    _enterAddressRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterAddressUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterAddressResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _getCitiesByCountryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _getCityByCountryListUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getCitiesByCountryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterAddress() {
    _enterAddressRequest.safeAdd(EnterAddressUseCaseParams(
        residentCountry: currentCity.countryId,
        residentArea: districtController.text,
        city: cityController.text,
        streetAddress: streetAddressController.text,
        buildingNameOrNo: buildingNameOrNumberController.text,
        jordanianLivesAbroad: _permanentAddressVisibilitySubject.value,
        permanentCity: permanentCity.cityId,
        permanentResidentCountry: permanentCity.countryId,
        cityId: currentCity.cityId!,
        stateId: currentCity.stateId!));
  }

  void getCitiesByCountry(String isoCode) {
    _getCitiesByCountryRequest.safeAdd(
        GetCityByCountryListUseParams(isoCode: isoCode, stateId: '001'));
  }

  void validateAddress() {
    bool isValid = false;
    if (_permanentAddressVisibilitySubject.value) {
      if (residentCountryController.text.isNotEmpty &&
          districtController.text.isNotEmpty &&
          cityController.text.isNotEmpty &&
          streetAddressController.text.isNotEmpty &&
          buildingNameOrNumberController.text.isNotEmpty &&
          permanentResidentCountryController.text.isNotEmpty &&
          permanentCityController.text.isNotEmpty) {
        isValid = true;
      }
    } else if (residentCountryController.text.isNotEmpty &&
        districtController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        streetAddressController.text.isNotEmpty &&
        buildingNameOrNumberController.text.isNotEmpty) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  @override
  void dispose() {
    _showButtonSubject.close();
    _enterAddressRequest.close();
    _enterAddressResponse.close();
    _permanentAddressVisibilitySubject.close();
    super.dispose();
  }
}
