class RequestToPayContent {
  RequestToPayContent({
    this.custId,
    this.senderName,
    this.senderPstlAdr,
    this.dbtrBic,
    this.dbtrAcct,
    this.dbtrName,
    this.dbtrPstlAdr,
    this.dbtrIsIndvl,
    this.dbtrRecordId,
    this.dbtrAlias,
    this.dbtrMcc,
    this.cdtrAcct,
    this.cdtrName,
    this.cdtrPstlAdr,
    this.cdtrIsIndvl,
    this.cdtrRecordId,
    this.cdtrAlias,
    this.cdtrMcc,
    this.instrInf,
    this.rgltryRptg,
    this.rmtInf,
    this.ctgyPurp,
    this.curr,
    this.amount,
    this.payRefNo,
  });

  String? custId;
  String? senderName;
  String? senderPstlAdr;
  String? dbtrBic;
  String? dbtrAcct;
  String? dbtrName;
  String? dbtrPstlAdr;
  String? dbtrIsIndvl;
  String? dbtrRecordId;
  String? dbtrAlias;
  String? dbtrMcc;
  String? cdtrAcct;
  String? cdtrName;
  String? cdtrPstlAdr;
  String? cdtrIsIndvl;
  String? cdtrRecordId;
  String? cdtrAlias;
  String? cdtrMcc;
  String? instrInf;
  String? rgltryRptg;
  String? rmtInf;
  String? ctgyPurp;
  String? curr;
  String? amount;
  String? payRefNo;

  factory RequestToPayContent.fromJson(Map<String, dynamic> json) =>
      RequestToPayContent(
        custId: json["custID"],
        senderName: json["senderName"],
        senderPstlAdr: json["senderPstlAdr"],
        dbtrBic: json["dbtrBic"],
        dbtrAcct: json["dbtrAcct"],
        dbtrName: json["dbtrName"],
        dbtrPstlAdr: json["dbtrPstlAdr"],
        dbtrIsIndvl: json["dbtrIsIndvl"],
        dbtrRecordId: json["dbtrRecordID"],
        dbtrAlias: json["dbtrAlias"],
        dbtrMcc: json["dbtrMCC"],
        cdtrAcct: json["cdtrAcct"],
        cdtrName: json["cdtrName"],
        cdtrPstlAdr: json["cdtrPstlAdr"],
        cdtrIsIndvl: json["cdtrIsIndvl"],
        cdtrRecordId: json["cdtrRecordID"],
        cdtrAlias: json["cdtrAlias"],
        cdtrMcc: json["cdtrMCC"],
        instrInf: json["instrInf"],
        rgltryRptg: json["rgltryRptg"],
        rmtInf: json["rmtInf"],
        ctgyPurp: json["ctgyPurp"],
        curr: json["curr"],
        amount: json["amount"],
        payRefNo: json["payRefNo"],
      );

  Map<String, dynamic> toJson() => {
        "custID": custId,
        "senderName": senderName,
        "senderPstlAdr": senderPstlAdr,
        "dbtrBic": dbtrBic,
        "dbtrAcct": dbtrAcct,
        "dbtrName": dbtrName,
        "dbtrPstlAdr": dbtrPstlAdr,
        "dbtrIsIndvl": dbtrIsIndvl,
        "dbtrRecordID": dbtrRecordId,
        "dbtrAlias": dbtrAlias,
        "dbtrMCC": dbtrMcc,
        "cdtrAcct": cdtrAcct,
        "cdtrName": cdtrName,
        "cdtrPstlAdr": cdtrPstlAdr,
        "cdtrIsIndvl": cdtrIsIndvl,
        "cdtrRecordID": cdtrRecordId,
        "cdtrAlias": cdtrAlias,
        "cdtrMCC": cdtrMcc,
        "instrInf": instrInf,
        "rgltryRptg": rgltryRptg,
        "rmtInf": rmtInf,
        "ctgyPurp": ctgyPurp,
        "curr": curr,
        "amount": amount,
        "payRefNo": payRefNo,
      };
}
