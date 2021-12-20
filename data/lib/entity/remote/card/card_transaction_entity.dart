import 'package:data/entity/remote/card/transaction_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_transaction_entity.g.dart";

@JsonSerializable()
class CardTransactionEntity
    implements BaseLayerDataTransformer<CardTransactionEntity, String> {
  @JsonKey(name: "label")
  final String? date;
  @JsonKey(name: "transactions")
  final List<TransactionEntity>? transactions;

  CardTransactionEntity({this.date, this.transactions});

  factory CardTransactionEntity.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardTransactionEntityToJson(this);

  @override
  CardTransactionEntity restore(String response) {
    return CardTransactionEntity();
  }

  @override
  String transform() {
    return "";
  }
}
