import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_by_categories_entity.g.dart';

@JsonSerializable()
class VoucherRegionByCategoriesEntity
    implements BaseLayerDataTransformer<VoucherRegionByCategoriesEntity, VoucherRegionByCategories> {
  @JsonKey(name: "isoCode3", defaultValue: '')
  String? isoCode3;
  @JsonKey(name: "isoCode", defaultValue: '')
  String? isoCode;
  @JsonKey(name: "countryName", defaultValue: '')
  String? countryName;
  @JsonKey(name: "countryNameAR", defaultValue: '')
  String? countryNameAR;

  VoucherRegionByCategoriesEntity({
    this.isoCode3,
    this.isoCode,
    this.countryName,
    this.countryNameAR,
  });

  factory VoucherRegionByCategoriesEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionByCategoriesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionByCategoriesEntityToJson(this);

  @override
  VoucherRegionByCategoriesEntity restore(VoucherRegionByCategories data) {
    throw UnimplementedError();
  }

  @override
  VoucherRegionByCategories transform() {
    return VoucherRegionByCategories(
      isoCode3: this.isoCode3 ?? '',
      isoCode: this.isoCode ?? '',
      countryName: Intl.getCurrentLocale() == 'en' ? this.countryName ?? '' : this.countryNameAR ?? '',
      countryNameAR: this.countryNameAR ?? '',
    );
  }
}
