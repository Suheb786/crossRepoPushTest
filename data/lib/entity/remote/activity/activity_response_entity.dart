import 'package:data/entity/remote/activity/activity_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/activity/activity_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "activity_response_entity.g.dart";

@JsonSerializable()
class ActivityResponseEntity implements BaseLayerDataTransformer<ActivityResponseEntity, ActivityResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ActivityResponseEntity({this.response});

  factory ActivityResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ActivityResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityResponseEntityToJson(this);

  @override
  ActivityResponseEntity restore(ActivityResponse response) {
    return ActivityResponseEntity();
  }

  @override
  ActivityResponse transform() {
    return ActivityResponse(
        activityContent: ActivityContentEntity.fromJson(this.response!.content).transform());
  }
}
