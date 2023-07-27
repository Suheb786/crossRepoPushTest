import 'package:data/entity/local/base/image_utils.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_category_entity.g.dart';

@JsonSerializable()
class VoucherCategoryEntity implements BaseLayerDataTransformer<VoucherCategoryEntity, VoucherCategories> {
  @JsonKey(name: "id", defaultValue: 0.0)
  final num? id;

  @JsonKey(name: "categoryName", defaultValue: '')
  final String? categoryName;

  @JsonKey(name: "createdDate", defaultValue: '')
  final String? createdDate;

  @JsonKey(name: "createdBy", defaultValue: '')
  final String? createdBy;

  @JsonKey(name: "updatedDate", defaultValue: '')
  final String? updatedDate;

  @JsonKey(name: "updatedBy", defaultValue: '')
  final String? updatedBy;

  @JsonKey(name: "categoryNameAr", defaultValue: '')
  final String? categoryNameAr;

  @JsonKey(name: "categoryIcon", defaultValue: '')
  final dynamic categoryIcon;

  VoucherCategoryEntity({
    this.id,
    this.categoryName,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.categoryNameAr,
    this.categoryIcon,
  });

  factory VoucherCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherCategoryEntityToJson(this);

  @override
  VoucherCategoryEntity restore(VoucherCategories data) {
    throw UnimplementedError();
  }

  @override
  VoucherCategories transform() {
    return VoucherCategories(
      id: this.id ?? 0.0,
      categoryName: Intl.getCurrentLocale() == 'en' ? this.categoryName ?? '' : this.categoryNameAr ?? '',
      createdDate: this.createdDate ?? '',
      createdBy: this.createdBy ?? '',
      updatedDate: this.updatedDate ?? '',
      updatedBy: this.updatedBy ?? '',
      categoryNameAr: this.categoryNameAr ?? '',
      categoryIcon: this.categoryIcon != null ? ImageUtils.dataFromBase64String(this.categoryIcon!) : '',
    );
  }
}
