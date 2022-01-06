import 'package:domain/model/country/state_list/state_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_data_entity.g.dart';

@JsonSerializable()
class StateDataEntity
    implements BaseLayerDataTransformer<StateDataEntity, StateData> {
  @JsonKey(name: "createTime")
  final DateTime? createTime;
  @JsonKey(name: "countryID")
  final String? countryID;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "stateName")
  final String? stateName;

  StateDataEntity(
      {this.createTime,
      this.countryID: "",
      this.stateID: "",
      this.stateName: ""});

  factory StateDataEntity.fromJson(Map<String, dynamic> json) =>
      _$StateDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StateDataEntityToJson(this);

  @override
  StateDataEntity restore(StateData response) {
    return StateDataEntity();
  }

  @override
  StateData transform() {
    return StateData(
        createTime: this.createTime,
        countryId: this.countryID,
        stateId: this.stateID,
        stateName: this.stateName);
  }
}
