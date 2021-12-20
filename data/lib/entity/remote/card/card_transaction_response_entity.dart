import 'package:data/entity/remote/card/card_transaction_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_transaction_response_entity.g.dart";

@JsonSerializable()
class CardTransactionResponseEntity
    implements
        BaseLayerDataTransformer<CardTransactionResponseEntity, List<String>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CardTransactionResponseEntity({this.response});

  factory CardTransactionResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardTransactionResponseEntityToJson(this);

  @override
  CardTransactionResponseEntity restore(List<String> response) {
    return CardTransactionResponseEntity();
  }

  @override
  List<String> transform() {
    return (this.response!.content as List<CardTransactionEntity>)
        .map((e) => e.transform())
        .toList();
  }
}
