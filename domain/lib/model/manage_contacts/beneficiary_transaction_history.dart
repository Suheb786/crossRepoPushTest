import 'package:domain/constants/enum/payment_type_enum.dart';
import 'package:domain/constants/enum/request_money_activity_enum.dart';

class BeneficiaryTransactionHistory {
  final String? rmtInf;
  final String? msgID;
  final double? amount;
  final String? creDtTm;
  final String? processFlag;
  final String? cdtrRecordID;
  final String? trxReason;
  final String? trxType;
  final String? dbtrAgt;
  final String? dbtrAlias;
  final bool? returnStatus;
  final String? ctgyPurp;
  final String? returnDate;
  final String? intrBkSttlmDt;
  final String? payRefNo;
  final String? rtpDate;
  final String? addInfo4;
  final String? cdtrMCC;
  final String? dbtrMCC;
  final String? cdtrIsIndvl;
  final String? dbtrAddr;
  final String? cdtrAlias;
  final String? cdtrName;
  final String? dbtrRecordID;
  final String? dbtrIsIndvl;
  final double? returnAmount;
  final String? cdtrAddr;
  final RequestMoneyActivityStatusEnum? trxStatus;
  final String? rgltryRptg;
  final String? instrInfo;
  final String? curr;
  final String? svcLvl;
  final RequestMoneyActivityStatusEnum? trxDir;
  final String? dbtrAcct;
  final String? dbtrName;
  final String? cdtrAcct;
  final String? cdtrAgt;
  final String? addInfo1;
  final bool? allowReturn;
  final bool? isFullReturn;
  final String? statusDate;
  final String? addInfo3;
  final String? paymentDate;
  final num? errorCode;
  final PaymentTypeEnum? paymentType;
  final String? activityDate;

  BeneficiaryTransactionHistory(
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
}
