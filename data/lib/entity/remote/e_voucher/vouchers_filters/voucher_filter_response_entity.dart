import 'package:data/entity/remote/e_voucher/vouchers_filters/voucher_item_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_filter_response_entity.g.dart';

@JsonSerializable()
class VoucherFilterResponseEntity
    extends BaseLayerDataTransformer<VoucherFilterResponseEntity, List<VoucherItem>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherFilterResponseEntity(this.response);

  factory VoucherFilterResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherFilterResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherFilterResponseEntityToJson(this);

  @override
  List<VoucherItem> transform() {
    var content = response?.content as List<dynamic>;
    List<VoucherItem> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return VoucherItemEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
