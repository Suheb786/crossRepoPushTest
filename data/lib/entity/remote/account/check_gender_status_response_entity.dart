import 'package:data/entity/remote/account/check_gender_status_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/account/agent_gender_status.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_gender_status_response_entity.g.dart';

@JsonSerializable()
class CheckGenderResponseEntity
    extends BaseLayerDataTransformer<CheckGenderResponseEntity, AgentGenderStatus> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  CheckGenderResponseEntity(this.response);

  factory CheckGenderResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckGenderResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckGenderResponseEntityToJson(this);

  @override
  AgentGenderStatus transform() {
    return CheckGenderStatusEntity.fromJson(response!.content['data'] as Map<String, dynamic>).transform();
  }
}
