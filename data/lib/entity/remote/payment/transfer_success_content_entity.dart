import 'package:domain/model/payment/transfer_success_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "transfer_success_content_entity.g.dart";

@JsonSerializable()
class TransferSuccessContentEntity
    implements
        BaseLayerDataTransformer<TransferSuccessContentEntity,
            TransferSuccessContent> {
  @JsonKey(name: "amount")
  final num? amount;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "iban")
  final String? iban;
  @JsonKey(name: "transferDate")
  final DateTime? transferDate;
  @JsonKey(name: "reference")
  final String? reference;

  TransferSuccessContentEntity(
      {this.amount, this.name, this.iban, this.transferDate, this.reference});

  factory TransferSuccessContentEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferSuccessContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferSuccessContentEntityToJson(this);

  @override
  TransferSuccessContentEntity restore(TransferSuccessContent response) {
    return TransferSuccessContentEntity();
  }

  @override
  TransferSuccessContent transform() {
    return TransferSuccessContent(
        iban: this.iban,
        amount: this.amount,
        name: this.name,
        referenceNo: this.reference,
        transferDate: this.transferDate);
  }
}
