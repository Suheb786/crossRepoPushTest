import 'package:data/entity/remote/e_voucher/voucher_region_by_categories/voucher_region_by_categories_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_region_by_categories_response_entity.g.dart';

@JsonSerializable()
class VoucherRegionByCategoriesResponseEntity extends BaseLayerDataTransformer<
    VoucherRegionByCategoriesResponseEntity, List<VoucherRegionByCategories>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherRegionByCategoriesResponseEntity(this.response);

  factory VoucherRegionByCategoriesResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherRegionByCategoriesResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRegionByCategoriesResponseEntityToJson(this);

  @override
  List<VoucherRegionByCategories> transform() {
    var content = response?.content as List<dynamic>;
    List<VoucherRegionByCategories> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return VoucherRegionByCategoriesEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
