import 'package:data/entity/remote/cliq/suspend_cliq_id_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/suspend_cliq_id/suspend_cliq_id_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suspend_cliq_id_otp_response_entity.g.dart';

@JsonSerializable()
class SuspendCliqIdOtpResponseEntity
    extends BaseLayerDataTransformer<SuspendCliqIdOtpResponseEntity, SuspendCliqIdOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  SuspendCliqIdOtpResponseEntity(this.response);

  factory SuspendCliqIdOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$SuspendCliqIdOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SuspendCliqIdOtpResponseEntityToJson(this);

  @override
  SuspendCliqIdOtp transform() {
    return SuspendCliqIdOtpEntity.fromJson(this.response!.content).transform();
  }
}
