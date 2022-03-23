class Transactions {
  Transactions(
      {this.id,
      this.description,
      this.time,
      this.amount,
      this.balance,
      this.balanceCur,
      this.amountCur,
      this.trnxType,
      this.memo: ""});

  int? id;
  String? description;
  DateTime? time;
  num? amount;
  num? balance;
  String? balanceCur;
  String? amountCur;
  String? trnxType;
  String? memo;
}
