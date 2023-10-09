import 'package:data/entity/remote/e_voucher/voucher_region_min_max_value/voucher_region_min_max_value_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_region_min_max_value.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_min_max_value_response_entity.g.dart';

@JsonSerializable()
class VoucherRegionMinMaxValueResponseEntity
    extends BaseLayerDataTransformer<VoucherRegionMinMaxValueResponseEntity, VoucherRegionsAndMinMax> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherRegionMinMaxValueResponseEntity(this.response);

  factory VoucherRegionMinMaxValueResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionMinMaxValueResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionMinMaxValueResponseEntityToJson(this);

  @override
  VoucherRegionsAndMinMax transform() {
    return VoucherRegionMinMaxValueEntity.fromJson(this.response!.content).transform();
  }
}
