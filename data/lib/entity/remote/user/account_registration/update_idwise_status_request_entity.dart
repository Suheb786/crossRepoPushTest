import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_idwise_status_request_entity.g.dart';

@JsonSerializable()
class UpdateIDWiseStatusRequestEntity {
  @JsonKey(name: 'RefID')
  String? refID;
  @JsonKey(name: 'JourneyID')
  String? journeyID;
  @JsonKey(name: 'BaseClass')
  Map<String, dynamic>? baseClass;

  UpdateIDWiseStatusRequestEntity({
    required this.refID,
    required this.journeyID,
    required this.baseClass,
  });

  factory UpdateIDWiseStatusRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$UpdateIDWiseStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateIDWiseStatusRequestEntityToJson(this);
}
