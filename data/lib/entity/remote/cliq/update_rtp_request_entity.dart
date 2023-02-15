import 'package:json_annotation/json_annotation.dart';

part "update_rtp_request_entity.g.dart";

@JsonSerializable()
class UpdateRtpRequestEntity {
  @JsonKey(name: "msgId")
  final String? msgId;

  @JsonKey(name: "rejectReason")
  final String? rejectReason;

  @JsonKey(name: "rejectAddInfo")
  final String? rejectAddInfo;

  @JsonKey(name: "dbtrBic")
  final String? dbtrBic;

  @JsonKey(name: "dbtrAcct")
  final String? dbtrAcct;

  @JsonKey(name: "dbtrName")
  final String? dbtrName;

  @JsonKey(name: "dbtrIsIndvl")
  final String? dbtrIsIndvl;

  @JsonKey(name: "cdtrBic")
  final String? cdtrBic;

  @JsonKey(name: "cdtrAcct")
  final String? cdtrAcct;

  @JsonKey(name: "cdtrName")
  final String? cdtrName;

  @JsonKey(name: "cdtrIsIndvl")
  final String? cdtrIsIndvl;

  @JsonKey(name: "rmtInf")
  final String? rmtInf;

  @JsonKey(name: "ctgyPurp")
  final String? ctgyPurp;

  @JsonKey(name: "amount")
  final String? amount;

  @JsonKey(name: "curr")
  final String? curr;

  @JsonKey(name: "rtpStatus")
  final bool? rtpStatus;

  @JsonKey(name: "otPcode")
  final String? otPcode;

  @JsonKey(name: "cdtrPstlAdr")
  final String? cdtrPstlAdr;

  @JsonKey(name: "dbtrPstlAdr")
  final String? dbtrPstlAdr;

  @JsonKey(name: "getToken")
  final bool? getToken;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  UpdateRtpRequestEntity(
      {required this.msgId,
      required this.rejectReason,
      required this.rejectAddInfo,
      required this.dbtrBic,
      required this.dbtrAcct,
      required this.dbtrName,
      required this.dbtrIsIndvl,
      required this.cdtrBic,
      required this.cdtrAcct,
      required this.cdtrName,
      required this.cdtrIsIndvl,
      required this.rmtInf,
      required this.ctgyPurp,
      required this.amount,
      required this.curr,
      required this.rtpStatus,
      required this.otPcode,
      required this.cdtrPstlAdr,
      required this.dbtrPstlAdr,
      required this.getToken,
      required this.baseData});

  factory UpdateRtpRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateRtpRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRtpRequestEntityToJson(this);
}
