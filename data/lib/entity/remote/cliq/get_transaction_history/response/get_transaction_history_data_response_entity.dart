// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
part 'get_transaction_history_data_response_entity.g.dart';

@JsonSerializable()
class GetTransactionHistoryDataResponseEntity {
  @JsonKey(name: "msgID")
  final String? msgID;

  @JsonKey(name: "trxType")
  final String trxType;
  @JsonKey(name: "trxDir")
  final String? trxDir;
  @JsonKey(name: "dbtrAgt")
  final String? dbtrAgt;

  @JsonKey(name: "cdtrAgt")
  final String? cdtrAgt;
  @JsonKey(name: "amount")
  final double? amount;
  @JsonKey(name: "curr")
  final String? curr;
  @JsonKey(name: "dbtrAcct")
  final String? dbtrAcct;

  @JsonKey(name: "cdtrAcct")
  final String? cdtrAcct;

  @JsonKey(name: "creDtTm")
  final String? creDtTm;

  @JsonKey(name: "intrBkSttlmDt")
  final String? intrBkSttlmDt;

  @JsonKey(name: "ctgyPurp")
  final String? ctgyPurp;

  @JsonKey(name: "rmtInf")
  final String? rmtInf;

  @JsonKey(name: "rgltryRptg")
  final String? rgltryRptg;

  @JsonKey(name: "dbtrName")
  final String? dbtrName;

  @JsonKey(name: "dbtrAddr")
  final String? dbtrAddr;

  @JsonKey(name: "dbtrRecordID")
  final String? dbtrRecordID;

  @JsonKey(name: "dbtrAlias")
  final String? dbtrAlias;

  @JsonKey(name: "dbtrMCC")
  final String? dbtrMCC;

  @JsonKey(name: "cdtrName")
  final String? cdtrName;

  @JsonKey(name: "cdtrAddr")
  final String? cdtrAddr;

  @JsonKey(name: "cdtrRecordID")
  final String? cdtrRecordID;

  @JsonKey(name: "cdtrAlias")
  final String? cdtrAlias;

  @JsonKey(name: "cdtrMCC")
  final String? cdtrMCC;

  @JsonKey(name: "addInfo1")
  final String? addInfo1;

  @JsonKey(name: "addInfo2")
  final String? addInfo2;

  @JsonKey(name: "addInfo3")
  final String? addInfo3;

  @JsonKey(name: "addInfo4")
  final String? addInfo4;

  @JsonKey(name: "trxStatus")
  final String? trxStatus;

  @JsonKey(name: "trxReason")
  final String? trxReason;

  @JsonKey(name: "payRefNo")
  final String? payRefNo;

  @JsonKey(name: "errorCode")
  final double? errorCode;

  @JsonKey(name: "paymentDate")
  final String? paymentDate;

  @JsonKey(name: "allowReturn")
  final bool? allowReturn;

  @JsonKey(name: "returnAmount")
  final String? returnAmount;

  @JsonKey(name: "returnStatus")
  final bool? returnStatus;

  @JsonKey(name: "returnDate")
  final String? returnDate;

  @JsonKey(name: "isFullReturn")
  final bool? isFullReturn;

  GetTransactionHistoryDataResponseEntity({
    required this.msgID,
    required this.trxType,
    required this.trxDir,
    required this.dbtrAgt,
    required this.cdtrAgt,
    required this.amount,
    required this.curr,
    required this.dbtrAcct,
    required this.cdtrAcct,
    required this.creDtTm,
    required this.intrBkSttlmDt,
    required this.ctgyPurp,
    required this.rmtInf,
    required this.rgltryRptg,
    required this.dbtrName,
    required this.dbtrAddr,
    required this.dbtrRecordID,
    required this.dbtrAlias,
    required this.dbtrMCC,
    required this.cdtrName,
    required this.cdtrAddr,
    required this.cdtrRecordID,
    required this.cdtrAlias,
    required this.cdtrMCC,
    required this.addInfo1,
    required this.addInfo2,
    required this.addInfo3,
    required this.addInfo4,
    required this.trxStatus,
    required this.trxReason,
    required this.payRefNo,
    required this.errorCode,
    required this.paymentDate,
    required this.allowReturn,
    required this.returnAmount,
    required this.returnStatus,
    required this.returnDate,
    required this.isFullReturn,
  });
  factory GetTransactionHistoryDataResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetTransactionHistoryDataResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetTransactionHistoryDataResponseEntityToJson(this);
}
