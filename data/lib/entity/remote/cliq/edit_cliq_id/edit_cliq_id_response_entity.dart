import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'edit_cliq_id_entity.dart';

part 'edit_cliq_id_response_entity.g.dart';

@JsonSerializable()
class EditCliqResponseEntity extends BaseLayerDataTransformer<EditCliqResponseEntity, EditCliq> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  EditCliqResponseEntity(this.response);

  factory EditCliqResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$EditCliqResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditCliqResponseEntityToJson(this);

  @override
  EditCliq transform() {
    return EditCliqEntity.fromJson(this.response!.content).transform();
  }
}
