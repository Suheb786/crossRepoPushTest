import 'package:json_annotation/json_annotation.dart';

part 'save_customer_schedule_time_request_entity.g.dart';

@JsonSerializable()
class SaveCustomerScheduleTimeRequestEntity {
  @JsonKey(name: "ScheduleTime")
  final String? scheduleTime;
  @JsonKey(name: "ScheduleDate")
  final String? scheduleDate;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveCustomerScheduleTimeRequestEntity(
      {this.scheduleDate, required this.baseData, this.scheduleTime});

  factory SaveCustomerScheduleTimeRequestEntity.fromJson(
      Map<String, dynamic> json) =>
      _$SaveCustomerScheduleTimeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SaveCustomerScheduleTimeRequestEntityToJson(this);
}
