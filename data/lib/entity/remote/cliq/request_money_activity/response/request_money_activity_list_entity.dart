import 'package:domain/constants/enum/payment_type_enum.dart';
import "package:domain/constants/enum/request_money_activity_enum.dart";
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_money_activity_list_entity.g.dart';

@JsonSerializable()
class RequestMoneyActivityListEntity
    extends BaseLayerDataTransformer<RequestMoneyActivityListEntity, RequestMoneyActivityList> {
  @JsonKey(
    name: "rmtInf",
    defaultValue: "",
  )
  final String? rmtInf;

  @JsonKey(
    name: "msgID",
    defaultValue: "",
  )
  final String? msgID;

  @JsonKey(
    name: "amount",
    defaultValue: 0.0,
  )
  final double? amount;

  @JsonKey(
    name: "creDtTm",
    defaultValue: "",
  )
  final String? creDtTm;

  @JsonKey(name: "processFlag", defaultValue: '')
  final String? processFlag;

  @JsonKey(
    name: "cdtrRecordID",
    defaultValue: "",
  )
  final String? cdtrRecordID;

  @JsonKey(
    name: "trxReason",
    defaultValue: "",
  )
  final String? trxReason;

  @JsonKey(
    name: "trxType",
    defaultValue: "",
  )
  final String? trxType;

  @JsonKey(
    name: "dbtrAgt",
    defaultValue: "",
  )
  final String? dbtrAgt;

  @JsonKey(
    name: "dbtrAlias",
    defaultValue: "",
  )
  final String? dbtrAlias;

  @JsonKey(
    name: "returnStatus",
    defaultValue: false,
  )
  final bool? returnStatus;

  @JsonKey(
    name: "ctgyPurp",
    defaultValue: "",
  )
  final String? ctgyPurp;

  @JsonKey(
    name: "returnDate",
    defaultValue: "",
  )
  final String? returnDate;

  @JsonKey(
    name: "intrBkSttlmDt",
    defaultValue: "",
  )
  final String? intrBkSttlmDt;

  @JsonKey(
    name: "payRefNo",
    defaultValue: "",
  )
  final String? payRefNo;

  @JsonKey(
    name: "rtpDate",
    defaultValue: "",
  )
  final String? rtpDate;

  @JsonKey(
    name: "addInfo4",
    defaultValue: "",
  )
  final String? addInfo4;

  @JsonKey(
    name: "cdtrMCC",
    defaultValue: "",
  )
  final String? cdtrMCC;

  @JsonKey(
    name: "dbtrMCC",
    defaultValue: "",
  )
  final String? dbtrMCC;

  @JsonKey(
    name: "cdtrIsIndvl",
    defaultValue: "",
  )
  final String? cdtrIsIndvl;

  @JsonKey(
    name: "dbtrAddr",
    defaultValue: "",
  )
  final String? dbtrAddr;

  @JsonKey(
    name: "cdtrAlias",
    defaultValue: "",
  )
  final String? cdtrAlias;

  @JsonKey(
    name: "cdtrName",
    defaultValue: "",
  )
  final String? cdtrName;

  @JsonKey(name: "dbtrRecordID", defaultValue: '')
  final String? dbtrRecordID;

  @JsonKey(
    name: "dbtrIsIndvl",
    defaultValue: "",
  )
  final String? dbtrIsIndvl;

  @JsonKey(
    name: "returnAmount",
    defaultValue: 0.0,
  )
  final double? returnAmount;

  @JsonKey(
    name: "cdtrAddr",
    defaultValue: "",
  )
  final String? cdtrAddr;

  @JsonKey(
    name: "trxStatus",
    defaultValue: "",
  )
  final String? trxStatus;

  @JsonKey(
    name: "rgltryRptg",
    defaultValue: "",
  )
  final String? rgltryRptg;

  @JsonKey(
    name: "instrInfo",
    defaultValue: "",
  )
  final String? instrInfo;

  @JsonKey(
    name: "curr",
    defaultValue: "",
  )
  final String? curr;

  @JsonKey(
    name: "svcLvl",
    defaultValue: "",
  )
  final String? svcLvl;

  @JsonKey(
    name: "trxDir",
    defaultValue: "",
  )
  final String? trxDir;

  @JsonKey(
    name: "dbtrAcct",
    defaultValue: "",
  )
  final String? dbtrAcct;

  @JsonKey(
    name: "dbtrName",
    defaultValue: "",
  )
  final String? dbtrName;

  @JsonKey(
    name: "cdtrAcct",
    defaultValue: "",
  )
  final String? cdtrAcct;

  @JsonKey(
    name: "cdtrAgt",
    defaultValue: "",
  )
  final String? cdtrAgt;

  @JsonKey(
    name: "addInfo1",
    defaultValue: "",
  )
  final String? addInfo1;

  @JsonKey(
    name: "allowReturn",
    defaultValue: false,
  )
  final bool? allowReturn;

  @JsonKey(
    name: "isFullReturn",
    defaultValue: false,
  )
  final bool? isFullReturn;

  @JsonKey(
    name: "statusDate",
    defaultValue: "",
  )
  final String? statusDate;

  @JsonKey(
    name: "addInfo3",
    defaultValue: "",
  )
  final String? addInfo3;

  @JsonKey(
    name: "paymentDate",
    defaultValue: "",
  )
  final String? paymentDate;

  @JsonKey(
    name: "errorCode",
    defaultValue: 0.0,
  )
  final num? errorCode;

  @JsonKey(
    name: "paymentType",
    defaultValue: "",
  )
  final String? paymentType;

  @JsonKey(
    name: "activityDate",
    defaultValue: "",
  )
  final String? activityDate;

  RequestMoneyActivityListEntity(
      {required this.rmtInf,
      required this.msgID,
      required this.amount,
      required this.creDtTm,
      required this.processFlag,
      required this.cdtrRecordID,
      required this.trxReason,
      required this.trxType,
      required this.dbtrAgt,
      required this.dbtrAlias,
      required this.returnStatus,
      required this.ctgyPurp,
      required this.returnDate,
      required this.intrBkSttlmDt,
      required this.payRefNo,
      required this.rtpDate,
      required this.addInfo4,
      required this.cdtrMCC,
      required this.dbtrMCC,
      required this.cdtrIsIndvl,
      required this.dbtrAddr,
      required this.cdtrAlias,
      required this.cdtrName,
      required this.dbtrRecordID,
      required this.dbtrIsIndvl,
      required this.returnAmount,
      required this.cdtrAddr,
      required this.trxStatus,
      required this.rgltryRptg,
      required this.instrInfo,
      required this.curr,
      required this.svcLvl,
      required this.trxDir,
      required this.dbtrAcct,
      required this.dbtrName,
      required this.cdtrAcct,
      required this.cdtrAgt,
      required this.addInfo1,
      required this.allowReturn,
      required this.isFullReturn,
      required this.statusDate,
      required this.addInfo3,
      required this.paymentDate,
      required this.errorCode,
      required this.paymentType,
      required this.activityDate});

  factory RequestMoneyActivityListEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestMoneyActivityListEntityFromJson(json);

  @override
  RequestMoneyActivityList transform() {
    return RequestMoneyActivityList(
      msgID: this.msgID,
      trxType: this.trxType,
      trxDir: this.trxDir!.fromRequestactivityStatus(),
      amount: this.amount,
      curr: this.curr,
      svcLvl: this.svcLvl,
      ctgyPurp: this.ctgyPurp,
      dbtrAgt: this.dbtrAgt,
      dbtrAcct: this.dbtrAcct,
      dbtrName: this.dbtrName,
      dbtrAddr: this.dbtrAddr,
      dbtrIsIndvl: this.dbtrIsIndvl,
      dbtrRecordID: this.dbtrRecordID,
      dbtrAlias: this.dbtrAlias,
      dbtrMCC: this.dbtrMCC,
      cdtrAgt: this.cdtrAgt,
      cdtrAcct: this.cdtrAcct,
      cdtrName: this.cdtrName,
      cdtrAddr: this.cdtrAddr,
      cdtrIsIndvl: this.cdtrIsIndvl,
      cdtrRecordID: this.cdtrRecordID,
      cdtrAlias: this.cdtrAlias,
      cdtrMCC: this.cdtrMCC,
      instrInfo: this.instrInfo,
      rmtInf: this.rmtInf,
      rgltryRptg: this.rgltryRptg,
      addInfo1: this.addInfo1,
      addInfo3: this.addInfo3,
      addInfo4: this.addInfo4,
      trxStatus: this.trxStatus?.fromRequestactivityStatus(),
      trxReason: this.trxReason,
      processFlag: this.processFlag,
      rtpDate: this.rtpDate,
      statusDate: this.statusDate,
      payRefNo: this.payRefNo,
      errorCode: this.errorCode,
      returnDate: this.returnDate,
      creDtTm: this.creDtTm,
      intrBkSttlmDt: this.intrBkSttlmDt,
      paymentType: this.paymentType?.fromPaymentType(),
      paymentDate: this.paymentDate,
      allowReturn: this.allowReturn,
      returnStatus: this.returnStatus,
      isFullReturn: this.isFullReturn,
      returnAmount: this.returnAmount,
      activityDate: this.activityDate,
    );
  }

  Map<String, dynamic> toJson() => _$RequestMoneyActivityListEntityToJson(this);
}
