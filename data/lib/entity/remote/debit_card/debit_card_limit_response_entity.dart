import 'package:data/entity/remote/debit_card/debit_card_limit_content_entity.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "debit_card_limit_response_entity.g.dart";

@JsonSerializable()
class DebitCardLimitResponseEntity
    implements
        BaseLayerDataTransformer<DebitCardLimitResponseEntity,
            DebitCardLimitResponse> {
  @JsonKey(name: "content")
  final DebitCardLimitContentEntity? debitCardLimitContentEntity;

  DebitCardLimitResponseEntity({this.debitCardLimitContentEntity});

  factory DebitCardLimitResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DebitCardLimitResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DebitCardLimitResponseEntityToJson(this);

  @override
  DebitCardLimitResponseEntity restore(DebitCardLimitResponse response) {
    return DebitCardLimitResponseEntity();
  }

  @override
  DebitCardLimitResponse transform() {
    return DebitCardLimitResponse(
      debitCardLimitContent: this.debitCardLimitContentEntity!.transform(),
    );
  }
}
