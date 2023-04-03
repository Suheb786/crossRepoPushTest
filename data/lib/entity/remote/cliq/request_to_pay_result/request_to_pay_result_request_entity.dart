import 'package:json_annotation/json_annotation.dart';

part 'request_to_pay_result_request_entity.g.dart';

@JsonSerializable()
class RequestToPayResultRequestEntity {
  @JsonKey(name: "CustID")
  final String CustID;
  @JsonKey(name: "OrgnlMsgId")
  final String OrgnlMsgId;
  @JsonKey(name: "RTPStatus")
  final String RTPStatus;
  @JsonKey(name: "RejectReason")
  final String RejectReason;
  @JsonKey(name: "RejectADdInfo")
  final String RejectADdInfo;
  @JsonKey(name: "OtpCode")
  final String otpCode;
  @JsonKey(name: "GetToken")
  final bool GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  RequestToPayResultRequestEntity({
    required this.CustID,
    required this.OrgnlMsgId,
    required this.RTPStatus,
    required this.RejectReason,
    required this.RejectADdInfo,
    required this.otpCode,
    required this.GetToken,
    required this.BaseClass,
  });

  factory RequestToPayResultRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayResultRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayResultRequestEntityToJson(this);
}
