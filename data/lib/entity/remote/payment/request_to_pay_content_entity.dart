import 'package:domain/model/payment/request_to_pay_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "request_to_pay_content_entity.g.dart";

@JsonSerializable()
class RequestToPayContentEntity
    implements BaseLayerDataTransformer<RequestToPayContentEntity, RequestToPayContent> {
  @JsonKey(name: "custID")
  final String? custID;
  @JsonKey(name: "senderName")
  final String? senderName;
  @JsonKey(name: "senderPstlAdr")
  final String? senderPstlAdr;
  @JsonKey(name: "dbtrBic")
  final String? dbtrBic;
  @JsonKey(name: "dbtrAcct")
  final String? dbtrAcct;
  @JsonKey(name: "dbtrName")
  final String? dbtrName;
  @JsonKey(name: "dbtrPstlAdr")
  final String? dbtrPstlAdr;
  @JsonKey(name: "dbtrIsIndvl")
  final String? dbtrIsIndvl;
  @JsonKey(name: "dbtrRecordID")
  final String? dbtrRecordID;
  @JsonKey(name: "dbtrAlias")
  final String? dbtrAlias;
  @JsonKey(name: "dbtrMCC")
  final String? dbtrMCC;
  @JsonKey(name: "cdtrAcct")
  final String? cdtrAcct;
  @JsonKey(name: "cdtrName")
  final String? cdtrName;
  @JsonKey(name: "cdtrPstlAdr")
  final String? cdtrPstlAdr;
  @JsonKey(name: "cdtrIsIndvl")
  final String? cdtrIsIndvl;
  @JsonKey(name: "cdtrRecordID")
  final String? cdtrRecordID;
  @JsonKey(name: "cdtrAlias")
  final String? cdtrAlias;
  @JsonKey(name: "cdtrMCC")
  final String? cdtrMCC;
  @JsonKey(name: "instrInf")
  final String? instrInf;
  @JsonKey(name: "rgltryRptg")
  final String? rgltryRptg;
  @JsonKey(name: "rmtInf")
  final String? rmtInf;
  @JsonKey(name: "ctgyPurp")
  final String? ctgyPurp;
  @JsonKey(name: "curr")
  final String? curr;
  @JsonKey(name: "amount")
  final String? amount;
  @JsonKey(name: "payRefNo")
  final String? payRefNo;

  RequestToPayContentEntity(
      {this.custID,
      this.senderName,
      this.senderPstlAdr,
      this.dbtrBic,
      this.dbtrAcct,
      this.dbtrName,
      this.dbtrPstlAdr,
      this.dbtrIsIndvl,
      this.dbtrRecordID,
      this.dbtrAlias,
      this.dbtrMCC,
      this.cdtrAcct,
      this.cdtrName,
      this.cdtrPstlAdr,
      this.cdtrIsIndvl,
      this.cdtrRecordID,
      this.cdtrAlias,
      this.cdtrMCC,
      this.instrInf,
      this.rgltryRptg,
      this.rmtInf,
      this.ctgyPurp,
      this.curr,
      this.amount,
      this.payRefNo});

  factory RequestToPayContentEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestToPayContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToPayContentEntityToJson(this);

  @override
  RequestToPayContentEntity restore(RequestToPayContent response) {
    return RequestToPayContentEntity();
  }

  @override
  RequestToPayContent transform() {
    return RequestToPayContent(
      custId: this.custID,
      senderName: this.senderName,
      senderPstlAdr: this.senderPstlAdr,
      dbtrBic: this.dbtrBic,
      dbtrAcct: this.dbtrAcct,
      dbtrName: this.dbtrName,
      dbtrPstlAdr: this.dbtrPstlAdr,
      dbtrIsIndvl: this.dbtrIsIndvl,
      dbtrRecordId: this.dbtrRecordID,
      dbtrAlias: this.dbtrAlias,
      dbtrMcc: this.dbtrMCC,
      cdtrAcct: this.cdtrAcct,
      cdtrName: this.cdtrName,
      cdtrPstlAdr: this.cdtrPstlAdr,
      cdtrIsIndvl: this.cdtrIsIndvl,
      cdtrRecordId: this.cdtrRecordID,
      cdtrAlias: this.cdtrAlias,
      cdtrMcc: this.cdtrMCC,
      instrInf: this.instrInf,
      rgltryRptg: this.rgltryRptg,
      rmtInf: this.rmtInf,
      ctgyPurp: this.ctgyPurp,
      curr: this.curr,
      amount: this.amount,
      payRefNo: this.payRefNo,
    );
  }
}
