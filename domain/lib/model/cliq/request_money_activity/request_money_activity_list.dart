class RequestMoneyActivityList {
  final String msgID;
  final String trxType;
  final String trxDir;
  final double amount;
  final String curr;
  final String svcLvl;
  final String ctgyPurp;
  final String dbtrAgt;
  final String dbtrAcct;
  final String dbtrName;
  final String dbtrAddr;
  final String dbtrIsIndvl;
  final String dbtrRecordID;
  final String dbtrAlias;
  final String dbtrMCC;
  final String cdtrAgt;
  final String cdtrAcct;
  final String cdtrName;
  final String cdtrAddr;
  final String cdtrIsIndvl;
  final String cdtrRecordID;
  final String cdtrAlias;
  final String cdtrMCC;
  final String instrInfo;
  final String rmtInf;
  final String rgltryRptg;
  final String addInfo1;
  final String addInfo2;
  final String addInfo3;
  final String addInfo4;
  final String trxStatus;
  final String trxReason;
  final String processFlag;
  final String rtpDate;
  final String statusDate;
  final String payRefNo;
  final double errorCode;

  RequestMoneyActivityList({
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
}
