import 'package:domain/model/apple_pay/enroll_card_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enroll_card_content_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class EnrollCardContentEntity extends BaseLayerDataTransformer<EnrollCardContentEntity, EnrollCardContent> {
  @JsonKey(name: "enrollmentData")
  final String? enrollmentData;

  @JsonKey(name: "cardId")
  final String? cardId;

  EnrollCardContentEntity({this.cardId, this.enrollmentData});

  factory EnrollCardContentEntity.fromJson(Map<String, dynamic> json) =>
      _$EnrollCardContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EnrollCardContentEntityToJson(this);

  @override
  EnrollCardContent transform() {
    return EnrollCardContent(enrollmentData: this.enrollmentData ?? '', cardId: this.cardId ?? '');
  }
}
