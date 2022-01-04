import 'package:domain/model/card/card_issuance_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "card_issuance_entity.g.dart";

@JsonSerializable()
class CardIssuanceEntity
    implements
        BaseLayerDataTransformer<CardIssuanceEntity, CardIssuanceDetails> {
  @JsonKey(name: "cardNumber")
  final String? cardNumber;
  @JsonKey(name: "pan")
  final String? pan;
  @JsonKey(name: "nameOnCard")
  final String? nameOnCard;

  CardIssuanceEntity({this.nameOnCard, this.cardNumber, this.pan});

  factory CardIssuanceEntity.fromJson(Map<String, dynamic> json) =>
      _$CardIssuanceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CardIssuanceEntityToJson(this);

  @override
  CardIssuanceEntity restore(CardIssuanceDetails response) {
    return CardIssuanceEntity();
  }

  @override
  CardIssuanceDetails transform() {
    return CardIssuanceDetails(
        cardHolderName: nameOnCard ?? "-", cardNumber: cardNumber ?? "");
  }
}
