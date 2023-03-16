import 'package:data/entity/remote/cliq/re_activate_cliq_id_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/re_activate_cliq_id/re_activate_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 're_activate_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class ReActivateCliqIdOtpResponseEntity
    extends BaseLayerDataTransformer<ReActivateCliqIdOtpResponseEntity, ReActivateCliqIdOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ReActivateCliqIdOtpResponseEntity(this.response);

  factory ReActivateCliqIdOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ReActivateCliqIdOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReActivateCliqIdOtpResponseEntityToJson(this);

  @override
  ReActivateCliqIdOtp transform() {
    return ReActivateCliqIdOtpEntity.fromJson(this.response!.content).transform();
  }
}
