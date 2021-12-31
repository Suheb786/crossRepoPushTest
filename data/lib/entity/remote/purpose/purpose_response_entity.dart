import 'package:data/entity/remote/purpose/purpose_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/purpose/purpose_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "purpose_response_entity.g.dart";

@JsonSerializable()
class PurposeResponseEntity
    implements
        BaseLayerDataTransformer<PurposeResponseEntity, PurposeResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  PurposeResponseEntity({this.response});

  factory PurposeResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PurposeResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeResponseEntityToJson(this);

  @override
  PurposeResponseEntity restore(PurposeResponse response) {
    return PurposeResponseEntity();
  }

  @override
  PurposeResponse transform() {
    return PurposeResponse(
        content:
            PurposeContentEntity.fromJson(this.response!.content).transform());
  }
}
