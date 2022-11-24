import 'package:domain/constants/error_types.dart';
import 'package:domain/model/fatca_crs/fatca_w8_data.dart';
import 'package:domain/usecase/register/fatca_us_relevant_w8_useCase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class FatcaUSRelevantW8PageViewModel extends BasePageViewModel {
  final FatcaUSRelevantW8UseCase _fatcaUSRelevantW8UseCase;

  ///controllers and keys
  final TextEditingController nameAsPerTaxReturnController = TextEditingController();
  final GlobalKey<AppTextFieldState> nameAsPerTaxReturnKey = GlobalKey(debugLabel: "nameAsPerTaxReturn");

  final TextEditingController dateOfBirthController = TextEditingController();
  final GlobalKey<AppTextFieldState> dateOfBirthKey = GlobalKey(debugLabel: "dateOfBirth");

  final TextEditingController countryOfCitizenshipController = TextEditingController();
  final GlobalKey<AppTextFieldState> countryOfCitizenshipKey = GlobalKey(debugLabel: "countryOfCitizenship");

  ///fatca us relevant request subject holder
  PublishSubject<FatcaUSRelevantW8UseCaseParams> _fatcaUSRelevantW8Request = PublishSubject();

  ///fatca us relevant response holder
  PublishSubject<Resource<bool>> _fatcaUSRelevantW8Response = PublishSubject();

  ///fatca us relevant stream
  Stream<Resource<bool>> get fatcaUSRelevantW8Stream => _fatcaUSRelevantW8Response.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  DateTime initialDate = DateTime.now();

  bool isValid() {
    bool valid = false;
    if (nameAsPerTaxReturnController.text.isNotEmpty &&
        dateOfBirthController.text.isNotEmpty &&
        countryOfCitizenshipController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  FatcaUSRelevantW8PageViewModel(this._fatcaUSRelevantW8UseCase) {
    _fatcaUSRelevantW8Request.listen((value) {
      RequestManager(value, createCall: () => _fatcaUSRelevantW8UseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _fatcaUSRelevantW8Response.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_NAME_AS_PER_TAX_RETURN:
        nameAsPerTaxReturnKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_DOB:
        dateOfBirthKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_CITIZENSHIP:
        countryOfCitizenshipKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  void validateFatcaUSRelevantW8Details() {
    _fatcaUSRelevantW8Request.safeAdd(FatcaUSRelevantW8UseCaseParams(
        name: nameAsPerTaxReturnController.text,
        country: countryOfCitizenshipController.text,
        dob: dateOfBirthController.text));
  }

  ///update data to main page
  void updateData(BuildContext context) {
    FatcaW8Data fatcaW8Data =
        ProviderScope.containerOf(context).read(registerStepFourViewModelProvider).getFatcaW8Data;
    fatcaW8Data.nameIncomeTaxReturn = nameAsPerTaxReturnController.text;
    fatcaW8Data.dateOfBirth = dateOfBirthController.text;
    fatcaW8Data.citizenShipCountry = countryOfCitizenshipController.text;
    ProviderScope.containerOf(context).read(registerStepFourViewModelProvider).setFatcaW8(fatcaW8Data);
  }

  @override
  void dispose() {
    _fatcaUSRelevantW8Request.close();
    _fatcaUSRelevantW8Response.close();
    _allFieldValidatorSubject.close();
    super.dispose();
  }
}
