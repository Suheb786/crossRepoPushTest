import 'package:data/entity/remote/purpose/transfer_purpose_response_entity.dart';
import 'package:domain/model/purpose/purpose_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "purpose_content_entity.g.dart";

@JsonSerializable()
class PurposeContentEntity implements BaseLayerDataTransformer<PurposeContentEntity, PurposeContent> {
  @JsonKey(name: "transferPurposeResponse")
  final TransferPurposeResponseEntity? transferPurposeResponse;

  PurposeContentEntity({this.transferPurposeResponse});

  factory PurposeContentEntity.fromJson(Map<String, dynamic> json) => _$PurposeContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PurposeContentEntityToJson(this);

  @override
  PurposeContentEntity restore(PurposeContent response) {
    return PurposeContentEntity();
  }

  @override
  PurposeContent transform() {
    return PurposeContent(
      transferPurposeResponse: this.transferPurposeResponse!.transform(),
    );
  }
}
