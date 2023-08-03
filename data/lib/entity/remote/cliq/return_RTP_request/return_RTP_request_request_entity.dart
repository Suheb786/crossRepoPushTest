import 'package:json_annotation/json_annotation.dart';

part 'return_RTP_request_request_entity.g.dart';

@JsonSerializable()
class ReturnRTPrequestRequestEntity {
  @JsonKey(name: "CustID")
  final String? CustID;
  @JsonKey(name: "MessageID")
  final String? MessageID;
  @JsonKey(name: "DbtrAcct")
  final String? DbtrAcct;
  @JsonKey(name: "DbtrName")
  final String? DbtrName;
  @JsonKey(name: "CdtrAcct")
  final String? CdtrAcct;
  @JsonKey(name: "CdtrName")
  final String? CdtrName;
  @JsonKey(name: "Currency")
  final String? Currency;
  @JsonKey(name: "Amount")
  final double? Amount;
  @JsonKey(name: "RtrnReason")
  final String? RtrnReason;
  @JsonKey(name: "RtrnAddInfo")
  final String? RtrnAddInfo;
  @JsonKey(name: "IsDispute")
  final bool? IsDispute;
  @JsonKey(name: "DisputeRefNo")
  final String? DisputeRefNo;
  @JsonKey(name: "OtpCode")
  final String? OtpCode;
  @JsonKey(name: "GetToken")
  final bool? GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic>? BaseClass;

  ReturnRTPrequestRequestEntity({
    required this.CustID,
    required this.MessageID,
    required this.DbtrAcct,
    required this.DbtrName,
    required this.CdtrAcct,
    required this.CdtrName,
    required this.Currency,
    required this.Amount,
    required this.RtrnReason,
    required this.RtrnAddInfo,
    required this.IsDispute,
    required this.DisputeRefNo,
    required this.OtpCode,
    required this.GetToken,
    required this.BaseClass,
  });

  Map<String, dynamic> toJson() => _$ReturnRTPrequestRequestEntityToJson(this);

  factory ReturnRTPrequestRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ReturnRTPrequestRequestEntityFromJson(json);
}
