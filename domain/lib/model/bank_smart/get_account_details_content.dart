import 'package:domain/model/bank_smart/create_account_data.dart';

class GetAccountDetailsContent {
  GetAccountDetailsContent({
    this.data,
    this.openDate,
  });

  final CreateAccountData? data;
  final String? openDate;
}
