import 'package:data/entity/remote/e_voucher/get_voucher_details/get_voucher_details_entity.dart';
import 'package:domain/model/e_voucher/get_voucher_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../user/response_entity.dart';
part 'get_voucher_details_response_entity.g.dart';

@JsonSerializable()
class GetVoucherDetailResponseEntity
    extends BaseLayerDataTransformer<GetVoucherDetailResponseEntity, GetVoucherDetails> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetVoucherDetailResponseEntity(this.response);

  factory GetVoucherDetailResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetVoucherDetailResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetVoucherDetailResponseEntityToJson(this);

  @override
  GetVoucherDetails transform() {
    return GetVoucherDetailsEntity.fromJson(response?.content as Map<String, dynamic>).transform();
  }
}
