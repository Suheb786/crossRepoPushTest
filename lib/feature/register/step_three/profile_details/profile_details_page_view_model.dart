import 'package:domain/constants/error_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/user/profile_details_usecase.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class ProfileDetailsPageViewModel extends BasePageViewModel {
  final ProfileDetailsUseCase _profileUseCase;

  final GlobalKey<AppTextFieldState> spouseNameKey =
      GlobalKey(debugLabel: "spouseName");
  final GlobalKey<AppTextFieldState> natureOfSpecialNeedKey =
      GlobalKey(debugLabel: "natureOfSpecialNeed");
  final GlobalKey<AppTextFieldState> relationShipWithPepKey =
      GlobalKey(debugLabel: "relationShipWithPep");
  final GlobalKey<AppTextFieldState> personNameKey =
      GlobalKey(debugLabel: "personName");
  final GlobalKey<AppTextFieldState> personRoleKey =
      GlobalKey(debugLabel: "personRole");

  final TextEditingController spouseNameController = TextEditingController();
  final TextEditingController natureController = TextEditingController();
  final TextEditingController relationShipController = TextEditingController();
  final TextEditingController personNameController = TextEditingController();
  final TextEditingController personRoleController = TextEditingController();

  bool isMarried = false;
  bool isPerson = false;
  bool isRelative = false;

  PublishSubject<ProfileDetailsUseCaseParams> _profileDetailsRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _profileDetailsResponse = PublishSubject();

  Stream<Resource<bool>> get profileDetailsStream =>
      _profileDetailsResponse.stream;

  PublishSubject<bool> _animatedSubject = PublishSubject();

  Stream<bool> get animatedStream => _animatedSubject.stream;

  void updateAnimatedValue(bool value) {
    _animatedSubject.add(value);
  }

  ///nature of special needs text field value
  void updateNatureOfNeeds(String value) {
    natureController.text = value;
  }

  void updateRelationShipWithPEP(String value) {
    relationShipController.text = value;
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
    } else if (type == ErrorType.INVALID_RELATIONSHIP) {
      relationShipWithPepKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_PERSON_NAME) {
      personNameKey.currentState!.isValid = false;
    } else if (type == ErrorType.INVALID_PERSON_ROLE) {
      personRoleKey.currentState!.isValid = false;
    }
  }

  void setKeysStatusValid() {
    if (isMarried) {
      spouseNameKey.currentState!.isValid = true;
    }
    if (isPerson) {
      natureOfSpecialNeedKey.currentState!.isValid = true;
    }
    if (isRelative) {
      relationShipWithPepKey.currentState!.isValid = true;
      personNameKey.currentState!.isValid = true;
      personRoleKey.currentState!.isValid = true;
    }
  }

  void validateTextFields() {
    _profileDetailsRequest.safeAdd(ProfileDetailsUseCaseParams(
      isMarried: isMarried,
      isPerson: isPerson,
      isRelative: isRelative,
      spouseName: spouseNameController.text,
      natureOfNeeds: natureController.text,
      relationShipPEP: relationShipController.text,
      personName: personNameController.text,
      personRole: personRoleController.text,
    ));
  }

  @override
  void dispose() {
    _profileDetailsRequest.close();
    super.dispose();
  }
}
