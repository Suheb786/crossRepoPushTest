import 'package:domain/model/e_voucher/voucher_min_max_value.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_min_max_value_entity.g.dart';

@JsonSerializable()
class VoucherMinMaxValueEntity
    implements BaseLayerDataTransformer<VoucherMinMaxValueEntity, VoucherMinMaxValue> {
  @JsonKey(name: "minRange", defaultValue: 0.0)
  final num? minRange;
  @JsonKey(name: "maxRange", defaultValue: 0.0)
  final num? maxRange;

  const VoucherMinMaxValueEntity({
    this.minRange,
    this.maxRange,
  });

  factory VoucherMinMaxValueEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherMinMaxValueEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherMinMaxValueEntityToJson(this);

  @override
  VoucherMinMaxValueEntity restore(VoucherMinMaxValue data) {
    throw UnimplementedError();
  }

  @override
  VoucherMinMaxValue transform() {
    return VoucherMinMaxValue(
      minRange: this.minRange ?? 0.0,
      maxRange: this.maxRange ?? 0.0,
    );
  }
}
