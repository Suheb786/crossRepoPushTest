import 'package:json_annotation/json_annotation.dart';

part 'save_customer_schedule_time_request_entity.g.dart';

@JsonSerializable()
class SaveCustomerScheduleTimeRequestEntity {
  @JsonKey(name: "callDate")
  final String? callDate;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "startTime")
  final String? startTime;
  @JsonKey(name: "dateToSend")
  final int? dateToSend;
  @JsonKey(name: "productId")
  final int? productId;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveCustomerScheduleTimeRequestEntity(
      {this.callDate,
      this.gender = "",
      this.startTime,
      this.dateToSend,
      this.productId = 1,
      this.getToken = true,
      required this.baseData});

  factory SaveCustomerScheduleTimeRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$SaveCustomerScheduleTimeRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SaveCustomerScheduleTimeRequestEntityToJson(this);
}
