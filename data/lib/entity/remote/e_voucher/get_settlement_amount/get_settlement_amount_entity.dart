import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
part 'get_settlement_amount_entity.g.dart';

@JsonSerializable()
class GetSettlementAmountEntity
    extends BaseLayerDataTransformer<GetSettlementAmountEntity, GetSettlementAmount> {
  @JsonKey(name: "Amount")
  final String? Amount;

  GetSettlementAmountEntity({
    required this.Amount,
  });

  Map<String, dynamic> toJson() => _$GetSettlementAmountEntityToJson(this);
  factory GetSettlementAmountEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSettlementAmountEntityFromJson(json);

  @override
  GetSettlementAmount transform() {
    return GetSettlementAmount(amount: this.Amount);
  }
}
