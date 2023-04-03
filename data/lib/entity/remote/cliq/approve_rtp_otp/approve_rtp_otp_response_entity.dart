import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'approve_rtp_otp_entity.dart';

part 'approve_rtp_otp_response_entity.g.dart';

@JsonSerializable()
class ApproveRTPOtpResponseEntity
    extends BaseLayerDataTransformer<ApproveRTPOtpResponseEntity, ApproveRTPOtp> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ApproveRTPOtpResponseEntity(this.response);

  factory ApproveRTPOtpResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ApproveRTPOtpResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ApproveRTPOtpResponseEntityToJson(this);

  @override
  ApproveRTPOtp transform() {
    return ApproveRTPOtpEntity.fromJson(this.response!.content).transform();
  }
}
