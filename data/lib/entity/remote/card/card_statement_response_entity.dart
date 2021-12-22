import 'package:data/entity/remote/card/card_statement_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/card_statement_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_statement_response_entity.g.dart";

@JsonSerializable()
class CardStatementResponseEntity
    implements
        BaseLayerDataTransformer<CardStatementResponseEntity,
            CardStatementResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CardStatementResponseEntity({this.response});

  factory CardStatementResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CardStatementResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardStatementResponseEntityToJson(this);

  @override
  CardStatementResponseEntity restore(CardStatementResponse response) {
    return CardStatementResponseEntity();
  }

  @override
  CardStatementResponse transform() {
    return CardStatementResponse(
        cardStatementContent:
            CardStatementContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
