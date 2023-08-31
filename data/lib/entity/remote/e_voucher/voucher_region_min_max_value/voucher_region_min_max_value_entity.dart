import 'package:data/entity/remote/e_voucher/voucher_min_max_value/voucher_min_max_value_entity.dart';
import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_entity.dart';
import 'package:domain/model/e_voucher/voucher_region_min_max_value.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_min_max_value_entity.g.dart';

@JsonSerializable()
class VoucherRegionMinMaxValueEntity
    implements BaseLayerDataTransformer<VoucherRegionMinMaxValueEntity, VoucherRegionsAndMinMax> {
  @JsonKey(name: "minMaxRange")
  VoucherMinMaxValueEntity? minMaxRange;

  @JsonKey(name: "allowedRegions", defaultValue: [])
  List<VoucherRegionByCategoriesEntity>? allowedRegions;

  VoucherRegionMinMaxValueEntity({
    this.minMaxRange,
    this.allowedRegions,
  });

  factory VoucherRegionMinMaxValueEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionMinMaxValueEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionMinMaxValueEntityToJson(this);

  @override
  VoucherRegionMinMaxValueEntity restore(VoucherRegionsAndMinMax data) {
    throw UnimplementedError();
  }

  @override
  VoucherRegionsAndMinMax transform() {
    return VoucherRegionsAndMinMax(
      minMaxRange: this.minMaxRange?.transform(),
      allowedRegions: this.allowedRegions?.map((e) => e.transform()).toList(),
    );
  }
}
