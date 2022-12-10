import 'package:json_annotation/json_annotation.dart';
part 'submit_outward_payment_request_entity.g.dart';

@JsonSerializable()
class SubmitOutwardPaymentRequestEntity {
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
  @JsonKey(name: "purposE_CODE")
  final String purposE_CODE;
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
  @JsonKey(name: "CustIDTO")
  final String CustIDTO;
  @JsonKey(name: "DbtrIsIndvl")
  final String DbtrIsIndvl;
  @JsonKey(name: "CdtrIsIndvl")
  final String CdtrIsIndvl;
  @JsonKey(name: "RmtInf")
  final String RmtInf;
  @JsonKey(name: "QRFlag")
  final String QRFlag;
  @JsonKey(name: "GetToken")
  final bool GetToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> BaseClass;

  SubmitOutwardPaymentRequestEntity(
      this.custID,
      this.dbtrAcct,
      this.dbtrName,
      this.dbtrPstlAdr,
      this.dbtrRecordID,
      this.dbtrAlias,
      this.currency,
      this.amount,
      this.purposE_CODE,
      this.cdtrBic,
      this.cdtrName,
      this.cdtrAcct,
      this.cdtrPstlAdr,
      this.cdtrRecordID,
      this.cdtrAlias,
      this.rgltryRptg,
      this.CustIDTO,
      this.DbtrIsIndvl,
      this.CdtrIsIndvl,
      this.RmtInf,
      this.QRFlag,
      this.GetToken,
      this.BaseClass);
  factory SubmitOutwardPaymentRequestEntity.fromJson(
          Map<String, dynamic> json) =>
      _$SubmitOutwardPaymentRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SubmitOutwardPaymentRequestEntityToJson(this);
}
