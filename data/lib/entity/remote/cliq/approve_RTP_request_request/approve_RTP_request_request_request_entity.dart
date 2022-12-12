import 'package:json_annotation/json_annotation.dart';
part 'approve_RTP_request_request_request_entity.g.dart';
@JsonSerializable()
class ApproveRTPRequestReqestEntity {
  @JsonKey(name: "custID")
  final String custID;
  @JsonKey(name: "dbtrAcct")
  final String dbtrAcct;
  @JsonKey(name: "dbtrName")
  final String dbtrName;
  @JsonKey(name: "dbtrPstlAdr")
  final String dbtrPstlAdr;
  @JsonKey(name: "dbtrRecordID")
  final String dbtrRecordID;
  @JsonKey(name: "dbtrAlias")
  final String dbtrAlias;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "amount")
  final String amount;
  @JsonKey(name: "cdtrBic")
  final String cdtrBic;
  @JsonKey(name: "cdtrName")
  final String cdtrName;
  @JsonKey(name: "cdtrAcct")
  final String cdtrAcct;
  @JsonKey(name: "cdtrPstlAdr")
  final String cdtrPstlAdr;
  @JsonKey(name: "cdtrRecordID")
  final String cdtrRecordID;
  @JsonKey(name: "cdtrAlias")
  final String cdtrAlias;
  @JsonKey(name: "rgltryRptg")
  final String rgltryRptg;
  @JsonKey(name: "payRefNo")
  final String payRefNo;
  @JsonKey(name: "rejectReason")
  final String rejectReason;
  @JsonKey(name: "rejectADdInfo")
  final String rejectADdInfo;
  @JsonKey(name: "rtpStatus")
  final String rtpStatus;
  @JsonKey(name: "GetToken")
  final bool GetToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

 

  ApproveRTPRequestReqestEntity(
      {required this.dbtrName,
      required this.dbtrPstlAdr,
      required this.dbtrRecordID,
      required this.dbtrAlias,
      required this.currency,
      required this.amount,
      required this.cdtrBic,
      required this.cdtrName,
      required this.cdtrAcct,
      required this.cdtrPstlAdr,
      required this.cdtrRecordID,
      required this.cdtrAlias,
      required this.rgltryRptg,
      required this.payRefNo,
      required this.rejectReason,
      required this.rejectADdInfo,
      required this.rtpStatus,
      required this.GetToken,
      required this.BaseClass,
      required this.custID,
      required this.dbtrAcct});

  Map<String, dynamic> toJson() => _$ApproveRTPRequestReqestEntityToJson(this);

 factory ApproveRTPRequestReqestEntity.fromJson(Map<String, dynamic> json) =>
      _$ApproveRTPRequestReqestEntityFromJson(json);
}
