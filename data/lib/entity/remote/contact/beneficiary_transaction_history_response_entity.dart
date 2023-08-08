import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beneficiary_transaction_history_content_entity.dart';

part "beneficiary_transaction_history_response_entity.g.dart";

@JsonSerializable()
class BeneficiaryTransactionHistoryResponseEntity
    implements
        BaseLayerDataTransformer<BeneficiaryTransactionHistoryResponseEntity,
            BeneficiaryTransactionHistoryResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  BeneficiaryTransactionHistoryResponseEntity({this.response});

  factory BeneficiaryTransactionHistoryResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$BeneficiaryTransactionHistoryResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BeneficiaryTransactionHistoryResponseEntityToJson(this);

  @override
  BeneficiaryTransactionHistoryResponseEntity restore(BeneficiaryTransactionHistoryResponse response) {
    return BeneficiaryTransactionHistoryResponseEntity();
  }

  @override
  BeneficiaryTransactionHistoryResponse transform() {
    return BeneficiaryTransactionHistoryResponse(
        beneficiaryTransactionHistoryContent: (this.response!.content as List<dynamic>)
            .map((e) => BeneficiaryTransactionHistoryContentEntity.fromJson(e).transform())
            .toList());
  }
}
