// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'approve_rtp_otp_request_entity.g.dart';

@JsonSerializable()
class ApproveRTPOtpRequestEntity {
  @JsonKey(name: "GetToken")
  final bool getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseClass;

  ApproveRTPOtpRequestEntity({required this.getToken, required this.baseClass});

  Map<String, dynamic> toJson() => _$ApproveRTPOtpRequestEntityToJson(this);

  factory ApproveRTPOtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ApproveRTPOtpRequestEntityFromJson(json);
}
