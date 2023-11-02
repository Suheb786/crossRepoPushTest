import 'package:json_annotation/json_annotation.dart';
part 'process_journey_via_mobile_request_Entity.g.dart';

@JsonSerializable()
class ProcessJourneyViaMobileRequestEntity {
  @JsonKey(
    name: "journeyId",
    defaultValue: "",
  )
  final String? JourneyId;
  @JsonKey(
    name: "ReferenceId", // this Param need confirm from Backend
    defaultValue: "",
  )
  final String? ReferenceID;
  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ProcessJourneyViaMobileRequestEntity({
    required this.JourneyId,
    required this.ReferenceID,
    required this.getToken,
    required this.baseData
  });

  factory ProcessJourneyViaMobileRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessJourneyViaMobileRequestEntityFromJson(json);
  Map<String, dynamic> toJson() => _$ProcessJourneyViaMobileRequestEntityToJson(this);
}
