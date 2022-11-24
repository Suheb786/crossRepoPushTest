import 'package:data/entity/remote/country/state_list/state_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_list_response_entity.g.dart';

@JsonSerializable()
class StateListResponseEntity
    implements BaseLayerDataTransformer<StateListResponseEntity, StateListResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  StateListResponseEntity({this.response});

  factory StateListResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$StateListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StateListResponseEntityToJson(this);

  @override
  StateListResponseEntity restore(StateListResponse response) {
    return StateListResponseEntity();
  }

  @override
  StateListResponse transform() {
    return StateListResponse(stateContent: StateContentEntity.fromJson(this.response!.content).transform());
  }
}
