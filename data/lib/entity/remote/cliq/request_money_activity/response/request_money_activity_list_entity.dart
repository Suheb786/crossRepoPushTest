import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_money_activity_list_entity.g.dart';

@JsonSerializable()
class RequestMoneyActivityListEntity extends BaseLayerDataTransformer<
    RequestMoneyActivityListEntity, RequestMoneyActivityList> {
  RequestMoneyActivityListEntity({
    required this.msgID,
    required this.trxType,
    required this.trxDir,
    required this.amount,
    required this.curr,
    required this.svcLvl,
    required this.ctgyPurp,
    required this.dbtrAgt,
    required this.dbtrAcct,
    required this.dbtrName,
    required this.dbtrAddr,
    required this.dbtrIsIndvl,
    required this.dbtrRecordID,
    required this.dbtrAlias,
    required this.dbtrMCC,
    required this.cdtrAgt,
    required this.cdtrAcct,
    required this.cdtrName,
    required this.cdtrAddr,
    required this.cdtrIsIndvl,
    required this.cdtrRecordID,
    required this.cdtrAlias,
    required this.cdtrMCC,
    required this.instrInfo,
    required this.rmtInf,
    required this.rgltryRptg,
    required this.addInfo1,
    required this.addInfo2,
    required this.addInfo3,
    required this.addInfo4,
    required this.trxStatus,
    required this.trxReason,
    required this.processFlag,
    required this.rtpDate,
    required this.statusDate,
    required this.payRefNo,
    required this.errorCode,
  });

  factory RequestMoneyActivityListEntity.fromJson(Map<String, dynamic> json) =>
      _$RequestMoneyActivityListEntityFromJson(json);

  @JsonKey(
    name: "addInfo1",
    defaultValue: "",
  )
  final String addInfo1;

  @JsonKey(
    name: "addInfo2",
    defaultValue: "",
  )
  final String addInfo2;

  @JsonKey(
    name: "addInfo3",
    defaultValue: "",
  )
  final String addInfo3;

  @JsonKey(
    name: "addInfo4",
    defaultValue: "",
  )
  final String addInfo4;

  @JsonKey(
    name: "amount",
  )
  final double amount;

  @JsonKey(
    name: "cdtrAcct",
    defaultValue: "",
  )
  final String cdtrAcct;

  @JsonKey(
    name: "cdtrAddr",
    defaultValue: "",
  )
  final String cdtrAddr;

  @JsonKey(
    name: "cdtrAgt",
    defaultValue: "",
  )
  final String cdtrAgt;

  @JsonKey(
    name: "cdtrAlias",
    defaultValue: "",
  )
  final String cdtrAlias;

  @JsonKey(
    name: "cdtrIsIndvl",
    defaultValue: "",
  )
  final String cdtrIsIndvl;

  @JsonKey(
    name: "cdtrMCC",
    defaultValue: "",
  )
  final String cdtrMCC;

  @JsonKey(
    name: "cdtrName",
    defaultValue: "",
  )
  final String cdtrName;

  @JsonKey(
    name: "cdtrRecordID",
    defaultValue: "",
  )
  final String cdtrRecordID;

  @JsonKey(
    name: "ctgyPurp",
    defaultValue: "",
  )
  final String ctgyPurp;

  @JsonKey(
    name: "curr",
    defaultValue: "",
  )
  final String curr;

  @JsonKey(
    name: "dbtrAcct",
    defaultValue: "",
  )
  final String dbtrAcct;

  @JsonKey(
    name: "dbtrAddr",
    defaultValue: "",
  )
  final String dbtrAddr;

  @JsonKey(
    name: "dbtrAgt",
    defaultValue: "",
  )
  final String dbtrAgt;

  @JsonKey(
    name: "dbtrAlias",
    defaultValue: "",
  )
  final String dbtrAlias;

  @JsonKey(
    name: "dbtrIsIndvl",
    defaultValue: "",
  )
  final String dbtrIsIndvl;

  @JsonKey(
    name: "dbtrMCC",
    defaultValue: "",
  )
  final String dbtrMCC;

  @JsonKey(
    name: "dbtrName",
    defaultValue: "",
  )
  final String dbtrName;

  @JsonKey(
    name: "dbtrRecordID",
    defaultValue: "",
  )
  final String dbtrRecordID;

  @JsonKey(
    name: "errorCode",
  )
  final double errorCode;

  @JsonKey(
    name: "instrInfo",
    defaultValue: "",
  )
  final String instrInfo;

  @JsonKey(
    name: "msgID",
    defaultValue: "",
  )
  final String msgID;

  @JsonKey(
    name: "payRefNo",
    defaultValue: "",
  )
  final String payRefNo;

  @JsonKey(
    name: "processFlag",
    defaultValue: "",
  )
  final String processFlag;

  @JsonKey(
    name: "rgltryRptg",
    defaultValue: "",
  )
  final String rgltryRptg;

  @JsonKey(
    name: "rmtInf",
    defaultValue: "",
  )
  final String rmtInf;

  @JsonKey(
    name: "rtpDate",
    defaultValue: "",
  )
  final String rtpDate;

  @JsonKey(
    name: "statusDate",
    defaultValue: "",
  )
  final String statusDate;

  @JsonKey(
    name: "svcLvl",
    defaultValue: "",
  )
  final String svcLvl;

  @JsonKey(
    name: "trxDir",
    defaultValue: "",
  )
  final String trxDir;

  @JsonKey(
    name: "trxReason",
    defaultValue: "",
  )
  final String trxReason;

  @JsonKey(
    name: "trxStatus",
    defaultValue: "",
  )
  final String trxStatus;

  @JsonKey(
    name: "trxType",
    defaultValue: "",
  )
  final String trxType;

  @override
  RequestMoneyActivityList transform() {
    return RequestMoneyActivityList(
      msgID: this.msgID,
      trxType: this.trxType,
      trxDir: this.trxDir,
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
      addInfo2: this.addInfo2,
      addInfo3: this.addInfo3,
      addInfo4: this.addInfo4,
      trxStatus: this.trxStatus,
      trxReason: this.trxReason,
      processFlag: this.processFlag,
      rtpDate: this.rtpDate,
      statusDate: this.statusDate,
      payRefNo: this.payRefNo,
      errorCode: this.errorCode,
    );
  }

  Map<String, dynamic> toJson() =>
      _$RequestMoneyActivityListEntityToJson(this);
}
