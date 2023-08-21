import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_settlement_amount_response_entity.g.dart';

@JsonSerializable()
class GetSettlementAmountResponseEntity
    extends BaseLayerDataTransformer<GetSettlementAmountResponseEntity, GetSettlementAmount> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetSettlementAmountResponseEntity({required this.response});

  Map<String, dynamic> toJson() => _$GetSettlementAmountResponseEntityToJson(this);

  factory GetSettlementAmountResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetSettlementAmountResponseEntityFromJson(json);

  @override
  GetSettlementAmount transform() {
    return GetSettlementAmount(content: this.response?.content);
  }
}
