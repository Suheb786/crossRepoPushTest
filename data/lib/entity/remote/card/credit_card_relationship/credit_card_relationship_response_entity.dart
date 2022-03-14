import 'package:data/entity/remote/card/credit_card_relationship/get_credit_card_relationship_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/get_credit_card_relationship/credit_card_relationship_respponse.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "credit_card_relationship_response_entity.g.dart";

@JsonSerializable()
class CreditCardRelationshipResponseEntity extends BaseLayerDataTransformer<
    CreditCardRelationshipResponseEntity, CreditCardRelationshipResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CreditCardRelationshipResponseEntity({this.response});

  factory CreditCardRelationshipResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$CreditCardRelationshipResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreditCardRelationshipResponseEntityToJson(this);

  @override
  CreditCardRelationshipResponse transform() {
    return CreditCardRelationshipResponse(
        cardRelationship: GetCreditCardRelationshipContentEntity.fromJson(
                this.response!.content)
            .transform());
  }
}
