import 'package:data/helper/encypt_decrypt_helper.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "dashboard_debit_card_entity.g.dart";

@JsonSerializable()
class DashboardDebitCardEntity
    implements BaseLayerDataTransformer<DashboardDebitCardEntity, DebitCard> {
  @JsonKey(name: "accountTitle")
  final String? accountTitle;

  // @JsonKey(name: "availableBalance")
  // final num? availableBalance;
  // @JsonKey(name: "accountNo")
  // final String? accountNo;
  // @JsonKey(name: "iban")
  // final String? iban;
  @JsonKey(name: "cardNumber")
  final String? cardNumber;
  @JsonKey(name: "linkedAccountNumber")
  final String? linkedAccountNumber;
  @JsonKey(name: "expiryDate")
  final String? expiryDate;
  @JsonKey(name: "cvv")
  final String? cvv;

  DashboardDebitCardEntity({this.accountTitle: "",
    this.cvv: "",
    this.expiryDate: "",
    this.cardNumber: "",
    this.linkedAccountNumber: ""});

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
        cardNumber: this.cardNumber != null
            ? EncryptDecryptHelper.decryptCard(cardNo: this.cardNumber!)
            : "",
        cvv: this.cvv != null
            ? (this.cvv!.isNotEmpty
                ? EncryptDecryptHelper.decryptCard(cardNo: this.cvv!)
                : "")
            : "",
        expiryDate: this.expiryDate,
        linkedAccountNumber: this.linkedAccountNumber,
        accountTitle: this.accountTitle);
  }
}
