import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_category_entity.g.dart';

@JsonSerializable()
class VoucherCategoryEntity implements BaseLayerDataTransformer<VoucherCategoryEntity, VoucherCategories> {
  @JsonKey(name: "bankCategory", defaultValue: '')
  final String? bankCategory;
  @JsonKey(name: "bankCategoryAr", defaultValue: '')
  final String? bankCategoryAr;
  @JsonKey(name: "bankCategoryIcon", defaultValue: '')
  final String? bankCategoryIcon;
  @JsonKey(name: "muneroCategories", defaultValue: '')
  final String? muneroCategories;

  VoucherCategoryEntity(
      {this.bankCategory, this.bankCategoryAr, this.bankCategoryIcon, this.muneroCategories});

  factory VoucherCategoryEntity.fromJson(Map<String, dynamic> json) => _$VoucherCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherCategoryEntityToJson(this);

  @override
  VoucherCategoryEntity restore(VoucherCategories data) {
    throw UnimplementedError();
  }

  @override
  VoucherCategories transform() {
    return VoucherCategories(
        bankCategory: this.bankCategory ?? '',
        bankCategoryAr: this.bankCategoryAr ?? '',
        bankCategoryIcon: this.bankCategoryIcon ?? '',
        muneroCategories: this.muneroCategories ?? '');
  }
}
