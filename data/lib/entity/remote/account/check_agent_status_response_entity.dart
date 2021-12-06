import 'package:data/entity/remote/account/check_agent_status_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/check_agent_status_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_agent_status_response_entity.g.dart';

@JsonSerializable()
class CheckAgentStatusResponseEntity extends BaseLayerDataTransformer<
    CheckAgentStatusResponseEntity, CheckAgentStatusResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckAgentStatusResponseEntity(this.response);

  factory CheckAgentStatusResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckAgentStatusResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckAgentStatusResponseEntityToJson(this);

  @override
  CheckAgentStatusResponse transform() {
    return CheckAgentStatusResponse(
        checkAgentStatusContent:
            CheckAgentStatusContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
