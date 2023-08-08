import 'beneficiary_favorite_contact.dart';
import 'beneficiary_other_contact.dart';

class BeneficiarySendMoneyContact {
  final List<BeneficiaryFavoriteContact>? beneficiaryFavoriteContact;
  final List<BeneficiaryOtherContact>? beneficiaryOtherContact;

  BeneficiarySendMoneyContact({this.beneficiaryFavoriteContact, this.beneficiaryOtherContact});
}
