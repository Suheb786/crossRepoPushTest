import 'package:data/entity/remote/country/state_list/state_data_entity.dart';
import 'package:domain/model/country/state_list/state_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_content_entity.g.dart';

@JsonSerializable()
class StateContentEntity
    implements BaseLayerDataTransformer<StateContentEntity, StateContent> {
  @JsonKey(name: "getStates")
  final List<StateCityDataEntity>? getStates;

  StateContentEntity({this.getStates});

  factory StateContentEntity.fromJson(Map<String, dynamic> json) =>
      _$StateContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StateContentEntityToJson(this);

  @override
  StateContentEntity restore(StateContent response) {
    return StateContentEntity();
  }

  @override
  StateContent transform() {
    return StateContent(
        stateData: this.getStates!.map((e) => e.transform()).toList());
  }
}
