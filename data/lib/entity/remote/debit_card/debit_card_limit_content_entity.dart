import 'package:data/entity/remote/debit_card/debit_card_limit_entity.dart';
import 'package:domain/model/debit_card/debit_card_limit_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "debit_card_limit_content_entity.g.dart";

@JsonSerializable()
class DebitCardLimitContentEntity
    implements
        BaseLayerDataTransformer<DebitCardLimitContentEntity,
            DebitCardLimitContent> {
  @JsonKey(name: "limits")
  List<DebitCardLimitEntity>? limits;

  DebitCardLimitContentEntity({this.limits});

  factory DebitCardLimitContentEntity.fromJson(Map<String, dynamic> json) =>
      _$DebitCardLimitContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DebitCardLimitContentEntityToJson(this);

  @override
  DebitCardLimitContentEntity restore(DebitCardLimitContent response) {
    return DebitCardLimitContentEntity();
  }

  @override
  DebitCardLimitContent transform() {
    return DebitCardLimitContent(
        limits: this.limits!.map((e) => e.transform()).toList());
  }
}
