import 'package:data/entity/remote/card/card_issuance_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_issuance_response_entity.g.dart";

@JsonSerializable()
class CardIssuanceResponseEntity
    implements BaseLayerDataTransformer<CardIssuanceResponseEntity, CardIssuanceDetails> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CardIssuanceResponseEntity({this.response});

  factory CardIssuanceResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CardIssuanceResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardIssuanceResponseEntityToJson(this);

  @override
  CardIssuanceResponseEntity restore(CardIssuanceDetails response) {
    return CardIssuanceResponseEntity();
  }

  @override
  CardIssuanceDetails transform() {
    return CardIssuanceEntity.fromJson(this.response!.content).transform();
  }
}
