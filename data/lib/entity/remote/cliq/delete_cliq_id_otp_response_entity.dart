import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/delete_cliq_id/delete_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'delete_cliq_id_otp_entity.dart';

part 'delete_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class DeleteCliqIdOtpResponseEntity
    extends BaseLayerDataTransformer<DeleteCliqIdOtpResponseEntity, DeleteCliqIdOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  DeleteCliqIdOtpResponseEntity(this.response);

  factory DeleteCliqIdOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DeleteCliqIdOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCliqIdOtpResponseEntityToJson(this);

  @override
  DeleteCliqIdOtp transform() {
    return DeleteCliqIdOtpEntity.fromJson(this.response!.content).transform();
  }
}
