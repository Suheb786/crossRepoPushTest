import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ProfileDetailsPageViewModel extends BasePageViewModel {
  final ProfileDetailsUseCase _profileUseCase;

  final GlobalKey<AppTextFieldState> spouseNameKey =
      GlobalKey(debugLabel: "spouseName");
  final GlobalKey<AppTextFieldState> natureOfSpecialNeedKey =
      GlobalKey(debugLabel: "natureOfSpecialNeed");
  final GlobalKey<AppTextFieldState> employeeStatusKey =
      GlobalKey(debugLabel: "employeeStatus");
  final GlobalKey<AppTextFieldState> jobNameKey =
      GlobalKey(debugLabel: "jobName");
  final GlobalKey<AppTextFieldState> otherNationalityKey =
      GlobalKey(debugLabel: "otherNationality");

  final TextEditingController spouseNameController = TextEditingController();
  final TextEditingController natureController = TextEditingController();
  final TextEditingController employeeStatusController =
      TextEditingController();
  final TextEditingController jobNameController = TextEditingController();
  final TextEditingController otherNationalityController =
      TextEditingController();

  bool isMarried = false;
  bool isPerson = false;
  bool isRelative = false;
  bool isAnyOtherNationality = false;

  PublishSubject<ProfileDetailsUseCaseParams> _profileDetailsRequest =
      PublishSubject();

  PublishSubject<Resource<SaveProfileStatusResponse>> _profileDetailsResponse =
      PublishSubject();

  Stream<Resource<SaveProfileStatusResponse>> get profileDetailsStream =>
      _profileDetailsResponse.stream;

  ///nature of special needs text field value
  void updateNatureOfNeeds(String value) {
    natureController.text = value;
    employeeStatusController.clear();
  }

  void updateRelationShipWithPEP(String value) {
    employeeStatusController.text = value;
  }

  /// show button Subject holder
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate() {
    bool isValid = false;
    if (_jobNameVisibilitySubject.value) {
      if (jobNameController.text.isNotEmpty &&
          employeeStatusController.text.isNotEmpty) {
        isValid = true;
      }
    } else if (employeeStatusController.text.isNotEmpty) {
      isValid = true;
    }
    _showButtonSubject.safeAdd(isValid);
  }

  /// job name visibility Subject holder
  BehaviorSubject<bool> _jobNameVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get jobNameVisibilityStream => _jobNameVisibilitySubject.stream;

  void updateJobNameVisibility() {
    if (employeeStatusController.text.fromEmploymentValue() ==
        EmploymentStatusEnum.OTHER) {
      _jobNameVisibilitySubject.safeAdd(true);
    } else {
      _jobNameVisibilitySubject.safeAdd(false);
    }
  }

  /// show beneficial Owner Account Error visibility Subject holder
  BehaviorSubject<bool> _beneficialOwnerAccountErrorVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get beneficialOwnerAccountErrorVisibilityStream =>
      _beneficialOwnerAccountErrorVisibilitySubject.stream;

  void updateBeneficialOwnerAccountErrorVisibility(bool value) {
    _beneficialOwnerAccountErrorVisibilitySubject.safeAdd(value);
  }

  ProfileDetailsPageViewModel(this._profileUseCase) {
    _profileDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () => _profileUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _profileDetailsResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void checkKeyStatus(ErrorType type) {
    if (type == ErrorType.INVALID_NAME) {
      spouseNameKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_NATURE) {
      natureOfSpecialNeedKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_EMPLOYEE_STATUS) {
      employeeStatusKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_JOB_NAME) {
      jobNameKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_COUNTRY) {
      otherNationalityKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_BENEFICIAL_OWNER_ACCOUNT) {}
  }

  void setKeysStatusValid() {
    if (isMarried) {
      spouseNameKey.currentState!.isValid = true;
    }
    if (isPerson) {
      natureOfSpecialNeedKey.currentState!.isValid = true;
    }
    if (isRelative) {
      employeeStatusKey.currentState!.isValid = true;
    }
  }

  void validateTextFields() {
    _profileDetailsRequest.safeAdd(ProfileDetailsUseCaseParams(
        isMarried: isMarried,
        isPerson: isPerson,
        isRelative: isRelative,
        spouseName: spouseNameController.text,
        natureOfNeeds: natureController.text,
        employeeStatus: employeeStatusController.text,
        isEmploymentStatusOthers: _jobNameVisibilitySubject.value,
        isBeneficialOwnerACcount:
            _beneficialOwnerAccountErrorVisibilitySubject.value,
        jobName: jobNameController.text,
        isAnyOtherNationality: isAnyOtherNationality,
        otherNationality: otherNationalityController.text));
  }

  @override
  void dispose() {
    _profileDetailsRequest.close();
    _showButtonSubject.close();
    _beneficialOwnerAccountErrorVisibilitySubject.close();
    _jobNameVisibilitySubject.close();
    super.dispose();
  }
}
