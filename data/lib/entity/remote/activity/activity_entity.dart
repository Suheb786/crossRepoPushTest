import 'package:domain/model/activity/activity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "activity_entity.g.dart";

@JsonSerializable()
class ActivityEntity implements BaseLayerDataTransformer<ActivityEntity, Activity> {
  @JsonKey(name: "heading")
  final String? heading;
  @JsonKey(name: "description")
  final String? description;

  ActivityEntity({this.description, this.heading});

  factory ActivityEntity.fromJson(Map<String, dynamic> json) => _$ActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityEntityToJson(this);

  @override
  ActivityEntity restore(Activity response) {
    return ActivityEntity();
  }

  @override
  Activity transform() {
    return Activity(heading: this.heading, description: this.description);
  }
}
