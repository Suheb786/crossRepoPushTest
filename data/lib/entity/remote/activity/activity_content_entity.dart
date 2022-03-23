import 'package:data/entity/remote/activity/activity_entity.dart';
import 'package:domain/model/activity/activity_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "activity_content_entity.g.dart";

@JsonSerializable()
class ActivityContentEntity
    implements
        BaseLayerDataTransformer<ActivityContentEntity, ActivityContent> {
  @JsonKey(name: "activities")
  final List<ActivityEntity>? activityContent;

  ActivityContentEntity({this.activityContent});

  factory ActivityContentEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityContentEntityToJson(this);

  @override
  ActivityContentEntity restore(ActivityContent response) {
    return ActivityContentEntity();
  }

  @override
  ActivityContent transform() {
    return ActivityContent(
      activities: this
          .activityContent!
          .map((e) => e.transform())
          .toList()
          .reversed
          .toList(),
    );
  }
}
