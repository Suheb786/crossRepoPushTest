import 'package:domain/usecase/manage_contacts/add_contact_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:rxdart/subjects.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

class AddContactsIBANformPageViewModel extends BasePageViewModel {
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<AppTextFieldState> nameKey = GlobalKey(debugLabel: "name");

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFieldState> emailKey = GlobalKey(debugLabel: "email");

  final TextEditingController ibanORaccountORmobileORaliasController = TextEditingController();
  final GlobalKey<AppTextFieldState> ibanORaccountORmobileORaliasKey =
      GlobalKey(debugLabel: "ibanORaccountORmobileORalias");

  PublishSubject<bool> showbuttom = PublishSubject();
  Stream<bool> get showStreamButom => showbuttom.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  PublishSubject<AddContactIBANuseCaseParams> addcontactIBANuseCaseRequest = PublishSubject();

  validate() {
    if (nameController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else if (emailController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else if (ibanORaccountORmobileORaliasController.text.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  validationUserInput() {
    addcontactIBANuseCaseRequest.safeAdd(AddContactIBANuseCaseParams(
        IBANACCOUNTNOMobileNoALIAS: ibanORaccountORmobileORaliasController.text,
        emailAddress: emailController.text,
        name: nameController.text));
  }
}
