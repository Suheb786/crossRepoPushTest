import 'beneficiary_favorite_contact.dart';
import 'beneficiary_other_contact.dart';

class BeneficiaryRequestMoneyContact {
  final List<BeneficiaryFavoriteContact>? beneficiaryFavoriteContact;
  final List<BeneficiaryOtherContact>? beneficiaryOtherContact;

  BeneficiaryRequestMoneyContact({this.beneficiaryFavoriteContact, this.beneficiaryOtherContact});
}
