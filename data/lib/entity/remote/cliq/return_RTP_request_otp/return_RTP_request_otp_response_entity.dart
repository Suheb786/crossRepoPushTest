// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data/entity/remote/cliq/approve_rtp_otp/approve_rtp_otp_response_entity.dart';
import 'package:data/entity/remote/cliq/return_RTP_request_otp/return_RTP_request_otp_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'return_RTP_request_otp_response_entity.g.dart';

@JsonSerializable()
class ReturnRTPrequestOTPResponseEntity
    extends BaseLayerDataTransformer<ApproveRTPOtpResponseEntity, ReturnRTPRequestOTP> {
  @JsonKey(name: "response")
  final ResponseEntity response;
  ReturnRTPrequestOTPResponseEntity({
    required this.response,
  });

  factory ReturnRTPrequestOTPResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ReturnRTPrequestOTPResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnRTPrequestOTPResponseEntityToJson(this);

  @override
  ReturnRTPRequestOTP transform() {
    return ReturnRTPRequestOTPEntity.fromJson(this.response.content).transform();
  }
}
