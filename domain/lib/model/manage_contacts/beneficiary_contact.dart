import 'package:domain/model/manage_contacts/beneficiary_request_money_contact.dart';
import 'package:domain/model/manage_contacts/beneficiary_send_money_contact.dart';

class BeneficiaryContact {
  final BeneficiarySendMoneyContact? beneficiarySendMoneyContact;
  final BeneficiaryRequestMoneyContact? beneficiaryRequestMoneyContact;

  BeneficiaryContact({this.beneficiarySendMoneyContact, this.beneficiaryRequestMoneyContact});
}
