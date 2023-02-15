import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'create_cliq_id_otp_entity.dart';

part 'create_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class CreateCliqIdOtpResponseEntity
    extends BaseLayerDataTransformer<CreateCliqIdOtpResponseEntity, CreateCliqOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CreateCliqIdOtpResponseEntity(this.response);

  factory CreateCliqIdOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateCliqIdOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCliqIdOtpResponseEntityToJson(this);

  @override
  CreateCliqOtp transform() {
    return CreateCliqOtpEntity.fromJson(this.response!.content).transform();
  }
}
