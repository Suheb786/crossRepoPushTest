import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_debit_card_entity.g.dart";

@JsonSerializable()
class DashboardDebitCardEntity
    implements BaseLayerDataTransformer<DashboardDebitCardEntity, DebitCard> {
  @JsonKey(name: "accountTitle")
  final String? accountTitle;
  @JsonKey(name: "cardStatus")
  final String? cardStatus;
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "cardNumber")
  final String? cardNumber;
  @JsonKey(name: "linkedAccountNumber")
  final String? linkedAccountNumber;
  @JsonKey(name: "expiryDate")
  final String? expiryDate;
  @JsonKey(name: "cvv")
  final String? cvv;
  @JsonKey(name: "isDebitDelivered")
  final bool? isDebitDelivered;
  @JsonKey(name: "debitDeliveredDatetime")
  final dynamic? debitDeliveredDatetime;
  @JsonKey(name: "debitCardActivated")
  final DateTime? debitCardActivated;

  DashboardDebitCardEntity(
      {this.accountTitle: "",
      this.cvv: "",
      this.expiryDate: "",
      this.cardNumber: "",
      this.linkedAccountNumber: "",
      this.debitDeliveredDatetime,
      this.isDebitDelivered,
      this.debitCardActivated,
      this.cardStatus,
      this.code});

  factory DashboardDebitCardEntity.fromJson(Map<String, dynamic> json) =>
      _$DashboardDebitCardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardDebitCardEntityToJson(this);

  @override
  DashboardDebitCardEntity restore(DebitCard response) {
    return DashboardDebitCardEntity();
  }

  @override
  DebitCard transform() {
    return DebitCard(
        cardNumber: this.cardNumber != null && this.cardNumber!.isNotEmpty
            ? EncryptDecryptHelper.decryptCard(cardNo: this.cardNumber!)
            : "",
        cvv: this.cvv != null
            ? (this.cvv!.isNotEmpty
                ? EncryptDecryptHelper.decryptCard(cardNo: this.cvv!)
                : "")
            : "",
        expiryDate: this.expiryDate ?? '',
        linkedAccountNumber: this.linkedAccountNumber ?? '',
        accountTitle: this.accountTitle ?? '',
        debitDeliveredDatetime: this.debitDeliveredDatetime ?? '',
        debitCardActivated: this.debitCardActivated,
        cardStatus: this.cardStatus!.fromFreezeCardStatusValue(),
        code: this.code ?? '',
        isDebitDelivered: this.isDebitDelivered ?? false);
  }
}
