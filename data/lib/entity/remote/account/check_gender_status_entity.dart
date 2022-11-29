import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_gender_status_entity.g.dart';

@JsonSerializable()
class CheckGenderStatusEntity
    implements BaseLayerDataTransformer<CheckGenderStatusEntity, AgentGenderStatus> {
  @JsonKey(name: "maleAvailable")
  final bool? isMaleAvailable;
  @JsonKey(name: "femaleAvailable")
  final bool? isFemaleAvailable;

  CheckGenderStatusEntity({this.isMaleAvailable: false, this.isFemaleAvailable: false});

  factory CheckGenderStatusEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckGenderStatusEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckGenderStatusEntityToJson(this);

  @override
  CheckGenderStatusEntity restore(AgentGenderStatus response) {
    return CheckGenderStatusEntity();
  }

  @override
  AgentGenderStatus transform() {
    return AgentGenderStatus(isExist: (isMaleAvailable ?? false) || (isFemaleAvailable ?? false));
  }
}
