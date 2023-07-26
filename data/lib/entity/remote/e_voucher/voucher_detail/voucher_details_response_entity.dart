import 'package:data/entity/remote/e_voucher/voucher_detail/voucher_detail_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/e_voucher/voucher_detail.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_details_response_entity.g.dart';

@JsonSerializable()
class VoucherDetailsResponseEntity
    extends BaseLayerDataTransformer<VoucherDetailsResponseEntity, VoucherDetail> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  VoucherDetailsResponseEntity(this.response);

  factory VoucherDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$VoucherDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDetailsResponseEntityToJson(this);

  @override
  VoucherDetail transform() {
    return VoucherDetailEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
