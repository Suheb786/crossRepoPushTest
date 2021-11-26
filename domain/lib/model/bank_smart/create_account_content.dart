import 'package:domain/model/bank_smart/create_account_data.dart';

class CreateAccountContent {
  final CreateAccountData? createAccountData;
  final bool? isAccountBlackListed;

  CreateAccountContent({this.createAccountData, this.isAccountBlackListed});
}
