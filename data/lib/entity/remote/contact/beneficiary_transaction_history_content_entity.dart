import 'package:domain/model/manage_contacts/beneficiary_transaction_history_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_transaction_history_entity.dart';

part "beneficiary_transaction_history_content_entity.g.dart";

@JsonSerializable()
class BeneficiaryTransactionHistoryContentEntity
    implements
        BaseLayerDataTransformer<BeneficiaryTransactionHistoryContentEntity,
            BeneficiaryTransactionHistoryContent> {
  @JsonKey(name: "date", defaultValue: "")
  String? date;
  @JsonKey(name: "data", defaultValue: [])
  List<BeneficiaryTransactionHistoryEntity>? data;

  BeneficiaryTransactionHistoryContentEntity({this.date, this.data});

  factory BeneficiaryTransactionHistoryContentEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryTransactionHistoryContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryTransactionHistoryContentEntityToJson(this);

  @override
  BeneficiaryTransactionHistoryContentEntity restore(BeneficiaryTransactionHistoryContent response) {
    return BeneficiaryTransactionHistoryContentEntity();
  }

  @override
  BeneficiaryTransactionHistoryContent transform() {
    return BeneficiaryTransactionHistoryContent(
        date: this.date, data: this.data?.map((e) => e.transform()).toList());
  }
}
