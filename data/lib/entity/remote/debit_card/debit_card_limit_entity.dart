import 'package:domain/model/debit_card/debit_card_limit.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "debit_card_limit_entity.g.dart";

@JsonSerializable()
class DebitCardLimitEntity
    implements BaseLayerDataTransformer<DebitCardLimitEntity, DebitCardLimit> {
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "minLimit")
  String? minLimit;
  @JsonKey(name: "currentLimit")
  String? currentLimit;
  @JsonKey(name: "maxLimit")
  String? maxLimit;

  DebitCardLimitEntity(
      {this.description, this.minLimit, this.maxLimit, this.currentLimit});

  factory DebitCardLimitEntity.fromJson(Map<String, dynamic> json) =>
      _$DebitCardLimitEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DebitCardLimitEntityToJson(this);

  @override
  DebitCardLimitEntity restore(DebitCardLimit response) {
    return DebitCardLimitEntity();
  }

  @override
  DebitCardLimit transform() {
    return DebitCardLimit(
        description: this.description ?? '',
        currentLimit: this.currentLimit ?? '',
        maxLimit: this.maxLimit ?? '',
        minLimit: this.minLimit ?? '');
  }
}
