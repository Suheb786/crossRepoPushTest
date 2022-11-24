import 'package:data/entity/remote/purpose/purpose_entity.dart';
import 'package:domain/model/purpose/transfer_purpose_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "transfer_purpose_response_entity.g.dart";

@JsonSerializable()
class TransferPurposeResponseEntity
    implements BaseLayerDataTransformer<TransferPurposeResponseEntity, TransferPurposeResponse> {
  @JsonKey(name: "purposes")
  final List<PurposeEntity>? purposes;

  TransferPurposeResponseEntity({this.purposes});

  factory TransferPurposeResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferPurposeResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferPurposeResponseEntityToJson(this);

  @override
  TransferPurposeResponseEntity restore(TransferPurposeResponse response) {
    return TransferPurposeResponseEntity();
  }

  @override
  TransferPurposeResponse transform() {
    return TransferPurposeResponse(
      purposes: this.purposes!.map((e) => e.transform()).toList(),
    );
  }
}
