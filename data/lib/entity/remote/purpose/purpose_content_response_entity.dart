import 'package:data/entity/remote/purpose/purpose_content_entity.dart';
import 'package:domain/model/purpose/purpose_content_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "purpose_content_response_entity.g.dart";

@JsonSerializable()
class PurposeContentResponseEntity
    implements
        BaseLayerDataTransformer<PurposeContentResponseEntity,
            PurposeContentResponse> {
  @JsonKey(name: "content")
  final PurposeContentEntity? purposeContentEntity;

  PurposeContentResponseEntity({this.purposeContentEntity});

  factory PurposeContentResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PurposeContentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeContentResponseEntityToJson(this);

  @override
  PurposeContentResponseEntity restore(PurposeContentResponse response) {
    return PurposeContentResponseEntity();
  }

  @override
  PurposeContentResponse transform() {
    return PurposeContentResponse(
      purposeContent: this.purposeContentEntity!.transform(),
    );
  }
}
