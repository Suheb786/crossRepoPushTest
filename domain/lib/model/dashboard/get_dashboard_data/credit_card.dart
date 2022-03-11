import 'package:domain/constants/enum/freeze_card_status_enum.dart';

class CreditCard {
  CreditCard(
      {this.name,
      this.cardNumber,
      this.expiryDate,
      this.cvv,
      this.minDue,
      this.availableBalance,
      this.totalAmount,
      this.maxLimit,
      this.cardId: "",
      this.creditLimit,
      this.creditDeliveredDatetime,
      this.isCreditDelivered,
      this.isApplied,
      this.creditCardActivatedDate,
      this.isSupCard,
      this.primarySecondaryCard,
      this.usedBalance,
      this.paymentDueAmount,
      this.cardCode,
      this.isCompleted: false,
      this.nextPaymentDate: "",
      this.cardStatus: FreezeCardStatusEnum.NONE});

  String? name;
  String? cardNumber;
  String? expiryDate;
  String? cvv;
  num? minDue;
  num? availableBalance;
  num? totalAmount;
  num? maxLimit;
  String? primarySecondaryCard;
  String? creditLimit;
  String? usedBalance;
  bool? isCreditDelivered;
  String? creditCardActivatedDate;
  String? creditDeliveredDatetime;
  bool? isApplied;
  bool? isCompleted;
  String? cardId;
  bool? isSupCard;
  String? cardCode;
  String? nextPaymentDate;
  dynamic paymentDueAmount;
  FreezeCardStatusEnum? cardStatus;
}
