import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'process_journey_request_entity.g.dart';

@JsonSerializable()
class ProcessJourneyRequestEntity {
  @JsonKey(name: 'RefID')
  String? refID;
  @JsonKey(name: 'JourneyID')
  String? journeyID;
  @JsonKey(name: 'BaseClass')
  Map<String, dynamic>? baseClass;

  ProcessJourneyRequestEntity({
    required this.refID,
    required this.journeyID,
    required this.baseClass,
  });

  factory ProcessJourneyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessJourneyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessJourneyRequestEntityToJson(this);
}
