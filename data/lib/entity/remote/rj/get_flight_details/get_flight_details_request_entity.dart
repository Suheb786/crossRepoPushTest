import 'package:json_annotation/json_annotation.dart';

part "get_flight_details_request_entity.g.dart";

@JsonSerializable()
class GetFlightDetailsRequestEntity {
  @JsonKey(name: "ReferenceNumber")
  final String? referenceNumber;
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  GetFlightDetailsRequestEntity({required this.baseData, this.getToken= true, this.referenceNumber});

  factory GetFlightDetailsRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$GetFlightDetailsRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetFlightDetailsRequestEntityToJson(this);
}
