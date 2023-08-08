import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_settlement_amount_entity.g.dart';

@JsonSerializable()
class GetSettlementAmountEntity
    extends BaseLayerDataTransformer<GetSettlementAmountEntity, GetSettlementAmount> {
  @JsonKey(name: "content")
  final double? content;

  GetSettlementAmountEntity({
    required this.content,
  });

  Map<String, dynamic> toJson() => _$GetSettlementAmountEntityToJson(this);

  factory GetSettlementAmountEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSettlementAmountEntityFromJson(json);

  @override
  GetSettlementAmount transform() {
    return GetSettlementAmount(content: this.content);
  }
}
