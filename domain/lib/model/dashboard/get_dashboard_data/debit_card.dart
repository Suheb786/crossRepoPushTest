import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/constants/enum/primary_secondary_enum.dart';

class DebitCard {
  DebitCard(
      {this.accountTitle,
      this.cardNumber,
      this.linkedAccountNumber,
      this.expiryDate,
      this.cvv,
      this.cardStatus,
      this.debitCardActivated,
      this.isDebitDelivered,
      this.debitDeliveredDatetime,
      this.code,
      this.primarySecondaryCard: PrimarySecondaryEnum.NONE,
      this.isPINSet: true,
      this.isPhysicalDebitCardRequested = false,
      this.cardCode,
      this.isCardInApplePay = false,
      this.getStatus = false});

  String? accountTitle;
  String? cardNumber;
  String? linkedAccountNumber;
  String? expiryDate;
  String? cvv;
  FreezeCardStatusEnum? cardStatus;
  String? code;
  bool? isDebitDelivered;
  bool? isPINSet;
  bool? isPhysicalDebitCardRequested;
  dynamic? debitDeliveredDatetime;
  DateTime? debitCardActivated;
  PrimarySecondaryEnum? primarySecondaryCard;
  String? cardCode;
  bool isCardInApplePay;
  bool getStatus;
}
