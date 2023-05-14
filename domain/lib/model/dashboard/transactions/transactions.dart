import 'package:domain/constants/enum/transaction_type_enum.dart';

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
      this.memo= "",
      this.type= TransactionTypeEnum.NONE,
      this.currency= ""});

  int? id;
  String? description;
  DateTime? time;
  num? amount;
  num? balance;
  String? balanceCur;
  String? amountCur;
  String? trnxType;
  String? memo;
  TransactionTypeEnum? type;
  String? currency;
}
