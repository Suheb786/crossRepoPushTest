// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
part 'return_RTP_request_otp.g.dart';

@JsonSerializable()
class ReturnRTPRequestOTPResponseEntity
    extends BaseLayerDataTransformer<ReturnRTPRequestOTPResponseEntity, ReturnRTPRequestOTP> {
  @JsonKey(name: "mobileCode")
  final String? mobileCode;
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;
  ReturnRTPRequestOTPResponseEntity({
    required this.mobileCode,
    required this.mobileNumber,
  });

  factory ReturnRTPRequestOTPResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ReturnRTPRequestOTPResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnRTPRequestOTPResponseEntityToJson(this);

  @override
  ReturnRTPRequestOTP transform() {
    return ReturnRTPRequestOTP(mobileCode: this.mobileCode ?? "", mobileNumber: this.mobileNumber ?? "");
  }
}
