import 'package:json_annotation/json_annotation.dart';
part 'update_journey_request_entity.g.dart';

@JsonSerializable()
class UpdateJourneyRequestEntity {
  @JsonKey(name: 'UserID')
  String? userID;
  @JsonKey(name: 'RefID')
  String? refID;
  @JsonKey(name: 'JourneyID')
  String? journeyID;
  @JsonKey(name: 'Status')
  String? status;
  @JsonKey(name: 'BaseClass')
  Map<String, dynamic>? baseClass;

  UpdateJourneyRequestEntity({
    required this.userID,
    required this.refID,
    required this.journeyID,
    required this.status,
    required this.baseClass,
  });

  factory UpdateJourneyRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateJourneyRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateJourneyRequestEntityToJson(this);
}
