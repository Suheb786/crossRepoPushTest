import 'package:json_annotation/json_annotation.dart';

part 'get_time_slots_request.g.dart';

@JsonSerializable()
class GetTimeSlotsRequest {
  @JsonKey(name: "callDate")
  final String? callDate;
  @JsonKey(name: "dateToSend")
  final int? dateToSend;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetTimeSlotsRequest({this.gender = "", required this.baseData, this.callDate, this.dateToSend});

  factory GetTimeSlotsRequest.fromJson(Map<String, dynamic> json) => _$GetTimeSlotsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetTimeSlotsRequestToJson(this);
}
