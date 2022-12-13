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

  RequestToPayResultRequestEntity(
      {required this.CustID,
      required this.OrgnlMsgId,
      required this.RTPStatus,
      required this.RejectReason,
      required this.RejectADdInfo});

  factory RequestToPayResultRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayResultRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayResultRequestEntityToJson(this);
}
