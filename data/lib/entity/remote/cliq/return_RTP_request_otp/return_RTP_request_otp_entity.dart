// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "return_RTP_request_otp_entity.g.dart";

@JsonSerializable()
class ReturnRTPRequestOTPEntity
    extends BaseLayerDataTransformer<ReturnRTPRequestOTPEntity, ReturnRTPRequestOTP> {
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;

  ReturnRTPRequestOTPEntity({
    required this.mobileCode,
    required this.mobileNumber,
  });

  factory ReturnRTPRequestOTPEntity.fromJson(Map<String, dynamic> json) =>
      _$ReturnRTPRequestOTPEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnRTPRequestOTPEntityToJson(this);

  @override
  ReturnRTPRequestOTP transform() {
    return ReturnRTPRequestOTP(mobileCode: this.mobileCode ?? "", mobileNumber: this.mobileNumber ?? "");
  }
}
