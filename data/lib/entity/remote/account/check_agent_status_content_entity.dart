import 'package:domain/model/account/check_agent_status_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_agent_status_content_entity.g.dart';

@JsonSerializable()
class CheckAgentStatusContentEntity
    implements
        BaseLayerDataTransformer<CheckAgentStatusContentEntity,
            CheckAgentStatusContent> {
  @JsonKey(name: "status")
  final bool? status;

  CheckAgentStatusContentEntity({this.status});

  factory CheckAgentStatusContentEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckAgentStatusContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAgentStatusContentEntityToJson(this);

  @override
  CheckAgentStatusContentEntity restore(CheckAgentStatusContent response) {
    return CheckAgentStatusContentEntity();
  }

  @override
  CheckAgentStatusContent transform() {
    return CheckAgentStatusContent(status: this.status);
  }
}
