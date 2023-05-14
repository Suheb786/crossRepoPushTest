import 'package:data/entity/remote/user/get_combo_values/get_combo_values_data_entity.dart';
import 'package:domain/model/card/get_credit_card_relationship/credit_card_relationship.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_credit_card_relationship_content_entity.g.dart";

@JsonSerializable()
class GetCreditCardRelationshipContentEntity
    extends BaseLayerDataTransformer<GetCreditCardRelationshipContentEntity, CreditCardRelationship> {
  @JsonKey(name: "relationship")
  final List<GetComboValuesDataEntity>? relationshipList;
  @JsonKey(name: "minLimit")
  final num? minLimit;
  @JsonKey(name: "maxLimit")
  final num? maxLimit;

  GetCreditCardRelationshipContentEntity({this.relationshipList, this.minLimit= 0.0, this.maxLimit= 0.0});

  factory GetCreditCardRelationshipContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetCreditCardRelationshipContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetCreditCardRelationshipContentEntityToJson(this);

  @override
  CreditCardRelationship transform() {
    return CreditCardRelationship(
        maxLimit: this.maxLimit ?? 0.0,
        minLimit: this.minLimit ?? 0.0,
        relationShip: this.relationshipList!.map((e) => e.transform()).toList());
  }
}
