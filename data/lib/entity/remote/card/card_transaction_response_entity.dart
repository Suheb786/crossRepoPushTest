import 'package:data/entity/remote/card/card_transaction_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/dashboard/transactions/get_transactions_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_transaction_response_entity.g.dart";

@JsonSerializable()
class CardTransactionResponseEntity
    implements BaseLayerDataTransformer<CardTransactionResponseEntity, GetTransactionsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CardTransactionResponseEntity({this.response});

  factory CardTransactionResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CardTransactionResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardTransactionResponseEntityToJson(this);

  @override
  CardTransactionResponseEntity restore(GetTransactionsResponse response) {
    return CardTransactionResponseEntity();
  }

  @override
  GetTransactionsResponse transform() {
    return GetTransactionsResponse(
        transactionResponse: (this.response!.content as List<dynamic>)
            .map((e) => CardTransactionEntity.fromJson(e).transform())
            .toList());
  }
}
