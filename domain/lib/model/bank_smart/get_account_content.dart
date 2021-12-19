import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';

class GetAccountContent {
  final CustomerInformation? customerInformation;
  final CustomerAccountDetails? accountDetails;

  GetAccountContent({this.customerInformation, this.accountDetails});
}
