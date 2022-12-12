import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'confirm_create_cliq_id_entity.dart';

part 'confirm_create_cliq_id_response_entity.g.dart';

@JsonSerializable()
class ConfirmCreateCliqIdResponseEntity
    extends BaseLayerDataTransformer<ConfirmCreateCliqIdResponseEntity, ConfirmCreateCliqId> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ConfirmCreateCliqIdResponseEntity(this.response);

  factory ConfirmCreateCliqIdResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCreateCliqIdResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmCreateCliqIdResponseEntityToJson(this);

  @override
  ConfirmCreateCliqId transform() {
    return ConfirmCreateCliqIdEntity.fromJson(this.response!.content).transform();
  }
}
