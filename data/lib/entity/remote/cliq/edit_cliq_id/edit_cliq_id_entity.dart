import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_cliq_id_entity.g.dart';

@JsonSerializable()
class EditCliqEntity implements BaseLayerDataTransformer<EditCliqEntity, EditCliq> {
  @JsonKey(name: "isSuccess", defaultValue: false)
  final bool? isSuccess;

  @JsonKey(name: "message", defaultValue: '')
  final String? message;

  EditCliqEntity(this.message, this.isSuccess);

  factory EditCliqEntity.fromJson(Map<String, dynamic> json) => _$EditCliqEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EditCliqEntityToJson(this);

  @override
  EditCliqEntity restore(EditCliq data) {
    throw UnimplementedError();
  }

  @override
  EditCliq transform() {
    return EditCliq(this.message, this.isSuccess);
  }
}
