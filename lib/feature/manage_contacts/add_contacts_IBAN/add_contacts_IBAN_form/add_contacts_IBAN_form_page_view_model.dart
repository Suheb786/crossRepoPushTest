import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:rxdart/subjects.dart';

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
}
