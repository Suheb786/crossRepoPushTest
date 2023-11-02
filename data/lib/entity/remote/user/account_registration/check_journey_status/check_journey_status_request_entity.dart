import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'check_journey_status_request_entity.g.dart';

@JsonSerializable()
class CheckJourneyStatusRequestEntity {
  @JsonKey(name: 'ReferenceId')
  final String? referenceId;

  @JsonKey(name: 'journeyId')
  final String? journeyId;

  @JsonKey(name: "GetToken")
  final bool? getToken;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;


  CheckJourneyStatusRequestEntity({
    required this.referenceId,
    required this.journeyId,
    required this.baseData,
    required this.getToken
  });

  factory CheckJourneyStatusRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckJourneyStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckJourneyStatusRequestEntityToJson(this);
}
