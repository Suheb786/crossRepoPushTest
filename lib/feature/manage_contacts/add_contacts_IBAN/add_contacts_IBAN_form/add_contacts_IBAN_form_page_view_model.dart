import 'dart:developer';

import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/manage_contacts/add_contact_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_contact_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/subjects.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AddContactsIBANformPageViewModel extends BasePageViewModel {


  final AddContactIBANuseCase addContactIBANuseCase;

  ///--------------------------keys-valiables-------------------------------------///
  final GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");
  final GlobalKey<AppTextFieldState> ibanORaccountORmobileORaliasKey =
      GlobalKey(debugLabel: "ibanORaccountORmobileORalias");

  final GlobalKey<AppTextFieldState> purposeKey = GlobalKey(debugLabel: "purpose");
  final GlobalKey<AppTextFieldState> purposeDetailKey = GlobalKey(debugLabel: "purposeDetails");

  ///--------------------------textEditing-controllers-------------------------------------///
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ibanORaccountORmobileORaliasController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController purposeDetailController = TextEditingController();

  ///--------------------------formField-subject-------------------------------------///

  BehaviorSubject<String> formFieldSubject = BehaviorSubject.seeded("");

  ///--------------------------animated-button-subject-------------------------------------///
  ///
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  ///--------------------------addContact-subject-------------------------------------///

  PublishSubject<AddContactIBANuseCaseParams> addcontactIBANuseCaseRequest = PublishSubject();
  PublishSubject<Resource<bool>> addcontactIBANuseCaseResponse = PublishSubject();
  Stream<Resource<bool>> get addcontactIBANStream => addcontactIBANuseCaseResponse.stream;

  ///--------------------------public-other-methods-------------------------------------///

  PublishSubject<bool> _showNameVisibilityRequest = PublishSubject();
  Stream<bool> get showNameVisibilityStream => _showNameVisibilityRequest.stream;


  void showNameVisibility(bool value) {
    _showNameVisibilityRequest.safeAdd(value);
  }

  validate(String data) {
    if (nameController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(false);
    }
    if (ibanORaccountORmobileORaliasController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(false);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  validationUserInput() {
    addcontactIBANuseCaseRequest.safeAdd(AddContactIBANuseCaseParams(
        IBANACCOUNTNOMobileNoALIAS: ibanORaccountORmobileORaliasController.text,
        purpose: 'Dhaiyur',
        purposeDetail: 'dhaiyur',
        name: nameController.text));
  }

  void getError(Resource<bool> event) {
    switch (event.appError?.type) {
      case ErrorType.PLEASE_ENTER_CONTACT_NAME:
        nameKey.currentState!.isValid = false;
        break;

      case ErrorType.INVALID_IBAN:
        ibanORaccountORmobileORaliasKey.currentState!.isValid = false;
        break;

      default:
        break;
    }
  }

  ///--------------------------public-constructor-------------------------------------///

  AddContactsIBANformPageViewModel(this.addContactIBANuseCase) {
    addcontactIBANuseCaseRequest.listen(
      (value) {
        RequestManager(value, createCall: () => addContactIBANuseCase.execute(params: value)).asFlow().listen(
          (event) {
            addcontactIBANuseCaseResponse.safeAdd(event);
            if (event.status == Status.ERROR) {
              getError(event);
              showErrorState();
              showToastWithError(event.appError!);

              log("error......");
            }
          },
        );
      },
    );
  }
}
