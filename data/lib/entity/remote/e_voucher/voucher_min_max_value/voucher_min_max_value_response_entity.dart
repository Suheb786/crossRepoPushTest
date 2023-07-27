import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/usecase/evouchers/voucher_min_max_value.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_min_max_value_response_entity.g.dart';

@JsonSerializable()
class VoucherMinMaxValueResponseEntity
    extends BaseLayerDataTransformer<VoucherMinMaxValueResponseEntity, VoucherMinMaxValue> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherMinMaxValueResponseEntity(this.response);

  factory VoucherMinMaxValueResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherMinMaxValueResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherMinMaxValueResponseEntityToJson(this);

  @override
  VoucherMinMaxValue transform() {
    return VoucherMinMaxValueEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
