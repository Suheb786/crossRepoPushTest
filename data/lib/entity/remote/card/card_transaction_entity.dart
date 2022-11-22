import 'package:data/entity/remote/card/transaction_entity.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_transaction_entity.g.dart";

@JsonSerializable()
class CardTransactionEntity implements BaseLayerDataTransformer<CardTransactionEntity, TransactionContent> {
  @JsonKey(name: "label")
  final String? date;
  @JsonKey(name: "transactions")
  final List<TransactionEntity>? transactions;

  CardTransactionEntity({this.date, this.transactions});

  factory CardTransactionEntity.fromJson(Map<String, dynamic> json) => _$CardTransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardTransactionEntityToJson(this);

  @override
  CardTransactionEntity restore(TransactionContent response) {
    return CardTransactionEntity();
  }

  @override
  TransactionContent transform() {
    return TransactionContent(
        label: this.date ?? '', transactions: this.transactions!.map((e) => e.transform()).toList());
  }
}
