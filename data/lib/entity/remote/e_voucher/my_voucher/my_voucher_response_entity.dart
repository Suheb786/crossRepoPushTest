import 'package:data/entity/remote/e_voucher/my_voucher/voucher_category_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'my_voucher_response_entity.g.dart';

@JsonSerializable()
class MyVoucherResponseEntity
    extends BaseLayerDataTransformer<MyVoucherResponseEntity, List<VoucherCategories>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  MyVoucherResponseEntity(this.response);

  factory MyVoucherResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$MyVoucherResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MyVoucherResponseEntityToJson(this);

  @override
  List<VoucherCategories> transform() {
    var content = response?.content as List<dynamic>;
    List<VoucherCategories> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return VoucherCategoryEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
