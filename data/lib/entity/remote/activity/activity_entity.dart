import 'package:domain/model/activity/activity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part "activity_entity.g.dart";

@JsonSerializable()
class ActivityEntity implements BaseLayerDataTransformer<ActivityEntity, Activity> {
  @JsonKey(name: "heading")
  final String? heading;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "headingAr")
  final String? headingAr;
  @JsonKey(name: "descriptionAr")
  final String? descriptionAr;

  ActivityEntity(
      {required this.headingAr,
      required this.descriptionAr,
      required this.description,
      required this.heading});

  factory ActivityEntity.fromJson(Map<String, dynamic> json) => _$ActivityEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityEntityToJson(this);

  @override
  ActivityEntity restore(Activity response) {
    return ActivityEntity(
        headingAr: headingAr, descriptionAr: descriptionAr, description: description, heading: heading);
  }

  @override
  Activity transform() {
    return Activity(
        heading: Intl.getCurrentLocale() == "en" ? this.heading : this.headingAr,
        description: Intl.getCurrentLocale() == "en" ? this.description : this.descriptionAr);
  }
}
